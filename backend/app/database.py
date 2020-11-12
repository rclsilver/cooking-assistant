import os

from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker


def get_url() -> str:
    """
    Return the SQLAlchemy connection string
    """
    return 'postgresql://{}:{}@{}/{}'.format(
        os.getenv('DB_USER'),
        os.getenv('DB_PASS'),
        os.getenv('DB_HOST'),
        os.getenv('DB_NAME')
    )


def get_session() -> Session:
    """
    Create a new database session
    """
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()


engine = create_engine(get_url())

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
