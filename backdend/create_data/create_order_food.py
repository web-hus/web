from datetime import datetime, timedelta
from typing import Dict, Tuple, List
from numpy.typing import NDArray
import numpy as np
import pandas as pd
import random
from create_users_table import users
from dish_table import dish

# Constants
TIME_RANGES: Dict[str, Tuple[int, int, float]] = {
    'morning': (6, 10, 0.01),
    'peak': (10, 20, 0.99),
    'night': (20, 24, 0.01)
}

district = ["Ba Đình", "Hoàn Kiếm", "Tây Hồ", "Long Biên", "Cầu Giấy",
"Đống Đa", "Hai Bà Trưng", "Thanh Xuân", "Hà Đông", "Nam Từ Liêm",
"Bắc Từ Liêm", "Mê Linh", "Sóc Sơn", "Đan Phượng", "Hoài Đức",
"Phúc Thọ", "Thạch Thất", "Quốc Oai", "Chương Mỹ", "Ba Vì",
"Phú Xuyên", "Thường Tín", "Mỹ Đức", "Ứng Hòa", "Thanh Oai"]
ward = ["Cống Vị", "Giảng Võ", "Ngọc Hà", "Điện Biên", "Kim Mã", "Hàng Bạc", "Hàng Bài", "Hàng Đào", "Lý Thái Tổ", "Tràng Tiền", "Bạch Mai", "Bách Khoa", "Đồng Tâm", "Minh Khai", "Quỳnh Mai", "Cát Linh", "Hàng Bột", "Khâm Thiên", "Láng Hạ", "Ô Chợ Dừa", "Nhật Tân", "Quảng An", "Thụy Khuê", "Xuân La", "Yên Phụ", "Dịch Vọng", "Mai Dịch", "Nghĩa Đô", "Quan Hoa", "Trung Hòa", "Hạ Đình", "Khương Đình", "Khương Mai", "Phương Liệt", "Thanh Xuân Trung", "Đại Kim", "Định Công", "Giáp Bát", "Hoàng Liệt", "Tân Mai", "Bồ Đề", "Cự Khối", "Đức Giang", "Gia Thụy", "Ngọc Lâm", "Cổ Nhuế 1", "Đông Ngạc", "Liên Mạc", "Phú Diễn", "Thụy Phương", "Cầu Diễn", "Đại Mỗ", "Mễ Trì", "Phú Đô", "Tây Mỗ", "Biên Giang", "Hà Cầu", "Mộ Lao", "Văn Quán", "Yên Nghĩa", "An Khánh", "An Thượng", "Dương Liễu", "La Phù", "Vân Canh", "Cổ Loa", "Đông Hội", "Hải Bối", "Nam Hồng", "Xuân Canh", "Cổ Bi", "Đa Tốn", "Dương Xá", "Kiêu Kỵ", "Yên Viên", "Đại Áng", "Đông Mỹ", "Tả Thanh Oai", "Ngũ Hiệp", "Liên Ninh"]
streets = ["Đào Tấn", "Giảng Võ", "Ngọc Hà", "Hoàng Diệu", "Kim Mã", "Hàng Bạc", "Hàng Bài", "Hàng Đào", "Ngô Quyền", "Tràng Tiền", "Bạch Mai", "Lê Thanh Nghị", "Giải Phóng", "Minh Khai", "Thanh Nhàn", "Cát Linh", "Tôn Đức Thắng", "Khâm Thiên", "Láng Hạ", "Xã Đàn", "Âu Cơ", "Đặng Thai Mai", "Thụy Khuê", "Xuân La", "Yên Phụ", "Cầu Giấy", "Hồ Tùng Mậu", "Nguyễn Khánh Toàn", "Quan Hoa", "Trần Duy Hưng", "Hạ Đình", "Khương Đình", "Hoàng Văn Thái", "Giải Phóng", "Nguyễn Trãi", "Kim Giang", "Định Công", "Giáp Bát", "Nguyễn Hữu Thọ", "Tân Mai", "Ngọc Lâm", "Cự Khối", "Ngô Gia Tự", "Gia Thụy", "Nguyễn Văn Cừ", "Cổ Nhuế", "Đông Ngạc", "Liên Mạc", "Phú Diễn", "Thụy Phương", "Hồ Tùng Mậu", "Tây Mỗ", "Mễ Trì", "Phú Đô", "Đại Mỗ", "Biên Giang", "Lê Lợi", "Nguyễn Văn Lộc", "Trần Phú", "Yên Nghĩa", "An Khánh", "An Thượng", "Dương Liễu", "La Phù", "Vân Canh", "Cổ Loa", "Đông Hội", "Hải Bối", "Nam Hồng", "Xuân Canh", "Cổ Bi", "Đa Tốn", "Dương Xá", "Kiêu Kỵ", "Yên Viên", "Đại Áng", "Đông Mỹ", "Tả Thanh Oai", "Ngũ Hiệp", "Liên Ninh"]

#Xác suất cho mỗi trạng thái
STATUS_WEIGHTS: Dict[int, float] = {
    0: 0.05,  # đang chờ xử lý
    1: 0.15,  # đang làm
    2: 0.15,  # đang giao
    3: 0.60,  # đã giao
    4: 0.05   # hủy
}

CATEGORY_RULES: Dict[str, Tuple[int, int]] = {
    "Món chính": (2, 5),
    "Món phụ": (1, 2),
    "Khai vị": (1, 2),
    "Đồ uống": (0, 3)
}

TIME_RANGES: Tuple[Tuple[str, str, float], ...] = (
    ('05:00', '11:00', 0.25),  # Sáng
    ('11:00', '18:00', 0.35),  # Trưa - Chiều
    ('18:00', '22:00', 0.4),   # Tối
    ('22:00', '02:00', 0.00)   # Đêm
)

def generate_order_times(order_date: datetime) -> Tuple[datetime, datetime]:
    """
    Tạo thời gian create_at và update_at cho đơn hàng.
    
    order_date: Ngày tạo đơn hàng
        
    Trả về tuple có 2 giá trị datetime: create_at và update_at
    """
    probabilities: NDArray = np.array([slot[2] for slot in TIME_RANGES])
    probabilities /= probabilities.sum()
    
    selected_slot_idx = np.random.choice(len(TIME_RANGES), p=probabilities)
    start_time, end_time, _ = TIME_RANGES[selected_slot_idx]
    
    try:
        start_dt = datetime.strptime(
            f"{order_date.strftime('%Y-%m-%d')} {start_time}", 
            '%Y-%m-%d %H:%M'
        )
        
        # Xử lý trường hợp qua ngày mới
        if end_time < start_time:
            next_day = order_date + timedelta(days=1)
            end_dt = datetime.strptime(
                f"{next_day.strftime('%Y-%m-%d')} {end_time}", 
                '%Y-%m-%d %H:%M'
            )
        else:
            end_dt = datetime.strptime(
                f"{order_date.strftime('%Y-%m-%d')} {end_time}", 
                '%Y-%m-%d %H:%M'
            )
        
        time_diff = int((end_dt - start_dt).total_seconds())
        create_at = start_dt + timedelta(seconds=np.random.randint(0, time_diff))
        
        # update_at sau create_at trong khoảng 5-45 phút sau
        update_minutes = np.random.exponential(scale=10)
        update_minutes = min(max(5, update_minutes), 45)
        update_at = create_at + timedelta(minutes=int(update_minutes))
        
        return create_at, update_at
        
    except ValueError as e:
        raise ValueError(f"Invalid time format: {start_time} - {end_time}") from e


def create_delivery_address() -> str:
    address = random.randint(1, 100)
    street = streets[random.randint(0, len(streets)-1)]
    locate = streets.index(street)//5
    ward_of_street = ward[streets.index(street)]
    districts = district[locate]
    return str(address) +" "+ street + ", " + ward_of_street + ", " + districts + ", " + "Hà Nội"
    

def generate_order_dishes(order_id: int, 
                         dishes_df: pd.DataFrame,
                         category_rules: Dict[str, Tuple[int, int]] = CATEGORY_RULES) -> pd.DataFrame:
    """Tạo món ăn cho một đơn hàng"""
    
    order_dishes = []
    used_dish_ids = set()
    
    
    # Phân loại món ăn theo category (phân loại)
    for category, (min_items, max_items) in category_rules.items():
        category_dishes = dishes_df[
            (dishes_df['category'] == category) & 
            (dishes_df['availability'] == True)]
        
        if len(category_dishes) == 0:
            continue
        
        available_dishes = category_dishes[~category_dishes['dish_id'].isin(used_dish_ids)]
        if len(available_dishes) == 0:
            continue
            
        # Chọn số lượng món ăn
        n_items = np.random.randint(min_items, max_items + 1)
        
        if n_items == 0:
            continue
            
        # Chọn ngẫu nhiên các món ăn
        selected_dishes = available_dishes.sample(n=min(n_items, len(category_dishes)))
        used_dish_ids.update(selected_dishes['dish_id'])
        
        for _, dish in selected_dishes.iterrows():
            quantity = 1
            
            if category == "Món chính":
                quantity = np.random.choice([1, 2, 3, 4, 5], p=[0.3, 0.3, 0.2, 0.15, 0.05])
            elif category == "Đồ uống":
                quantity = np.random.randint(1, 3) * 2
            else:
                quantity = np.random.randint(1, 3)
                
            order_dishes.append({
                'order_id': order_id,
                'dish_id': dish['dish_id'],
                'quantity': quantity
            })
    
    return pd.DataFrame(order_dishes)

def create_orders(start_date: datetime,
                 end_date: datetime,
                 users_df: pd.DataFrame,
                 dishes_df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.DataFrame]:
    """Tạo ord"""
    
    days = (end_date - start_date).days + 1
    orders_per_day = np.random.randint(7, 11, days)
    
    # Khởi tạo dữ liệu cho order_food
    order_food_data: List[Dict] = []
    order_dish_data: List[pd.DataFrame] = []
    current_order_id = 1
    
    for current_date in pd.date_range(start_date, end_date):
        # 7-10 đơn mỗi ngày
        n_orders = np.random.randint(7, 11)
        
        for _ in range(n_orders):
            # Tạo order dishes trước để tính total_amount
            order_dishes = generate_order_dishes(current_order_id, dishes_df)
            
            # Tính total_amount
            total_amount = sum(
                dishes_df[dishes_df['dish_id'] == row['dish_id']]['price'].iloc[0] * row['quantity']
                for _, row in order_dishes.iterrows()
            )
            
            # Chọn user_id (ưu tiên người trẻ với đơn giá cao)
            if total_amount > 500000:  # Đơn giá cao
                young_users = users_df[users_df['age'].between(18, 35)]
                user_id = np.random.choice(young_users['user_id'])
            else:
                user_id = np.random.choice(users_df['user_id'])
            
            # Tạo thời gian đơn hàng
            create_at, update_at = generate_order_times(current_date)
            
            order_date = create_at.date()
            
            # Validation thời gian
            assert create_at.date() == update_at.date(), \
                f"create_at and update_at must be on the same day: {create_at} vs {update_at}"
            assert order_date == create_at.date(), \
                f"order_date must match create_at date: {order_date} vs {create_at.date()}"
            
            # Thêm vào order_food
            order_food_data.append({
                'order_id': current_order_id,
                'order_date': current_date,
                'create_at': create_at,
                'update_at': update_at,
                'status': np.random.choice(
                    list(STATUS_WEIGHTS.keys()),
                    p=list(STATUS_WEIGHTS.values())
                ),
                'total_amount': total_amount,
                'delivery_address': create_delivery_address(),
                'user_id': user_id
            })
            
            order_dish_data.append(order_dishes)
            current_order_id += 1
    
    return pd.DataFrame(order_food_data), pd.concat(order_dish_data, ignore_index=True)
# Usage example:

if __name__ == "__main__":
    start_date = datetime(2024, 11, 1)
    end_date = datetime(2024, 11, 30)
    order_food, order_dish = create_orders(start_date, end_date, users, dish)
    print(order_food)

    print(order_dish)
