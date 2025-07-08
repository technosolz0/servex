# app/scripts/create_super_admin.py

from app.database import SessionLocal
from app.models.user import User, UserStatus
from app.core.security import get_password_hash

def create_super_admin():
    db = SessionLocal()

    email = "admin@servex.com"
    password = "SuperSecure@123"
    name = "Servex Admin"

    if db.query(User).filter(User.email == email).first():
        print("❗ Super admin already exists.")
        return

    user = User(
        name=name,
        email=email,
        hashed_password=get_password_hash(password),
        status=UserStatus.active,
        is_superuser=True,  # ✅ Mark as superuser
    )

    db.add(user)
    db.commit()
    print("✅ Super admin created successfully")

if __name__ == "__main__":
    create_super_admin()
