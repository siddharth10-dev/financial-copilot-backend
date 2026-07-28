# 🚀 Financial Copilot Engine

[![Python](https://img.shields.io/badge/Python-3.13+-blue.svg)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688.svg)](https://fastapi.tiangolo.com/)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-green.svg)](https://supabase.com/)
[![Pydantic](https://img.shields.io/badge/Pydantic-v2-red.svg)](https://docs.pydantic.dev/)

> **"AI Financial Coach, Not an Expense Tracker"**  
> A high-performance, deterministic financial decision engine built with FastAPI and Supabase. Designed around a single trustworthy metric: **Daily Safe-to-Spend**.

---

## 💡 Product Thesis & Core Philosophy

Most personal finance applications fail because they force users to reconcile spreadsheets, analyze complex pie charts, or decipher arbitrary composite health scores (e.g., *"72/100"*).

### The Hero Metric: Daily Safe-to-Spend
Before buying a coffee or a meal, users ask one fundamental question: **"How much can I spend today without messing up my month?"**

The Financial Copilot backend centers its entire architecture around making **Daily Safe-to-Spend** bulletproof:
$$\text{Safe-to-Spend} = \text{Total Account Balances} - \text{Locked Savings Goals}$$

By combining deterministic arithmetic with time-based monthly burn-rate calculations, the engine provides an instant, high-confidence spending boundary.

```
+-------------------------------------------------------------------+
|                     DAILY SAFE-TO-SPEND                           |
|                            £24.50                                 |
|               "Well within your daily limit"                      |
+-------------------------------------------------------------------+
|  [ Remaining Budget: £420 ]  |  [ Savings Goal Locked: £150 ]     |
+-------------------------------------------------------------------+
```

---

## 🏗️ System Architecture

The engine separates **deterministic arithmetic** from **natural-language generation**. Financial math is executed strictly by Python code and database constraints, ensuring zero LLM hallucination risk.

```mermaid
flowchart TD
    Client[📱 Frontend / Mobile App]
    
    subgraph FastAPI [FastAPI Application Boundary]
        Router[🛣️ API Router /api/engine]
        Pydantic[🛡️ Pydantic V2 Validation]
        Engine[🧮 Financial Decision Engine]
        DI[💉 Dependency Injector get_db]
    end
    
    subgraph Database [Supabase / PostgreSQL]
        Accounts[(💳 accounts)]
        Goals[(🎯 goals)]
        Profiles[(👤 profiles)]
    end
    
    subgraph OpenBanking [Open Banking Layer (v1)]
        TrueLayer[🌐 TrueLayer API UK]
    end

    Client -->|HTTP GET/POST + JSON| Router
    Router --> Pydantic
    Pydantic -->|Validated Models & UUIDs| Engine
    DI -->|Inject Client| Engine
    Engine -->|Select Balances| Accounts
    Engine -->|Select Locked Savings| Goals
    TrueLayer -.->|Async Webhook Sync| Accounts
    Engine -->|JSON Response| Client
```

---

## 🎯 Feature Scope & Principles

### ✅ Must-Have (MVP v1)
* **Hero Metric**: Live **Daily Safe-to-Spend** calculation (`GET /api/engine/safe-to-spend/{user_id}`).
* **Affordability Check**: `"Can I afford this?"` single-purchase evaluation with time-based monthly burn-rate analysis (`POST /api/engine/affordability/{user_id}`).
* **Strict Type Safety**: UUID validation and positive integer enforcement (`cost_pence > 0`).
* **Dependency Injection**: Decoupled Supabase client injection for resilience and mock-testing.
* **Open Banking (TrueLayer UK)**: Single-provider consent-based sync integration pattern.

### ⏳ Wait for v2
* 90-day PSD2/FCA re-consent automated flow.
* Fixed recurring bill deduction from daily allowance.
* Structured AI guidance actions (*"Why am I over budget?", "How do I save £100/mo?"*).

### 🚫 Explicit Anti-Goals (What We Cut)
* ❌ **Freeform Open-Ended Chatbot**: Unconstrained LLMs calculating financial math erosion user trust.
* ❌ **Arbitrary Health Scores**: Composite scores like *"74/100"* are non-actionable.
* ❌ **Overwhelming Dashboards**: No 10-tile spreadsheets on the main screen.

---

## 📐 Math & Decision Logic

### 1. Safe-to-Spend Calculation
```python
total_balance = sum(account.current_balance_pence)
locked_savings = sum(goal.current_balance_pence)

safe_to_spend_pence = total_balance - locked_savings
```

### 2. Single-Purchase Affordability Evaluation
When evaluating a purchase of `cost_pence`:
1. **Hard Stop (Overdraft Territory)**: If `cost_pence > safe_to_spend_pence` $\rightarrow$ Verdict: **NO**.
2. **Burn Rate Warning**: 
   $$\text{Weekly Allowance} = \left( \frac{\text{Current Safe Pence}}{\text{Days Left in Month}} \right) \times 7$$
   If `cost_pence > weekly_allowance` $\rightarrow$ Verdict: **WARNING** (*"Consumes more than 1 week's remaining budget"*).
3. **Green Light**: Otherwise $\rightarrow$ Verdict: **YES** (*"Well within healthy spending limits"*).

---

## 🛠️ API Reference

### Health Check
```http
GET /health
```
**Response (200 OK):**
```json
{
  "status": "healthy",
  "engine": "running"
}
```

---

### Get Safe-to-Spend
```http
GET /api/engine/safe-to-spend/{user_id}
```
**Path Parameters:**
* `user_id` (*UUID, required*): The user's unique identifier.

**Response (200 OK):**
```json
{
  "safe_to_spend_pence": 24500,
  "currency": "GBP"
}
```

**Error Response (422 Unprocessable Entity):**
```json
{
  "detail": [
    {
      "type": "uuid_parsing",
      "loc": ["path", "user_id"],
      "msg": "Input should be a valid UUID"
    }
  ]
}
```

---

### Check Purchase Affordability
```http
POST /api/engine/affordability/{user_id}
Content-Type: application/json
```
**Request Body:**
```json
{
  "item_name": "Noise Cancelling Headphones",
  "cost_pence": 4500
}
```

**Response (200 OK):**
```json
{
  "verdict": "YES",
  "impact_percentage": 18.4,
  "safe_to_spend_after_pence": 20000,
  "reasoning": "Well within your healthy daily spending limits."
}
```

---

## 💻 Local Setup & Development

### 1. Prerequisites
* **Python 3.13+**
* **Supabase Project**

### 2. Clone & Setup Environment
```bash
git clone https://github.com/siddharth10-dev/financial-copilot-backend.git
cd financial-copilot-backend

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install fastapi uvicorn supabase pydantic python-dotenv httpx pytest
```

### 3. Environment Configuration
Create a `.env` file in the project root (refer to `.env.example`):
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-supabase-anon-key
```

### 4. Run Development Server
```bash
uvicorn main:app --reload
```
The server will start at `http://127.0.0.1:8000`. Access interactive API documentation at:
- **Swagger UI**: `http://127.0.0.1:8000/docs`
- **ReDoc**: `http://127.0.0.1:8000/redoc`

---

## 🧪 Testing

Run the automated integration test suite using `pytest` or `TestClient`:
```bash
python -c "
import uuid
from main import app
from fastapi.testclient import TestClient

client = TestClient(app)
test_uuid = str(uuid.uuid4())

print('Health Check:', client.get('/health').json())
print('Safe-to-Spend:', client.get(f'/api/engine/safe-to-spend/{test_uuid}').json())
"
```

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for details.
