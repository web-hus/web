import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from fastapi import HTTPException, status
from dotenv import load_dotenv
import logging

load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class EmailService:
    SMTP_SERVER = os.getenv('SMTP_SERVER', 'smtp.gmail.com')
    SMTP_PORT = int(os.getenv('SMTP_PORT', 587))
    SENDER_EMAIL = os.getenv('EMAIL_SENDER')
    SENDER_PASSWORD = os.getenv('EMAIL_PASSWORD')

    @staticmethod
    def send_email(to_email: str, subject: str, body: str) -> None:
        """Send email using SMTP"""
        try:
            logger.info(f"Attempting to send email to {to_email}")
            logger.info(f"Using SMTP server: {EmailService.SMTP_SERVER}:{EmailService.SMTP_PORT}")
            logger.info(f"Sender email: {EmailService.SENDER_EMAIL}")
            
            msg = MIMEMultipart()
            msg['From'] = EmailService.SENDER_EMAIL
            msg['To'] = to_email
            msg['Subject'] = subject

            msg.attach(MIMEText(body, 'html'))

            # Connect to SMTP server
            logger.info("Connecting to SMTP server...")
            server = smtplib.SMTP(EmailService.SMTP_SERVER, EmailService.SMTP_PORT)
            
            logger.info("Starting TLS...")
            server.starttls()
            
            logger.info("Attempting login...")
            server.login(EmailService.SENDER_EMAIL, EmailService.SENDER_PASSWORD)
            
            # Send email
            logger.info("Sending email...")
            server.send_message(msg)
            
            logger.info("Closing connection...")
            server.quit()
            
            logger.info("Email sent successfully!")
            
        except Exception as e:
            logger.error(f"Error sending email: {str(e)}")
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error sending email: {str(e)}"
            )

    @staticmethod
    def send_reset_link_email(to_email: str, reset_link: str) -> None:
        """Send password reset link email"""
        subject = "Cài đặt lại mật khẩu"
        body = f"""
        <html>
            <body>
                <h2>Cài đặt lại mật khẩu</h2>
                <p>Bạn đã yêu cầu cài đặt lại mật khất. Bấm vào đường link phía dưới để đặt lại:</p>
                <p><a href="{reset_link}">Đặt lại mật khẩu</a></p>
                <p>Đường link sẽ có hiệu lực trong 6 phút.</p>
                <p>Nếu bạn không yêu cầu cài đặt lại mật khất, vui lòng bỏ qua tin nhắn này.</p>
            </body>
        </html>
        """
        EmailService.send_email(to_email, subject, body)
