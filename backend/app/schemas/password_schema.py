from pydantic import BaseModel, EmailStr, constr
from datetime import datetime

class ResetPasswordRequest(BaseModel):
    new_password: constr(min_length=6)
    confirm_password: constr(min_length=6)
    token: str  # Reset token from URL

    def passwords_match(self) -> bool:
        return self.new_password == self.confirm_password

class ForgotPasswordRequest(BaseModel):
    email: EmailStr
