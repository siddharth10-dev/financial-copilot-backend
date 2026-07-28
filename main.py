from fastapi import FastAPI
from services.supabase_db import db
from api.engine import router as engine_router
from api.goals import router as goals_router
from api.budgets import router as budgets_router
from api.transactions import router as transactions_router

app = FastAPI(title="Slora API Engine")

# Hook up all the routers
app.include_router(engine_router, prefix="/api/engine")
app.include_router(goals_router, prefix="/api/goals")
app.include_router(budgets_router, prefix="/api/budgets")
app.include_router(transactions_router, prefix="/api/transactions")

@app.get("/health")
def health_check():
    return {"status": "healthy", "engine": "running"}
