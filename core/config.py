import os
from dotenv import load_dotenv

load_dotenv()

class Settings:
    SUPABASE_URL: str = os.getenv("SUPABASE_URL", "")
    SUPABASE_KEY: str = os.getenv("SUPABASE_KEY") or os.getenv("SUPABASE_ANON_KEY", "")

    def __init__(self):
        if self.SUPABASE_URL.endswith("/rest/v1/"):
            self.SUPABASE_URL = self.SUPABASE_URL[:-9]
        elif self.SUPABASE_URL.endswith("/rest/v1"):
            self.SUPABASE_URL = self.SUPABASE_URL[:-8]

settings = Settings()
