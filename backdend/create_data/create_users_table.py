import pandas as pd
import numpy as np
from typing import Tuple, List
import random
import string
import sys

sys.stdout.reconfigure(encoding='utf-8')

# Chuyển thành tuple để tối ưu bộ nhớ và tốc độ truy xuất
LAST_NAMES: Tuple[str, ...] = ("Nguyễn", "Trần", "Lê", "Phạm", "Hoàng", "Huỳnh", "Phan", "Vũ", "Võ", "Đặng", "Bùi", "Đỗ", "Hồ", "Ngô", "Dương", "Lý")
MIDDLE_NAMES_MALE: Tuple[str, ...] = ("Anh", "Minh", "Văn", "Gia", "Quang", "Thiên")
MIDDLE_NAMES_FEMALE: Tuple[str, ...] = ("Thị", "Thu", "Tuệ", "Thùy", "Khánh", "An", "Bích")
FIRST_NAMES_MALE: Tuple[str, ...] = ("Huy", "Khang", "Bảo", "Minh", "Phúc", "Khoa")
FIRST_NAMES_FEMALE: Tuple[str, ...] = ("Linh", "Chi", "Thư", "Nguyệt", "Lan", "Như")

def gen_random_password(min_length: int = 8, max_length: int = 20) -> str:
    special_chars: str = "!@#$%^&*()-_=+[]{}|;:,.<>?/"
    length: int = random.randint(min_length, max_length)
    chars: str = string.ascii_letters + string.digits + special_chars
    password: List[str] = random.choices(chars, k=length-1)
    password.insert(random.randint(0, length-1), random.choice(special_chars))
    return ''.join(password)

def gen_random_acc_name(length: int = 10) -> str:
    chars: str = string.ascii_letters + string.digits
    return ''.join(random.choices(chars, k=length))

def gen_random_phone_number() -> str:
    return f"0{random.randint(1,9)}{''.join(str(random.randint(0,9)) for _ in range(8))}"

def create_users_info(n: int) -> pd.DataFrame:
    """Tạo DataFrame với thông tin người dùng"""
    
    genders = np.random.choice(['M', 'F'], size=n)
    ages = np.random.randint(18, 66, n)
    user_ids = np.arange(1, n + 1)  # Bắt đầu từ 1
    user_roles = np.zeros(n, dtype=int)
    
    
    names = []
    passwords = []
    phones = []
    acc_names = set()
    
    for gender in genders:
        if gender == 'F':
            names.append(f"{random.choice(LAST_NAMES)} {random.choice(MIDDLE_NAMES_FEMALE)} {random.choice(FIRST_NAMES_FEMALE)}")
        else:  # 'M'
            names.append(f"{random.choice(LAST_NAMES)} {random.choice(MIDDLE_NAMES_MALE)} {random.choice(FIRST_NAMES_MALE)}")        
        
        passwords.append(gen_random_password())
        phones.append(gen_random_phone_number())
        
        while True:
            acc_name = gen_random_acc_name()
            if acc_name not in acc_names:
                acc_names.add(acc_name)
                break
    
    users_df = pd.DataFrame({
        'user_id': user_ids,
        'user_name': names,
        'gender': genders,
        'age': ages,
        'user_password': passwords,
        'user_role': user_roles,
        'phone': phones,
        'acc_name': list(acc_names)
    })
    
    
    return users_df


users = create_users_info(2000)
print(users.head())


