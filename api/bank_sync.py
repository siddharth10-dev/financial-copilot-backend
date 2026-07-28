import logging
from uuid import UUID
from datetime import datetime, timedelta
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from supabase import Client
from services.supabase_db import get_db

logger = logging.getLogger(__name__)
router = APIRouter(tags=["Bank Sync (Account Aggregator)"])

# --- Pydantic Models ---
class ConsentRequest(BaseModel):
    phone_number: str

class WebhookPayload(BaseModel):
    consent_id: str
    status: str
    user_id: UUID

# --- 1. Generate Consent Link ---
@router.post("/consent/{user_id}")
def request_bank_sync(user_id: UUID, request: ConsentRequest):
    """
    In production, this calls Setu's API to generate a consent URL.
    For our sandbox, we mock the generated approval link.
    """
    # Mock Setu API Response
    mock_consent_id = f"aa-consent-{str(user_id)[:8]}"
    mock_approval_url = f"https://sandbox.setu.co/aa/consent/{mock_consent_id}"
    
    return {
        "message": "Consent request created",
        "consent_id": mock_consent_id,
        "approval_url": mock_approval_url,
        "status": "PENDING"
    }

# --- 2. The Webhook (Data Ingestion) ---
@router.post("/webhook")
def process_aa_webhook(payload: WebhookPayload, db: Client = Depends(get_db)):
    """
    Setu calls this endpoint when the user approves the consent on their phone.
    We will simulate decrypting the HDFC data and injecting Indian transactions.
    """
    if payload.status != "ACTIVE":
        raise HTTPException(status_code=400, detail="Consent not active")
        
    try:
        user_id_str = str(payload.user_id)
        
        # 1. Ensure user has an HDFC account in our DB
        existing_acc = db.table("accounts").select("id").eq("user_id", user_id_str).eq("bank_name", "HDFC Bank").execute()
        
        account_data = {
            "user_id": user_id_str,
            "bank_name": "HDFC Bank",
            "account_type": "Savings",
            "current_balance_pence": 4500000,  # ₹45,000 (stored as paise/pence)
            "last_synced_at": str(datetime.now())
        }
        
        if existing_acc.data:
            account_id = existing_acc.data[0]["id"]
            db.table("accounts").update(account_data).eq("id", account_id).execute()
        else:
            acc_response = db.table("accounts").insert(account_data).execute()
            account_id = acc_response.data[0]["id"]
        
        # 2. Inject realistic Indian student transactions
        today = datetime.now()
        transactions = [
            {"account_id": account_id, "amount_pence": -24000, "date": str((today - timedelta(days=1)).date()), "description": "UPI/Zomato/Dinner"},
            {"account_id": account_id, "amount_pence": -65000, "date": str((today - timedelta(days=2)).date()), "description": "UPI/Zepto/Groceries"},
            {"account_id": account_id, "amount_pence": -12000, "date": str((today - timedelta(days=2)).date()), "description": "UPI/Uber/Ride"},
            {"account_id": account_id, "amount_pence": -150000, "date": str((today - timedelta(days=4)).date()), "description": "POS/Zudio/Clothes"},
            {"account_id": account_id, "amount_pence": -1200000, "date": str((today - timedelta(days=5)).date()), "description": "UPI/Landlord/Rent"},
            {"account_id": account_id, "amount_pence": 2500000, "date": str((today - timedelta(days=10)).date()), "description": "NEFT/Allowance/Dad"}
        ]
        
        db.table("transactions").insert(transactions).execute()
        
        return {"message": "Bank data successfully synced and decrypted via Account Aggregator"}
        
    except Exception as e:
        logger.error(f"Webhook processing failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Failed to process bank data: {str(e)}")
