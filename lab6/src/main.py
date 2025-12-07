from sqlalchemy import insert, select
from sqlalchemy.orm import Session

from db.models import User
from db.session import get_session


def main():
    print("Hi Andrii")


def insert_test_data(db: Session) -> None:
    pass


if __name__ == "__main__":
    db = get_session()
