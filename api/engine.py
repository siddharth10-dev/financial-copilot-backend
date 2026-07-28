import calendar
import logging
from datetime import datetime
from uuid import UUID
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from supabase import Client
from services.supabase_db import get_db

# Setup structured logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

router = APIRouter(tags=["Engine"])

# --- Strict Pydantic Models ---
class SafeToSpendResponse(BaseModel):
    safe_to_spend_pence: int
    currency: str = "GBP"

class AffordabilityRequest(BaseModel):
    item_name: str = Field(..., min_length=1, max_length=100)
    # Prevent users from passing negative costs to trick the math
    cost_pence: int = Field(..., gt=0, description="Cost must be greater than 0 pence") 

class AffordabilityResponse(BaseModel):
    verdict: str
    impact_percentage: float
    safe_to_spend_after_pence: int
    reasoning: str

# --- Core Math Function (Production Grade) ---
def calculate_safe_to_spend(user_id: UUID, db: Client) -> int:
    """The single source of truth for available capital."""
    try:
        accounts = db.table("accounts").select("current_balance_pence").eq("user_id", str(user_id)).execute()
        total_balance = sum(acc["current_balance_pence"] for acc in (accounts.data or []))
        
        goals = db.table("goals").select("current_balance_pence").eq("user_id", str(user_id)).execute()
        locked_savings = sum(goal["current_balance_pence"] for goal in (goals.data or []))
        
        return total_balance - locked_savings
        
    except Exception as e:
        logger.error(f"Database error calculating safe-to-spend for user {user_id}: {str(e)}")
        raise HTTPException(status_code=500, detail="Internal server error while calculating financials.")

# --- Endpoints ---
@router.get("/safe-to-spend/{user_id}", response_model=SafeToSpendResponse)
def get_safe_to_spend(user_id: UUID, db: Client = Depends(get_db)):
    safe_pence = calculate_safe_to_spend(user_id, db)
    return SafeToSpendResponse(safe_to_spend_pence=safe_pence)

@router.post("/affordability/{user_id}", response_model=AffordabilityResponse)
def check_affordability(user_id: UUID, request: AffordabilityRequest, db: Client = Depends(get_db)):
    current_safe_pence = calculate_safe_to_spend(user_id, db)
    cost = request.cost_pence
    
    # Prevent division by zero if they are completely broke
    if current_safe_pence <= 0:
        return AffordabilityResponse(
            verdict="NO",
            impact_percentage=100.0,
            safe_to_spend_after_pence=current_safe_pence - cost,
            reasoning="You have £0 safe-to-spend remaining."
        )
        
    impact = round((cost / current_safe_pence) * 100, 1)
    safe_after = current_safe_pence - cost
    
    # Condition A: Hard No (Overdraft territory)
    if cost > current_safe_pence:
        return AffordabilityResponse(
            verdict="NO",
            impact_percentage=impact,
            safe_to_spend_after_pence=safe_after,
            reasoning="This exceeds your current safe-to-spend limit."
        )
        
    # Time-based burn rate calculation
    now = datetime.now()
    _, days_in_month = calendar.monthrange(now.year, now.month)
    days_left = days_in_month - now.day + 1 # Include today
    
    weekly_allowance = (current_safe_pence / days_left) * 7
    
    # Condition B: Warning (Eats more than 1 week's worth of remaining budget)
    if cost > weekly_allowance:
        return AffordabilityResponse(
            verdict="WARNING",
            impact_percentage=impact,
            safe_to_spend_after_pence=safe_after,
            reasoning=f"Affordable, but consumes more than a week's worth of your remaining budget ({days_left} days left in month)."
        )
        
    # Condition C: Green Light
    return AffordabilityResponse(
        verdict="YES",
        impact_percentage=impact,
        safe_to_spend_after_pence=safe_after,
        reasoning="Well within your healthy daily spending limits."
    )
