import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Payment.css";
import { getUserProfile } from "../api/userAPI"; // Import the user profile API
import { getDishById } from "../api/dishesApi"; // Import the dish API function

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
  const [dishes, setDishes] = useState([]); // Store the fetched dish details

  const API_URL = "/api/cart/cart"; // Adjust this with your API endpoint

  // Retrieve the JWT token from localStorage
  const getAuthToken = () => localStorage.getItem("authToken");

  // Fetch cart data and dish details
  useEffect(() => {
    const fetchCart = async () => {
      const token = getAuthToken();
      const userProfile = await getUserProfile(); // Get user profile
      const userId = userProfile.user_id; // Extract user_id

      if (!token) {
        setError("Authorization token is missing.");
        setLoading(false);
        return;
      }

      try {
        const response = await axios.get(`${API_URL}/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        // Log the response data to inspect the structure
        console.log("Cart data:", response.data);

        if (response.data && response.data.dishes) {
          setCart(response.data.dishes);

          // Fetch dish details for each item in the cart
          const dishDetails = await Promise.all(
            response.data.dishes.map(async (item) => {
              const dishData = await getDishById(item.dish_id); // Fetch dish details by ID
              return { ...item, dish: dishData }; // Add dish details to the item
            })
          );

          setDishes(dishDetails); // Store the fetched dishes in state
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
  const subtotal = dishes.reduce((sum, item) => {
    const dish = item.dish; // Accessing dish object from item
    if (dish && dish.price) {
      return sum + dish.price * item.quantity;
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
          <h2>Đơn hàng ({dishes.length} sản phẩm)</h2>
          <ul>
            {dishes.map((item, index) => {
              const dish = item.dish; // Destructure dish from the item
              if (dish && dish.dish_name && dish.price) {
                const fileExtension = dish.dish_name.toLowerCase().includes("png")
                  ? "png"
                  : "jpg";
                return (
                  <li key={index}>
                    <div className="product-details">
                      <img
                        src={`/images/food_img/${dish.dish_id}.${fileExtension}`}
                        alt={dish.dish_name}
                        className="product-image"
                      />
                      <span>{dish.dish_name}</span>
                    </div>
                    <span>{dish.price.toLocaleString()}đ</span>
                    <span>x {item.quantity}</span>
                    <span>{(dish.price * item.quantity).toLocaleString()}đ</span>
                  </li>
                );
              } else {
                console.error("Dish details are missing for item:", item);
                return null;
              }
            })}
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
