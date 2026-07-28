from fastapi import FastAPI
from services.supabase_db import db
from api.engine import router as engine_router  # <-- Added this import

app = FastAPI(title="Financial Copilot Engine")

# <-- Added this line to hook up the engine logic
app.include_router(engine_router, prefix="/api/engine") 

@app.get("/health")
def health_check():
    return {"status": "healthy", "engine": "running"}

@app.get("/test-db")
def test_db_connection():
    response = db.table("profiles").select("*").limit(1).execute()
    return {"data": response.data}
