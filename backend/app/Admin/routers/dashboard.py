from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ...database import get_db
from ..services.dashboard_service import DashboardService
from ..schemas import dashboard_schema
from ...auth.auth_bearer import JWTBearer
from ...auth.auth_handler import verify_token
import os
from fastapi import status

router = APIRouter(
    prefix="/admin/dashboard",
    tags=["admin-dashboard"],
    dependencies=[Depends(JWTBearer())]
)

def get_current_user(token: str = Depends(JWTBearer())):
    user_data = verify_token(token)
    if not user_data or user_data.get("role") != 1:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Bạn không có quyền truy cập dashboard"
        )
    return user_data

@router.get("/stats", response_model=dashboard_schema.DashboardStats)
def get_dashboard_stats(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get all dashboard statistics"""
    return DashboardService.get_dashboard_stats(db)

@router.get("/monthly-orders")
def get_monthly_orders(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get total orders in current month"""
    current_month = date.today()
    return {"total": DashboardService.get_monthly_orders(db, current_month)}

@router.get("/total-revenue")
def get_total_revenue(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get total revenue from completed orders"""
    return {"total": DashboardService.get_total_revenue(db)}

@router.get("/top-dishes")
def get_top_dishes(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get top 10 most ordered dishes"""
    return {"dishes": DashboardService.get_top_dishes(db)}

@router.get("/daily-revenue")
def get_daily_revenue(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get daily revenue for current month"""
    current_month = date.today()
    return {"revenue": DashboardService.get_daily_revenue(db, current_month)}

@router.get("/customer-ratio")
def get_customer_ratio(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Get offline vs online customer ratio"""
    return {"ratio": DashboardService.get_customer_ratio(db)}

@router.get("/export-pdf")
def export_dashboard_pdf(
    db: Session = Depends(get_db),
    admin: dict = Depends(get_current_user)
):
    """Export dashboard statistics to PDF"""
    stats = DashboardService.get_dashboard_stats(db)
    output_path = f"reports/dashboard_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
    
    # Create reports directory if not exists
    os.makedirs("reports", exist_ok=True)
    
    DashboardService.export_dashboard_pdf(stats, output_path)
    return {"file_path": output_path}
