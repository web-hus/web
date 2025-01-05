from datetime import datetime
import pandas as pd
import numpy as np
from typing import Dict, Tuple
from numpy.typing import NDArray

# Import các hàm từ các module khác
from create_users_table import create_users_info
from create_order_food import create_orders
from create_booking_table import create_booking_table
from pay_payord import create_payment_tables
from dish_table import dish

def generate_all_tables(start_date: datetime, 
                       end_date: datetime, 
                       n_users: int = 2000,
                       bookings_per_day: int = 40) -> Dict[str, pd.DataFrame]:
    
    """
    Tạo tất cả các bảng cho cơ sở dữ liệu nhà hàng.

    Tham số:
        start_date: Ngày bắt đầu để tạo đơn hàng và đặt chỗ.
        end_date: Ngày kết thúc để tạo đơn hàng và đặt chỗ.
        n_users: Số lượng người dùng cần tạo.
        bookings_per_day: Số lượng đặt chỗ mỗi ngày.

    Kết quả trả về:
        Dictionary chứa tất cả các DataFrame đã được tạo.

    """
    
    try:
        users_df = create_users_info(n_users)
        
        order_food_df, order_dish_df = create_orders(
            start_date=start_date,
            end_date=end_date,
            users_df=users_df,
            dishes_df=dish
        )
        
        booking_df = create_booking_table(
            start_date=start_date,
            end_date=end_date,
            rows_per_day=bookings_per_day,
            users=users_df
        )
        
        payment_df, payment_order_df = create_payment_tables(order_food_df)
        
        # Kiểm tra user_id trong bảng order_food tồn tại trong bảng users
        assert set(order_food_df['user_id']).issubset(set(users_df['user_id'])), \
            "Invalid user_ids in order_food"
        assert set(order_dish_df['order_id']).issubset(set(order_food_df['order_id'])), \
            "Invalid order_ids in order_dish"
        assert set(payment_df['order_id']).issubset(set(order_food_df['order_id'])), \
            "Invalid order_ids in payment"
        
        # Trả về các bảng trong dictionary
        tables = {
            'users': users_df,
            'dish': dish,
            'order_food': order_food_df,
            'order_dish': order_dish_df,
            'booking': booking_df,
            'payment': payment_df,
            'payment_order': payment_order_df
        }
        
        return tables
        
    except Exception as e:
        print(f"Error generating tables: {str(e)}")
        raise


if __name__ == "__main__":
    # Cài đặt thời gian
    start_date = datetime(2024, 11, 1)
    end_date = datetime(2024, 12, 31)
    
    # Tạo tất cả các bảng
    tables = generate_all_tables(start_date, end_date)


