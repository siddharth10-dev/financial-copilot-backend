import logging
from uuid import UUID
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from supabase import Client
from services.supabase_db import get_db

logger = logging.getLogger(__name__)
router = APIRouter(tags=["Budgets"])

class BudgetSet(BaseModel):
    category_id: UUID
    monthly_limit_pence: int = Field(..., gt=0)
    month_year: str = Field(..., description="Format: YYYY-MM")

@router.get("/{user_id}")
def get_budgets(user_id: UUID, month_year: str, db: Client = Depends(get_db)):
    try:
        # Supabase join: fetches the budget limit AND the category name in one query
        response = db.table("budgets").select("*, categories(name, type)").eq("user_id", str(user_id)).eq("month_year", month_year).execute()
        return {"data": response.data}
    except Exception as e:
        logger.error(f"Error fetching budgets: {str(e)}")
        raise HTTPException(status_code=500, detail="Database error")

@router.post("/{user_id}")
def upsert_budget(user_id: UUID, budget: BudgetSet, db: Client = Depends(get_db)):
    try:
        budget_data = {
            "user_id": str(user_id),
            "category_id": str(budget.category_id),
            "monthly_limit_pence": budget.monthly_limit_pence,
            "month_year": budget.month_year
        }
        # Upsert ensures if a user edits their limit mid-month, it updates instead of duplicating
        response = db.table("budgets").upsert(budget_data, on_conflict="user_id, category_id, month_year").execute()
        return {"message": "Budget set", "data": response.data[0]}
    except Exception as e:
        logger.error(f"Error setting budget: {str(e)}")
        raise HTTPException(status_code=500, detail="Database error")
