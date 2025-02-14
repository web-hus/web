import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom"; // Import useNavigate for redirection
import axiosInstance from "../api/api";

import "../styles/Payment.css";
import { getUserProfile } from "../api/userAPI"; // Import the user profile API
import { getDishById } from "../api/dishesApi"; // Import the dish API function

const Payment = () => {
  const navigate = useNavigate()
  const [order, setOrder] = useState({
    address: "",
    payment: "COD", // Default payment method
  });

  const [cart, setCart] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [dishes, setDishes] = useState([]);
  const [cartId, setCartId] = useState(null); // To store the cart ID

  const CART_API_URL = "/api/cart/cart";
  const CREATE_ORDER_API_URL = "/api/orders/orders";
  const CREATE_PAYMENT_API_URL = "/api/payments/payments";
  const CLEAR_CART_API_URL = "/api/cart/cart/clear"; // Endpoint to clear the cart

  const getAuthToken = () => localStorage.getItem("authToken");

  useEffect(() => {
    const fetchCart = async () => {
      const token = getAuthToken();
      const userProfile = await getUserProfile();
      const userId = userProfile.user_id;

      if (!token) {
        setError("Authorization token is missing.");
        setLoading(false);
        return;
      }

      try {
        const response = await axiosInstance.get(`${CART_API_URL}/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        if (response.data && response.data.dishes) {
          setCart(response.data.dishes);
          setCartId(response.data.cart_id); // Store cart ID

          const dishDetails = await Promise.all(
            response.data.dishes.map(async (item) => {
              const dishData = await getDishById(item.dish_id);
              return { ...item, dish: dishData };
            })
          );

          setDishes(dishDetails);
        } else {
          setError("Cart data is missing the 'dishes' field.");
        }
      } catch (err) {
        setError("Có lỗi xảy ra khi lấy giỏ hàng");
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchCart();
  }, []);

  const subtotal = dishes.reduce((sum, item) => {
    const dish = item.dish;
    if (dish && dish.price) {
      return sum + dish.price * item.quantity;
    } else {
      return sum;
    }
  }, 0);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setOrder((prev) => ({ ...prev, [name]: value }));
  };

  const clearCart = async () => {
    const token = getAuthToken();
    try {
      // Make a call to clear the cart
      await axiosInstance.delete(`${CLEAR_CART_API_URL}/${cartId}`, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      setCart([]); // Optionally, clear the cart state
    } catch (err) {
    }
  };

  const handleOrderSubmit = async () => {
    const token = getAuthToken();
    const userProfile = await getUserProfile();
    const userId = userProfile.user_id;

    // Step 1: Create the order
    const orderData = {
      user_id: userId,
      order_type: 1, // Assuming this is for delivery (order_type = 1)
      delivery_address: order.address,
      dishes: cart.map((item) => ({
        dish_id: item.dish_id,
        quantity: item.quantity,
      })),
    };

    try {
      const orderResponse = await axiosInstance.post(CREATE_ORDER_API_URL, orderData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Tạo đơn thành công", orderResponse.data);

      // Step 2: Create the payment
      const paymentData = {
        user_id: userId,
        order_id: orderResponse.data.order_id, // Link the payment to the created order
        amount: subtotal,
        payment_method: order.payment === "COD" ? 1 : 0, // 1: COD, 0: Online
        payment_status: 0, // Default status: "Đang xử lý"
      };

      console.log("PaymentData:", paymentData);
      const paymentResponse = await axiosInstance.post(CREATE_PAYMENT_API_URL, paymentData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Tạo thanh toán thành công", paymentResponse.data);

      // Step 3: Clear the cart after the order is placed and payment is created
      await clearCart();
      alert("Đơn hàng và thanh toán đã được tạo thành công!");
      navigate("/cart"); // Redirect to the cart page

    } catch (err) {
      console.error("Error creating order or payment:", err);
      alert("Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.");
    }
  };

  if (loading) {
    return <p>Đang lấy giỏ hàng</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  return (
    <div className="payment-container">
      <h1>ẨM THỰC 3 MIỀN</h1>
      <div className="content">
        <div className="order-form">
          <h2>Thông tin nhận hàng</h2>
          <form>
            <input
              type="text"
              name="address"
              placeholder="Địa chỉ nhận hàng"
              value={order.address}
              onChange={handleInputChange}
            />
          </form>
        </div>

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

        <div className="order-summary">
          <h2>Đơn hàng ({dishes.length} sản phẩm)</h2>
          <ul>
            {dishes.map((item, index) => {
              const dish = item.dish;
              if (dish && dish.dish_name && dish.price) {
                return (
                  <li key={index}>
                    <div className="product-details">
                      <img
                        src={`/images/food_img/${dish.dish_id}.jpg`}
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
          <button className="order-button" onClick={handleOrderSubmit}>
            Đặt hàng
          </button>
        </div>
      </div>
    </div>
  );
};

export default Payment;
