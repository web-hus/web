from pydantic import BaseModel, EmailStr, constr

class ResetPasswordRequest(BaseModel):
    email: EmailStr
    new_password: constr(min_length=6)
    confirm_password: constr(min_length=6)

    def passwords_match(self) -> bool:
        return self.new_password == self.confirm_password

class ForgotPasswordRequest(BaseModel):
    email: EmailStr

class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp: constr(min_length=6, max_length=6, pattern=r'^\d{6}$')
