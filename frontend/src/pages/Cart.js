import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Cart.css";
import { useNavigate } from "react-router-dom"; // Import useNavigate
import { getUserProfile } from "../api/userAPI"; // Import the user profile API
import { getDishById } from "../api/dishesApi"; // Import getDishById function
import DeleteIcon from '@mui/icons-material/Delete';
import axiosInstance from "../api/api";

const Cart = () => {
  const [cart, setCart] = useState(null); // Holds the entire cart response
  const [dishes, setDishes] = useState([]); // Store the dish details after fetching
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = "/api/cart/cart"; // Replace with your FastAPI server URL
  const navigate = useNavigate(); // Hook for navigation

  useEffect(() => {
    const checkAuth = () => {
      const token = localStorage.getItem("authToken");
      if (!token) {
        alert("Bạn cần đăng nhập để xem giỏ hàng!");
        navigate("/log_sign_in"); // Redirect to sign-in page
      }
    };

    checkAuth();
  }, [navigate]);

  // Fetch user's cart and fetch dish details
  useEffect(() => {
    const fetchCart = async () => {
      try {
        const userProfile = await getUserProfile(); // Get user profile
        const userId = userProfile.user_id; // Extract user_id

        const token = localStorage.getItem("authToken");
        if (!token) {
          throw new Error("Authorization token is missing.");
        }

        // Fetch cart data
        const response = await axiosInstance.get(`${API_URL}/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        // Fetch dish details for each item in the cart
        const fetchedDishes = await Promise.all(
          response.data.dishes.map(async (item) => {
            const dishDetails = await getDishById(item.dish_id); // Fetch dish details by ID
            return { ...item, dish: dishDetails }; // Merge dish details with cart item
          })
        );

        setCart(response.data); // Set cart data
        setDishes(fetchedDishes); // Set the fetched dish details
      } catch (err) {
        console.error("Không thể tải giỏ hàng:", err);
        setError(err.response?.data?.detail || "Không thể tải giỏ hàng.");
      } finally {
        setLoading(false);
      }
    };

    fetchCart();
  }, []);

  // Update the quantity of a dish
  const updateQuantity = async (dishId, quantity) => {
    try {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authorization token is missing.");
      }

      // Send the updated quantity to the backend
      const response = await axiosInstance.put(
        `${API_URL}/update-quantity/${cart.cart_id}/${dishId}`,
        null,
        {
          params: { quantity },
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      // After successfully updating the quantity, update the state locally
      const updatedDishes = dishes.map((item) => {
        if (item.dish_id === dishId) {
          return { ...item, quantity }; // Update the quantity for the corresponding dish
        }
        return item;
      });

      setDishes(updatedDishes); // Update the dishes state to reflect the new quantity
      setCart(response.data); // Update cart data (to sync with the backend)

    } catch (err) {
      console.error("Không thể cập nhật số lượng:", err);
      alert("Lỗi khi cập nhật số lượng.");
    }
  };

  // Remove a dish from the cart
  const removeDish = async (dishId) => {
    try {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authorization token is missing.");
      }

      const response = await axiosInstance.delete(
        `${API_URL}/remove-dish/${cart.cart_id}/${dishId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      setCart(response.data); // Update cart with the new response
      setDishes(dishes.filter((dish) => dish.dish_id !== dishId)); // Remove dish from state
    } catch (err) {
      console.error("Không thể xóa món ăn:", err);
      alert("Lỗi khi xóa món ăn.");
    }
  };

  // Redirect to checkout page
  const handleCheckout = () => {
    if (cart.dishes.length === 0) {
      alert("Giỏ hàng của bạn đang trống! Thêm món ăn trước khi thanh toán.");
      return;
    }

    navigate("/Payment"); // Navigate to the checkout page
  };

  // Inline function to format price as currency
  const formatPrice = (price) => {
    if (isNaN(price) || price == null) {
      return "0đ"; // Default price if the value is invalid
    }
    return `${price.toLocaleString()}đ`;
  };

  if (loading) {
    return <p>Đang tải giỏ hàng của bạn...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  // Calculate subtotal for the cart
  const subtotal = dishes.reduce((sum, item) => {
    const dish = item.dish; // Accessing dish object from item
    if (dish && dish.price) {
      return sum + dish.price * item.quantity;
    }
    return sum; // Avoids the error and keeps sum intact
  }, 0);

  return (
    <div className="cart">
      <h2>Giỏ hàng của bạn</h2>
      {dishes.length === 0 ? (
        <p>Giỏ hàng của bạn đang trống. Hãy thêm sản phẩm!</p>
      ) : (
        <table className="cart-table">
          <thead>
            <tr>
              <th>Món Ăn</th>
              <th>Số Lượng</th>
              <th>Giá</th>
              <th>Tổng</th>
              <th>Hành Động</th>
            </tr>
          </thead>
          <tbody>
            {dishes.map((item) => {
              const dish = item.dish; // Destructure dish details from the item
              if (dish) {
                const subtotal = dish.price * item.quantity;
                return (
                  <tr key={item.dish_id}>
                    <td>
                      <div className="dish-details">
                        <img
                          src={`/images/food_img/${dish.dish_id}.jpg`}
                          alt={dish.dish_name}
                          className="product-image"
                        />
                        <span>{dish.dish_name}</span>
                      </div>
                    </td>
                    <td>
                      <div className="quantity">
                        <button
                          onClick={() =>
                            updateQuantity(item.dish_id, Math.max(item.quantity - 1, 1))
                          }
                        >
                          -
                        </button>
                        <input
                          type="number"
                          value={item.quantity}
                          onChange={(e) =>
                            updateQuantity(item.dish_id, parseInt(e.target.value) || 1)
                          }
                          min="1"
                        />
                        <button
                          onClick={() => updateQuantity(item.dish_id, item.quantity + 1)}
                        >
                          +
                        </button>
                      </div>
                    </td>
                    <td>{formatPrice(dish.price)}</td>
                    <td>{formatPrice(subtotal)}</td>
                    <td>
                      <DeleteIcon
                        onClick={() => removeDish(item.dish_id)}></DeleteIcon>
                    </td>
                  </tr>
                );
              } else {
                return null; // Handle case where dish details are missing
              }
            })}
          </tbody>
        </table>
      )}

      <div className="cart-summary">
        <h3>GIỎ HÀNG</h3>
        <p>Tổng số món: {dishes.reduce((sum, item) => sum + item.quantity, 0)}</p>
        <p>Tổng cộng: {formatPrice(subtotal)}</p>
        {/* <p>Cập nhật lần cuối: {new Date(cart.updated_at).toLocaleString()}</p> */}
      </div>

      <div className="checkout-section">
        <button className="checkout-btn" onClick={handleCheckout}>
          THANH TOÁN
        </button>
      </div>
    </div>
  );
};

export default Cart;
