from app.controllers import BaseController
from app.models.user import User
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


class UserController(BaseController):
    """
    User controller
    """

    @classmethod
    def get_users(cls, db: Session) -> List[User]:
        """
        Fetch all users from database
        """
        return db.query(User).all()

    @classmethod
    def get_user_by_id(cls, user_id: UUID, db: Session) -> User:
        """
        Fetch a specific user from database
        """
        return cls._get(db, User, id=user_id)

    @classmethod
    def get_or_create_user(cls, username: str, is_admin:bool, db: Session) -> User:
        """
        Get or create a user
        """
        user = db.query(User).filter_by(username=username).first()

        if not user:
            # Create the user
            user = User(username=username, is_admin=is_admin)
            db.add(user)
            db.commit()
        elif user.is_admin != is_admin:
            # Update existing user
            user.is_admin = is_admin
            db.add(user)
            db.commit()

        return user

    @classmethod
    def delete_user(cls, user: User, db: Session) -> None:
        """
        Delete a user from database
        """
        db.delete(user)
        db.commit()
