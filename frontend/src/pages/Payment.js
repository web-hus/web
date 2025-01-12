import React, { useState } from "react";
import "../styles/Payment.css";

const Payment = () => {
  const [order, setOrder] = useState({
    name: "",
    address: "",
    city: "",
    district: "",
    ward: "",
    notes: "",
    payment: "COD",
  });

  const products = [
    {
      name: "Gỏi tai heo hoa chuối",
      price: 125000,
      image: "https://via.placeholder.com/50",
    },
    {
      name: "Canh mướp hương nhồi thịt",
      price: 120000,
      image: "https://via.placeholder.com/50",
    },
    {
      name: "Cơm sườn nướng",
      price: 65000,
      image: "https://via.placeholder.com/50",
    },
  ];

  const subtotal = products.reduce((sum, item) => sum + item.price, 0);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setOrder((prev) => ({ ...prev, [name]: value }));
  };

  return (
    <div className="payment-container">
      <h1>Dola Restaurant</h1>
      <div className="content">
        {/* Order Form */}
        <div className="order-form">
          <h2>Thông tin nhận hàng</h2>
          <form>
            <input
              type="text"
              name="name"
              placeholder="Họ và tên"
              value={order.name}
              onChange={handleInputChange}
            />
            <input
              type="text"
              name="address"
              placeholder="Địa chỉ (tùy chọn)"
              value={order.address}
              onChange={handleInputChange}
            />
            <select
              name="city"
              value={order.city}
              onChange={handleInputChange}
            >
              <option value="">Tỉnh thành</option>
              <option value="hanoi">Hà Nội</option>
              <option value="hcm">Hồ Chí Minh</option>
            </select>
            <select
              name="district"
              value={order.district}
              onChange={handleInputChange}
            >
              <option value="">Quận huyện (tùy chọn)</option>
            </select>
            <select
              name="ward"
              value={order.ward}
              onChange={handleInputChange}
            >
              <option value="">Phường xã (tùy chọn)</option>
            </select>
            <textarea
              name="notes"
              placeholder="Ghi chú (tùy chọn)"
              value={order.notes}
              onChange={handleInputChange}
            />
          </form>
        </div>

        {/* Payment Options */}
        <div className="payment-options">
          <h2>Thanh toán</h2>
          <div className="payment-method">
            <label>
              <input
                type="radio"
                name="payment"
                value="COD"
                checked={order.payment === "COD"}
                onChange={handleInputChange}
              />
              Thanh toán khi giao hàng (COD)
            </label>
            <label>
              <input
                type="radio"
                name="payment"
                value="Online"
                checked={order.payment === "Online"}
                onChange={handleInputChange}
              />
              Thanh toán online
            </label>
          </div>
        </div>

        {/* Order Summary */}
        <div className="order-summary">
          <h2>Đơn hàng ({products.length} sản phẩm)</h2>
          <ul>
            {products.map((product, index) => (
              <li key={index}>
                <div className="product-details">
                  <img src={product.image} alt={product.name} />
                  <span>{product.name}</span>
                </div>
                <span>{product.price.toLocaleString()}đ</span>
              </li>
            ))}
          </ul>
          <div className="summary">
            <p>Tạm tính: {subtotal.toLocaleString()}đ</p>
            <p>Phí vận chuyển: -</p>
            <p>
              <strong>Tổng cộng: {subtotal.toLocaleString()}đ</strong>
            </p>
          </div>
          <button className="order-button">Đặt hàng</button>
        </div>
      </div>
    </div>
  );
};

export default Payment;
