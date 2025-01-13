import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Cart.css";
import { useNavigate } from "react-router-dom"; // Import useNavigate instead of useHistory

const Cart = () => {
  const [cart, setCart] = useState(null); // Holds the entire cart response
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // API base URL
  const API_URL = "/api/cart/cart"; // Replace with your FastAPI server URL

  // Retrieve the JWT token from localStorage
  const getAuthToken = () => localStorage.getItem("authToken");

  // Use navigate for page navigation
  const navigate = useNavigate(); // Hook for navigation

  // Fetch user's cart on component mount
  useEffect(() => {
    const fetchCart = async () => {
      const token = getAuthToken();
      if (!token) {
        setError("Authorization token is missing.");
        setLoading(false);
        return; // Exit early if token is missing
      }

      try {
        const response = await axios.get(`${API_URL}/1`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setCart(response.data);
      } catch (err) {
        setError("Failed to fetch cart data.");
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchCart();
  }, []);

  // Update the quantity of a dish
  const updateQuantity = async (dishId, quantity) => {
    const token = getAuthToken();
    if (!token) {
      alert("Authorization token is missing.");
      return;
    }

    try {
      const response = await axios.put(
        `${API_URL}/update-quantity/${cart.cart_id}/${dishId}?quantity=${quantity}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setCart(response.data);
    } catch (err) {
      console.error("Failed to update quantity:", err);
      alert("Error updating quantity.");
    }
  };

  // Remove a dish from the cart
  const removeDish = async (dishId) => {
    const token = getAuthToken();
    if (!token) {
      alert("Authorization token is missing.");
      return;
    }

    try {
      const response = await axios.delete(
        `${API_URL}/remove-dish/${cart.cart_id}/${dishId}`,
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
      setCart(response.data);
    } catch (err) {
      console.error("Failed to remove dish:", err);
      alert("Error removing dish.");
    }
  };

  // Redirect to checkout page
  const handleCheckout = () => {
    // If cart is empty, show an alert and return early
    if (cart.dishes.length === 0) {
      alert("Your cart is empty! Add some items before proceeding.");
      return;
    }
    
    // Navigate to the checkout page (replace with actual checkout URL)
    navigate("/Payment"); // You can change '/checkout' to the actual route for payment
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
