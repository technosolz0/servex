# from fastapi import APIRouter, HTTPException, Depends
# from sqlalchemy.orm import Session
# from app.core.security import create_access_token, get_current_user, get_db
# from app.schemas import user_schema
# from app.crud import user as crud_user
# from app.models.user import User

# router = APIRouter(prefix="/user-auth", tags=["User Authentication"])

# @router.post("/send-login-otp")
# def send_login_otp(data: user_schema.OTPResend, db: Session = Depends(get_db)):
#     otp_sent = crud_user.create_login_otp(db, data.email)
#     if not otp_sent:
#         raise HTTPException(status_code=404, detail="User not found or not verified")
#     return {"message": "Login OTP sent successfully."}

# @router.post("/verify-login-otp")
# def verify_login_otp(data: user_schema.OTPVerify, db: Session = Depends(get_db)):
#     result = crud_user.verify_login_otp(db, data.email, data.otp)
#     if result is None:
#         raise HTTPException(status_code=404, detail="User not found")
#     if result == "invalid":
#         raise HTTPException(status_code=400, detail="Invalid OTP")
#     if result == "expired":
#         raise HTTPException(status_code=400, detail="OTP expired")

#     access_token = create_access_token(data={"sub": result.email})

#     return {
#         "message": "Login successful",
#         "access_token": access_token,
#         "token_type": "bearer",
#         "user": {
#             "id": result.id,
#             "name": result.name,
#             "email": result.email,
#             "mobile": result.mobile
#         }
#     }

# @router.get("/me")
# def get_current_user_data(current_user: User = Depends(get_current_user)):
#     return {
#         "id": current_user.id,
#         "name": current_user.name,
#         "email": current_user.email,
#         "mobile": current_user.mobile,
#         "last_login_at": current_user.last_login_at
#     }
