import logging
from uuid import UUID
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from supabase import Client
from services.supabase_db import get_db
from typing import Optional

logger = logging.getLogger(__name__)
router = APIRouter(tags=["Goals"])

class GoalCreate(BaseModel):
    name: str = Field(..., min_length=1)
    target_amount_pence: int = Field(..., gt=0)
    target_date: Optional[str] = None  # Format: YYYY-MM-DD

@router.get("/{user_id}")
def get_goals(user_id: UUID, db: Client = Depends(get_db)):
    try:
        response = db.table("goals").select("*").eq("user_id", str(user_id)).execute()
        return {"data": response.data}
    except Exception as e:
        logger.error(f"Error fetching goals: {str(e)}")
        raise HTTPException(status_code=500, detail="Database error")

@router.post("/{user_id}")
def create_goal(user_id: UUID, goal: GoalCreate, db: Client = Depends(get_db)):
    try:
        new_goal = {
            "user_id": str(user_id),
            "name": goal.name,
            "target_amount_pence": goal.target_amount_pence,
            "current_balance_pence": 0,
            "target_date": goal.target_date
        }
        response = db.table("goals").insert(new_goal).execute()
        return {"message": "Goal created", "data": response.data[0]}
    except Exception as e:
        logger.error(f"Error creating goal: {str(e)}")
        raise HTTPException(status_code=500, detail="Database error")
