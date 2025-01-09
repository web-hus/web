import numpy as np
import pandas as pd

from create_users_table import users
from datetime import datetime, timedelta
from typing import Dict, Tuple, Optional, Any
from numpy.typing import NDArray

# Các khoảng thời gian
TIME_SLOTS: Tuple[Tuple[str, str, float], ...] = (
    ('05:00', '11:00', 0.28),  # Sáng
    ('11:00', '18:00', 0.3),   # Trưa - Chiều 
    ('18:00', '22:00', 0.4),   # Tối
    ('22:00', '02:00', 0.02)   # Đêm
)

SPECIAL_REQUESTS: Tuple[str, ...] = (
    "Bàn gần cửa sổ để ngắm cảnh",
    "Yêu cầu ghế trẻ em cho bé nhỏ",
    "Không dùng hành hoặc tỏi trong món ăn",
    "Bàn yên tĩnh, xa khu vực bếp hoặc lối đi lại",
    "Chuẩn bị bánh sinh nhật cho tiệc gia đình",
    "Dành chỗ ngồi cho nhóm 10 người",
    "Không thêm muối vào các món ăn",
    "Chuẩn bị thực đơn thuần chay",
    "Thêm một đĩa trái cây cho trẻ em",
    "Cung cấp thực đơn không chứa gluten",
    "Phục vụ nhanh vì có trẻ em đi cùng",
    "Trang trí bàn ăn theo phong cách tiệc sinh nhật",
    "Không dùng món ăn quá cay",
    "Dọn sẵn đĩa và dao cắt bánh",
    "Có món ăn phù hợp với người lớn tuổi",
    "Ghế sofa hoặc ghế đệm cho nhóm trẻ nhỏ",
    "Phục vụ trà nóng thay nước lạnh cho người lớn",
    "Thêm chỗ để xe đẩy cho trẻ em",
    "Không dùng rượu trong món ăn cho trẻ nhỏ",
    "Tách hóa đơn riêng cho từng người trong nhóm",
    ""
)

def generate_time_data(start_date: datetime, 
                      end_date: datetime, 
                      rows_per_day: int = 30, 
                      variance: float = 0.02) -> pd.DataFrame:
    """Tạo dữ liệu thời gian đặt chỗ hàng ngày."""
    days: int = (end_date - start_date).days + 1
    total_rows: int = days * rows_per_day
    

    dates = np.empty(total_rows, dtype='datetime64[D]')
    times = np.empty(total_rows, dtype='datetime64[s]')
    create_times = np.empty(total_rows, dtype='datetime64[s]')
    update_times = np.empty(total_rows, dtype='datetime64[s]')
    
    # Xác suất cho mỗi khoảng thời gian
    base_probabilities: NDArray = np.array([slot[2] for slot in TIME_SLOTS])
    base_probabilities /= base_probabilities.sum()
    
    idx = 0
    for day in range(days):
        current_date = start_date + timedelta(days=day)
        
        # Điều chỉnh xác suất cho từng ngày    
        adjusted_probabilities = base_probabilities * (1 + np.random.uniform(-variance, variance, len(base_probabilities)))
        adjusted_probabilities /= adjusted_probabilities.sum()
        
        # Tính số lượng dòng dữ liệu cho mỗi khoảng thời gian
        rows_per_slot = np.round(adjusted_probabilities * rows_per_day).astype(int)
        rows_per_slot[-1] += rows_per_day - rows_per_slot.sum()
        
        for slot_idx, (start_time, end_time, _) in enumerate(TIME_SLOTS):
            n_rows = rows_per_slot[slot_idx]
            if n_rows <= 0:
                continue
                
            start_dt = datetime.strptime(f"{current_date.strftime('%Y-%m-%d')} {start_time}", '%Y-%m-%d %H:%M')
            end_dt = datetime.strptime(f"{current_date.strftime('%Y-%m-%d')} {end_time}", '%Y-%m-%d %H:%M')
            
            if end_dt < start_dt:
                end_dt += timedelta(days=1)
            
            # Tạo thời gian ngẫu nhiên trong khoảng thời gian
            seconds_range = int((end_dt - start_dt).total_seconds())
            random_seconds = np.random.randint(0, seconds_range, n_rows)
            booking_times = np.array([start_dt + timedelta(seconds=int(s)) for s in random_seconds])
            
            # Tạo thời gian create_at và update_at
            create_at_deltas = np.random.randint(1440, 1485, n_rows)  # trong khoảng từ 24 tiếng trước đến trước 45 phút thời gian update
            update_at_deltas = np.random.randint(0, 46, n_rows)          # 0 đến 45 phút sau
            
            dates[idx:idx+n_rows] = booking_times.astype('datetime64[D]')
            times[idx:idx+n_rows] = booking_times
            create_times[idx:idx+n_rows] = np.array([t - timedelta(minutes=int(d)) for t, d in zip(booking_times, create_at_deltas)])
            update_times[idx:idx+n_rows] = np.array([t + timedelta(minutes=int(d)) for t, d in zip(booking_times, update_at_deltas)])
            
            idx += n_rows
    
    return pd.DataFrame({
        'date': dates,
        'time': times,
        'create_at': create_times,
        'update_at': update_times
    })

def generate_booking_data(df: pd.DataFrame, users: pd.DataFrame) -> pd.DataFrame:
    n_rows = len(df)
    
    # Tạo trạng thái ngẫu nhiên
    status_values = np.array([0, 1, 2], dtype=np.int16)
    status_probs = np.array([0.15, 0.65, 0.2])
    statuses = np.random.choice(status_values, size=n_rows, p=status_probs)
    
    # Tạo số lượng người ngẫu nhiên
    ranges = [(1, 4, 0.4), (5, 12, 0.35), (13, 20, 0.25)]
    all_values = np.concatenate([np.arange(start, end + 1) for start, end, _ in ranges])
    all_probs = np.concatenate([np.full(end - start + 1, prob / (end - start + 1)) 
                               for start, end, prob in ranges])
    num_people = np.random.choice(all_values, size=n_rows, p=all_probs)
    
    
    special_requests = np.random.choice(SPECIAL_REQUESTS, size=n_rows)
    
    # Chọn ngẫu nhiên user_id từ bảng users 
    # Tạo user_ids với ràng buộc về số lần đặt bàn
    user_ids = np.zeros(n_rows, dtype=int)
    booking_dates = pd.to_datetime(df['date']).dt.date
    unique_dates = booking_dates.unique()
    
    # Dictionary để theo dõi số lần đặt bàn của mỗi user theo ngày
    user_bookings: Dict[Tuple[int, datetime.date], list] = {}
    
    for idx in range(n_rows):
        current_date = booking_dates[idx]
        current_time = df['time'][idx].time()
        
        # Lọc users phù hợp (chưa đặt hoặc đã đặt 1 lần với thời gian khác)
        available_users = []
        for user_id in users['user_id']:
            booking_key = (user_id, current_date)
            if booking_key not in user_bookings:
                available_users.append(user_id)
            elif len(user_bookings[booking_key]) < 2:
                # Kiểm tra thời gian đặt trước đó
                existing_time = user_bookings[booking_key][0]
                if abs((current_time.hour - existing_time.hour)) >= 2:
                    available_users.append(user_id)
        
        if not available_users:
            # Nếu không còn user phù hợp, cho phép đặt lại từ đầu
            available_users = users['user_id'].tolist()
        
        # Chọn ngẫu nhiên một user từ danh sách phù hợp
        selected_user = np.random.choice(available_users)
        user_ids[idx] = selected_user
        
        # Cập nhật thông tin đặt bàn
        booking_key = (selected_user, current_date)
        if booking_key not in user_bookings:
            user_bookings[booking_key] = [current_time]
        else:
            user_bookings[booking_key].append(current_time)
                
    return pd.DataFrame({
        'booking_id': np.arange(n_rows),
        'date': df['date'],
        'time': df['time'].dt.time,
        'status': statuses,
        'num_people': num_people,
        'special_request': special_requests,
        'create_at': df['create_at'],
        'update_at': df['update_at'],
        'user_id': user_ids
    })

def create_booking_table(start_date: datetime, 
                        end_date: datetime, 
                        rows_per_day: int,
                        users: pd.DataFrame) -> pd.DataFrame:
    """Hàm chính để tạo bảng booking."""
    time_data = generate_time_data(start_date, end_date, rows_per_day)
    
    
    # Validate số lượng booking
    total_days = (end_date - start_date).days + 1
    expected_rows = total_days * rows_per_day
    assert len(time_data) == expected_rows, f"Expected {expected_rows} rows, got {len(time_data)}"
    
    return generate_booking_data(time_data, users)


if __name__ == "__main__":
    start_date = datetime(2024, 11, 1)
    end_date = datetime(2024, 11, 30)
    rows_per_day = 30
    
    booking = create_booking_table(start_date, end_date, rows_per_day, users)
    
