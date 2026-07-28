import logging
from supabase import create_client, Client
from core.config import settings

logger = logging.getLogger(__name__)

def get_db() -> Client:
    """Dependency to inject the Supabase client."""
    try:
        return create_client(settings.SUPABASE_URL, settings.SUPABASE_KEY)
    except Exception as e:
        logger.error(f"Failed to initialize Supabase client: {str(e)}")
        raise

# Legacy direct instance for endpoints using direct db reference
db: Client = get_db()
