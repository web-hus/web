from sqlalchemy import Column, String, Integer, Float, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    user_id = Column(String(10), primary_key=True)
    user_name = Column(String(100), nullable=False)
    age = Column(Integer, nullable=False)
    gender = Column(String(1), nullable=False)  # M: Nam, F: Nữ
    address = Column(String(255), nullable=False)
    email = Column(String(100), nullable=False, unique=True)
    phone = Column(String(20), nullable=False, unique=True)
    password = Column(String(255), nullable=False)
    role = Column(Integer, default=0)  # 0: Khách hàng, 1: Quản trị viên
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    # Relationships
    orders = relationship("Order", back_populates="user")
    cart = relationship("ShoppingCart", back_populates="user", uselist=False)
    bookings = relationship("Booking", back_populates="user")

class Dish(Base):
    __tablename__ = "dish"

    dish_id = Column(String(10), primary_key=True)
    dish_name = Column(String(100), nullable=False)
    product_category = Column(String(50), nullable=False)
    price = Column(Float, nullable=False)
    description = Column(String(500))
    availability = Column(Integer, default=1)  # 0: Hết hàng, 1: Còn hàng
    created_at = Column(DateTime, default=func.now())

class Booking(Base):
    __tablename__ = "booking"

    booking_id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    date = Column(DateTime, nullable=False)
    time = Column(String(5), nullable=False)  # Format: HH:MM
    num_people = Column(Integer, nullable=False)
    status = Column(Integer, default=0)  # 0: Đang chờ, 1: Đã xác nhận, 2: Hủy
    special_requests = Column(String(500))
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="bookings")
    orders = relationship("Order", back_populates="booking")

class Order(Base):
    __tablename__ = "orders"

    order_id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    order_type = Column(Integer, nullable=False)  # 0: Đến quán ăn, 1: Đơn mang về
    booking_id = Column(String(10), ForeignKey("booking.booking_id"), nullable=True)  # Chỉ có khi order_type = 0
    order_date = Column(DateTime, default=func.now())
    status = Column(Integer)  # 0: Chờ xử lý, 1: Đã xác nhận, 2: Đang giao, 3: Hoàn thành, 4: Hủy
    delivery_address = Column(String(255), nullable=True)  # Chỉ có khi order_type = 1
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="orders")
    booking = relationship("Booking", back_populates="orders")
    items = relationship("OrderDish", back_populates="order", cascade="all, delete-orphan")
    payment = relationship("Payment", back_populates="order", uselist=False)

class OrderDish(Base):
    __tablename__ = "order_dishes"

    order_id = Column(Integer, ForeignKey("orders.order_id"), primary_key=True)
    dish_id = Column(Integer, ForeignKey("dish.dish_id"), primary_key=True)
    quantity = Column(Integer, nullable=False)

    # Relationships
    order = relationship("Order", back_populates="items")
    dish = relationship("Dish")

class Payment(Base):
    __tablename__ = "payment"

    payment_id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)
    order_id = Column(Integer, ForeignKey("orders.order_id"), nullable=False)
    amount = Column(Float, nullable=False)
    payment_method = Column(Integer, nullable=False)  # 0: Online, 1: Khi nhận hàng
    payment_status = Column(Integer, default=0)  # 0: Đang xử lý, 1: Đã thanh toán, 2: Hoàn tiền
    payment_date = Column(DateTime, default=func.now())

    # Relationships
    user = relationship("User")
    order = relationship("Order", back_populates="payment")

class ShoppingCart(Base):
    __tablename__ = "shopping_cart"

    cart_id = Column(String(10), primary_key=True)
    user_id = Column(String(10), ForeignKey("users.user_id"), nullable=False)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

    # Relationships
    user = relationship("User", back_populates="cart")
    dishes = relationship("ShoppingCartDish", back_populates="cart", cascade="all, delete-orphan")

class ShoppingCartDish(Base):
    __tablename__ = "shopping_cart_dishes"

    cart_id = Column(String(10), ForeignKey("shopping_cart.cart_id"), primary_key=True)
    dish_id = Column(String(10), ForeignKey("dish.dish_id"), primary_key=True)
    quantity = Column(Integer, nullable=False)

    # Relationships
    cart = relationship("ShoppingCart", back_populates="dishes")
    dish = relationship("Dish")
