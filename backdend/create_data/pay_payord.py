import pandas as pd
import numpy as np
from typing import Tuple
from numpy.typing import NDArray
from datetime import datetime
from create_users_table import users
from dish_table import dish


payment = pd.DataFrame({
    'payment_id': [None],
    'amount': [None],
    'payment_method': [None],
    'payment_status': [None],
    'payment_date': [None],
    'order_id': [None],
    'user_id': [None],
    })


payment_order = pd.DataFrame({
    'payment_id': [None],
    'order_id': [None]
})

def create_payment_tables(order_food_df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Tạo bảng payment và payment_order dựa trên dữ liệu order_food.
        
    Trả về Tuple có 2 DataFrame: payment và payment_order
    """
    
    # Lấy các order_id unique từ order_food
    unique_orders = order_food_df.drop_duplicates(subset=['order_id'])
    
    # Tạo payment_id cho mỗi order
    n_payments = len(unique_orders)
    payment_ids = np.arange(1, n_payments + 1)
    
    # Tạo payment status với tỷ lệ phù hợp
    status_probs: NDArray = np.array([0.85, 0.10, 0.05])  # Đã thanh toán, đang xử lý, hoàn tiền
    payment_status = np.random.choice(
        [0, 1, 2], 
        size=n_payments, 
        p=status_probs
    )
    
    # Tạo payment method (60% chuyển khoản, 40% tiền mặt)
    payment_method = np.random.choice(
        [0, 1], 
        size=n_payments, 
        p=[0.6, 0.4]
    )
    
    # Tạo bảng payment
    payment = pd.DataFrame({
        'payment_id': payment_ids,
        'amount': unique_orders['total_amount'].values,
        'payment_method': payment_method,
        'payment_status': payment_status,
        'payment_date': unique_orders['create_at'].values,
        'order_id': unique_orders['order_id'].values,
        'user_id': unique_orders['user_id'].values
    })
    
    # Tạo bảng payment_order
    payment_order = pd.DataFrame({
        'payment_id': payment_ids,
        'order_id': unique_orders['order_id'].values
    })
    
    # Validate dữ liệu
    assert not payment['payment_id'].duplicated().any(), "Duplicate payment_ids found"
    assert not payment['order_id'].duplicated().any(), "Duplicate order_ids found"
    assert len(payment) == len(payment_order), "Mismatch in table lengths"
    
    return payment, payment_order


if __name__ == "__main__":

    from create_order_food import create_orders
    
    start_date = datetime(2024, 11, 1)
    end_date = datetime(2024, 12, 31)
    order_food, order_dish = create_orders(start_date, end_date, users, dish)
    payment_df, payment_order_df = create_payment_tables(order_food)
    
    print("\nPayment Table Summary:")
    print(payment_df.head())
    print("\nPayment Statistics:")
    print(payment_df.describe())
    
    print("\nPayment Status Distribution:")
    status_map = {0: "Đã thanh toán", 1: "Đang xử lý", 2: "Hoàn tiền"}
    print(payment_df['payment_status'].map(status_map).value_counts())
    
    print("\nPayment Method Distribution:")
    method_map = {0: "Chuyển khoản", 1: "Tiền mặt"}
    print(payment_df['payment_method'].map(method_map).value_counts())
    
