import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from fastapi import HTTPException, status
from dotenv import load_dotenv

load_dotenv()

class EmailService:
    @staticmethod
    def send_otp_email(recipient_email: str, otp: str) -> None:
        """Send OTP via email"""
        try:
            # Email configuration
            sender_email = os.getenv('EMAIL_SENDER')
            sender_password = os.getenv('EMAIL_PASSWORD')
            smtp_server = os.getenv('SMTP_SERVER', 'smtp.gmail.com')
            smtp_port = int(os.getenv('SMTP_PORT', 587))

            # Create message
            message = MIMEMultipart()
            message["From"] = sender_email
            message["To"] = recipient_email
            message["Subject"] = "Mã OTP Đặt Lại Mật Khẩu"

            # Email content
            body = f"""
            Xin chào,

            Đây là mã OTP để đặt lại mật khẩu của bạn: {otp}

            Mã này sẽ hết hạn sau 6 phút.

            Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.

            Trân trọng,
            Nhà hàng của chúng tôi
            """
            message.attach(MIMEText(body, "plain"))

            # Create SMTP session
            with smtplib.SMTP(smtp_server, smtp_port) as server:
                server.starttls()
                server.login(sender_email, sender_password)
                server.send_message(message)

        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Error sending email"
            )
