import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Cart.css";
import { useNavigate } from "react-router-dom"; // Import useNavigate
import { getUserProfile } from "../api/userAPI"; // Import the user profile API

const Cart = () => {
  const [cart, setCart] = useState(null); // Holds the entire cart response
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = "/api/cart/cart"; // Replace with your FastAPI server URL
  const navigate = useNavigate(); // Hook for navigation

  // Fetch user's cart
  useEffect(() => {
    const fetchCart = async () => {
      try {
        const userProfile = await getUserProfile(); // Get user profile
        const userId = userProfile.user_id; // Extract user_id

        const token = localStorage.getItem("authToken");
        if (!token) {
          throw new Error("Authorization token is missing.");
        }

        const response = await axios.get(`${API_URL}/${userId}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        setCart(response.data); // Set the cart data
      } catch (err) {
        console.error("Failed to fetch cart:", err);
        setError(err.response?.data?.detail || "Failed to fetch cart.");
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

      const response = await axios.put(
        `${API_URL}/update-quantity/${cart.cart_id}/${dishId}`,
        null,
        {
          params: { quantity },
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      setCart(response.data); // Update cart with the new response
    } catch (err) {
      console.error("Failed to update quantity:", err);
      alert("Error updating quantity.");
    }
  };

  // Remove a dish from the cart
  const removeDish = async (dishId) => {
    try {
      const token = localStorage.getItem("authToken");
      if (!token) {
        throw new Error("Authorization token is missing.");
      }

      const response = await axios.delete(
        `${API_URL}/remove-dish/${cart.cart_id}/${dishId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );

      setCart(response.data); // Update cart with the new response
    } catch (err) {
      console.error("Failed to remove dish:", err);
      alert("Error removing dish.");
    }
  };

  // Redirect to checkout page
  const handleCheckout = () => {
    if (cart.dishes.length === 0) {
      alert("Your cart is empty! Add some items before proceeding.");
      return;
    }

    navigate("/Payment"); // Navigate to the checkout page
  };

  if (loading) {
    return <p>Loading your cart...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  const { dishes } = cart;

  return (
    <div className="cart">
      <h2>Your Shopping Cart</h2>
      {dishes.length === 0 ? (
        <p>Your cart is empty. Add some products!</p>
      ) : (
        <table className="cart-table">
          <thead>
            <tr>
              <th>Dish ID</th>
              <th>Quantity</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {dishes.map((dish) => (
              <tr key={dish.dish_id}>
                <td>{dish.dish_id}</td>
                <td>
                  <div className="quantity">
                    <button
                      onClick={() =>
                        updateQuantity(dish.dish_id, Math.max(dish.quantity - 1, 1))
                      }
                    >
                      -
                    </button>
                    <input
                      type="number"
                      value={dish.quantity}
                      onChange={(e) =>
                        updateQuantity(dish.dish_id, parseInt(e.target.value) || 1)
                      }
                      min="1"
                    />
                    <button
                      onClick={() => updateQuantity(dish.dish_id, dish.quantity + 1)}
                    >
                      +
                    </button>
                  </div>
                </td>
                <td>
                  <button
                    className="remove-btn"
                    onClick={() => removeDish(dish.dish_id)}
                  >
                    X
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      <div className="cart-summary">
        <h3>Cart Summary</h3>
        <p>Total Items: {dishes.reduce((sum, dish) => sum + dish.quantity, 0)}</p>
        <p>Last Updated: {new Date(cart.updated_at).toLocaleString()}</p>
      </div>

      <div className="checkout-section">
        <button className="checkout-btn" onClick={handleCheckout}>
          Proceed to Checkout
        </button>
      </div>
    </div>
  );
};

export default Cart;
