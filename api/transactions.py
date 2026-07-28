import logging
from uuid import UUID
from fastapi import APIRouter, HTTPException, Depends
from supabase import Client
from services.supabase_db import get_db

logger = logging.getLogger(__name__)
router = APIRouter(tags=["Transactions"])

@router.get("/{user_id}")
def get_recent_transactions(user_id: UUID, limit: int = 50, db: Client = Depends(get_db)):
    try:
        # 1. Get all account IDs for this user
        accounts = db.table("accounts").select("id").eq("user_id", str(user_id)).execute()
        account_ids = [acc["id"] for acc in (accounts.data or [])]
        
        if not account_ids:
            return {"data": []}
            
        # 2. Fetch transactions for those accounts, ordered by newest
        # We also join the categories table to get the category name directly
        transactions = (db.table("transactions")
                        .select("*, categories(name)")
                        .in_("account_id", account_ids)
                        .order("date", desc=True)
                        .limit(limit)
                        .execute())
        
        return {"data": transactions.data}
    except Exception as e:
        logger.error(f"Error fetching transactions: {str(e)}")
        raise HTTPException(status_code=500, detail="Database error")
