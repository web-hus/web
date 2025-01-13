from sqlalchemy.orm import Session
from sqlalchemy import func, desc
from datetime import datetime, date
from calendar import monthrange
from ..schemas import dashboard_schema
from ...models import order_model, dish_model, booking_model
from fastapi import HTTPException
import pandas as pd
from reportlab.pdfgen import canvas
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle

class DashboardService:
    @staticmethod
    def get_monthly_orders(db: Session, current_month: date) -> int:
        """Get total orders in current month"""
        return db.query(order_model.Order).filter(
            func.extract('month', order_model.Order.order_date) == current_month.month,
            func.extract('year', order_model.Order.order_date) == current_month.year
        ).count()

    @staticmethod
    def get_total_revenue(db: Session) -> float:
        """Get total revenue from completed orders"""
        return db.query(func.sum(order_model.Order.total_amount)).filter(
            order_model.Order.status == 3  # Hoàn thành
        ).scalar() or 0.0

    @staticmethod
    def get_top_dishes(db: Session) -> list:
        """Get top 10 most ordered dishes"""
        return db.query(
            order_model.OrderDish.dish_id,
            dish_model.Dish.name,
            func.count(order_model.OrderDish.dish_id).label('order_count'),
            func.sum(order_model.Order.total_amount).label('total_revenue')
        ).join(
            dish_model.Dish,
            dish_model.Dish.dish_id == order_model.OrderDish.dish_id
        ).join(
            order_model.Order,
            order_model.Order.order_id == order_model.OrderDish.order_id
        ).group_by(
            order_model.OrderDish.dish_id,
            dish_model.Dish.name
        ).order_by(
            desc('order_count')
        ).limit(10).all()

    @staticmethod
    def get_daily_revenue(db: Session, current_month: date) -> list:
        """Get daily revenue for current month"""
        days_in_month = monthrange(current_month.year, current_month.month)[1]
        daily_revenue = []

        for day in range(1, days_in_month + 1):
            revenue = db.query(func.sum(order_model.Order.total_amount)).filter(
                func.extract('day', order_model.Order.order_date) == day,
                func.extract('month', order_model.Order.order_date) == current_month.month,
                func.extract('year', order_model.Order.order_date) == current_month.year,
                order_model.Order.status == 3  # Hoàn thành
            ).scalar() or 0.0

            daily_revenue.append({
                'date': f"{current_month.year}-{current_month.month:02d}-{day:02d}",
                'revenue': revenue
            })

        return daily_revenue

    @staticmethod
    def get_customer_ratio(db: Session) -> dict:
        """Calculate offline vs online customer ratio"""
        total_orders = db.query(order_model.Order).count()
        if total_orders == 0:
            return {'offline': 0, 'online': 0}

        offline_orders = db.query(order_model.Order).filter(
            order_model.Order.order_type == 0
        ).count()

        online_orders = total_orders - offline_orders
        
        return {
            'offline': round(offline_orders / total_orders * 100, 2),
            'online': round(online_orders / total_orders * 100, 2)
        }

    @staticmethod
    def export_dashboard_pdf(stats: dashboard_schema.DashboardStats, output_path: str):
        """Export dashboard statistics to PDF"""
        doc = SimpleDocTemplate(output_path, pagesize=letter)
        elements = []

        # Create data for tables
        revenue_data = [['Ngày', 'Doanh thu']]
        revenue_data.extend([[d['date'], f"{d['revenue']:,.0f} VND"] for d in stats.daily_revenue])

        top_dishes_data = [['Món ăn', 'Số lần gọi', 'Doanh thu']]
        top_dishes_data.extend([
            [dish.name, dish.order_count, f"{dish.total_revenue:,.0f} VND"]
            for dish in stats.top_dishes
        ])

        # Add tables to elements
        elements.append(Table(revenue_data))
        elements.append(Table(top_dishes_data))

        # Build PDF
        doc.build(elements)

    @staticmethod
    def get_dashboard_stats(db: Session) -> dashboard_schema.DashboardStats:
        """Get all dashboard statistics"""
        current_month = date.today()
        
        return dashboard_schema.DashboardStats(
            monthly_orders=DashboardService.get_monthly_orders(db, current_month),
            total_revenue=DashboardService.get_total_revenue(db),
            top_dishes=DashboardService.get_top_dishes(db),
            daily_revenue=DashboardService.get_daily_revenue(db, current_month),
            customer_ratio=DashboardService.get_customer_ratio(db),
            current_month=current_month.strftime("%Y-%m")
        )
