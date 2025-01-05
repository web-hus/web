import pandas as pd
from typing import Tuple
from create_order_food import order_dish
from create_users_table import users
from create_order_food import order_food
shopping_cart = pd.DataFrame({
    'cart_id': [None],
    'created_at': [None],
    'update_at': [None],
    'user_id': [None]
})


user_cart = pd.DataFrame({
    'cart_id': [None],
    'user_id': [None]
})


cart_dish = pd.DataFrame({
    'cart_id': [None],
    'dish_id': [None],
    'quantity': [None]
})

def create_shopping_tables(users_df: pd.DataFrame, 
                         order_food_df: pd.DataFrame,
                         order_dish_df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    """
    Tạo bảng shopping_cart, user_cart và cart_dish
    
    Tham số:
        users_df: DataFrame có dữ liệu người dùng
        order_food_df: DataFrame có dữ liệu order_food
        order_dish_df: DataFrame có dữ liệu order_dish

    Trả về tuple có 3 DataFrame: shopping_cart, user_cart và cart_dish
    """
    
    # Tạo shopping_cart
    def get_user_timestamps(user_id: int) -> Tuple[pd.Timestamp, pd.Timestamp]:
        user_orders = order_food_df[order_food_df['user_id'] == user_id]
        if len(user_orders) == 0:
            return pd.NaT, pd.NaT
        return user_orders['create_at'].min(), user_orders['create_at'].max()
    
    # Tạo DataFrame cho shopping_cart
    shopping_cart_data = []
    for user_id in users_df['user_id']:
        created_at, updated_at = get_user_timestamps(user_id)
        shopping_cart_data.append({
            'cart_id': user_id,
            'created_at': created_at,
            'update_at': updated_at,
            'user_id': user_id
        })
    
    shopping_cart = pd.DataFrame(shopping_cart_data)
    
    # Tạo user_cart (đơn giản hơn vì chỉ cần cart_id và user_id)
    user_cart = shopping_cart[['cart_id', 'user_id']].copy()
    
    # Tạo cart_dish
    def calculate_user_dish_quantities(user_id: int) -> list:
        # Lấy tất cả order_id của user
        user_orders = order_food_df[order_food_df['user_id'] == user_id]['order_id']
        
        if len(user_orders) == 0:
            return []
            
        # Lấy tất cả dish và quantity từ các order của user
        user_dishes = order_dish_df[order_dish_df['order_id'].isin(user_orders)]
        
        # Tổng hợp quantity theo dish_id
        dish_quantities = user_dishes.groupby('dish_id')['quantity'].sum().reset_index()
        
        # Tạo records cho cart_dish
        return [{
            'cart_id': user_id,
            'dish_id': row['dish_id'],
            'quantity': row['quantity']
        } for _, row in dish_quantities.iterrows()]
    
    # Tạo cart_dish records
    cart_dish_data = []
    for user_id in users_df['user_id']:
        cart_dish_data.extend(calculate_user_dish_quantities(user_id))
    
    cart_dish = pd.DataFrame(cart_dish_data)
    
    # Validation
    def validate_tables():
        # Kiểm tra unique cart_id trong shopping_cart
        assert not shopping_cart['cart_id'].duplicated().any(), "Duplicate cart_ids found"
        
        # Kiểm tra cart_id = user_id trong shopping_cart
        assert (shopping_cart['cart_id'] == shopping_cart['user_id']).all(), "cart_id must equal user_id"
        
        # Kiểm tra quantity trong cart_dish
        if not cart_dish.empty:
            assert (cart_dish['quantity'] >= 0).all(), "Negative quantities found"
            
        # Kiểm tra created_at <= update_at
        mask = shopping_cart[['created_at', 'update_at']].notna().all(axis=1)
        if mask.any():
            valid_timestamps = shopping_cart[mask]
            assert (valid_timestamps['created_at'] <= valid_timestamps['update_at']).all(), \
                "created_at must be <= update_at"
    
    validate_tables()
    
    return shopping_cart, user_cart, cart_dish

# Example usage:
if __name__ == "__main__":
    # Giả sử các DataFrame users, order_food, và order_dish đã có sẵn
    shopping_cart, user_cart, cart_dish = create_shopping_tables(users, order_food, order_dish)
    
    print("\nShopping Cart Summary:")
    print(shopping_cart.head(10))
    print("\nNull values in Shopping Cart:")
    print(shopping_cart.isnull().sum())
    
    print("\nUser Cart Summary:")
    print(user_cart.head())
    
    print("\nCart Dish Summary:")
    print(cart_dish.head(15))
    print("\nQuantity Statistics in Cart Dish:")
    if not cart_dish.empty:
        print(cart_dish['quantity'].describe())