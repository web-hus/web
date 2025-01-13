import React, { useState, useEffect } from "react";
import axios from "axios";
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

  const [cart, setCart] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = "/api/cart/cart"; // Adjust this with your API endpoint

  // Retrieve the JWT token from localStorage
  const getAuthToken = () => localStorage.getItem("authToken");

  // Fetch cart data from the API
  useEffect(() => {
    const fetchCart = async () => {
      const token = getAuthToken();
      if (!token) {
        setError("Authorization token is missing.");
        setLoading(false);
        return;
      }

      try {
        const response = await axios.get(`${API_URL}/1`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        // Log the response data to inspect the structure
        console.log("Cart data:", response.data);

        // Assuming the API returns the cart in response.data.dishes
        if (response.data && response.data.dishes) {
          setCart(response.data.dishes);
        } else {
          setError("Cart data is missing the 'dishes' field.");
        }
      } catch (err) {
        setError("Failed to fetch cart data.");
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchCart();
  }, []);

  // Calculate subtotal for the cart
  const subtotal = cart.reduce((sum, item) => {
    // Ensure 'dish' and 'dish.price' exist before accessing them
    if (item.dish && item.dish.price) {
      return sum + item.dish.price * item.quantity;
    } else {
      console.error("Dish or dish.price is undefined for item:", item);
      return sum; // Avoids the error and keeps sum intact
    }
  }, 0);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setOrder((prev) => ({ ...prev, [name]: value }));
  };

  if (loading) {
    return <p>Loading cart items...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

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
          <h2>Đơn hàng ({cart.length} sản phẩm)</h2>
          <ul>
            {cart.map((item, index) => {
              const dish = item.dish; // Destructure dish from the item
              // Check if the dish and its properties exist before rendering
              if (dish && dish.dish_name && dish.price) {
                return (
                  <li key={index}>
                    <div className="product-details">
                      <img
                        src={dish.image || "https://via.placeholder.com/50"} // Fallback image if no dish image
                        alt={dish.dish_name}
                      />
                      <span>{dish.dish_name}</span>
                    </div>
                    <span>{dish.price}đ</span>
                    <span>x {item.quantity}</span>
                    <span>{dish.price * item.quantity}đ</span>
                  </li>
                );
              } else {
                console.error("Dish details are missing for item:", item);
                return null;
              }
            })}
          </ul>
          <div className="summary">
            <p>Tạm tính: {subtotal}đ</p>
            <p>Phí vận chuyển: -</p>
            <p>
              <strong>Tổng cộng: {subtotal}đ</strong>
            </p>
          </div>
          <button className="order-button">Đặt hàng</button>
        </div>
      </div>
    </div>
  );
};

export default Payment;
