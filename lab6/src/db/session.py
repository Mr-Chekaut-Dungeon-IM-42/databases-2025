from __future__ import annotations

import os

from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker

DB_URL = "postgresql://admin:password@localhost:5432/db_labs"

# future=True is default in SQLAlchemy 2.x create_engine
engine = create_engine(DB_URL, future=True)

SessionLocal = sessionmaker(bind=engine, class_=Session, autoflush=False, future=True)


def get_session() -> Session:
    return SessionLocal()
