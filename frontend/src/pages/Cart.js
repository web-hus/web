import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Cart.css";
import { useNavigate } from "react-router-dom"; // Import useNavigate
import { getUserProfile } from "../api/userAPI"; // Import the user profile API
import { getDishById } from "../api/dishesApi"; // Import getDishById function

const Cart = () => {
  const [cart, setCart] = useState(null); // Holds the entire cart response
  const [dishes, setDishes] = useState([]); // Store the dish details after fetching
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const API_URL = "/api/cart/cart"; // Replace with your FastAPI server URL
  const navigate = useNavigate(); // Hook for navigation

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
        const response = await axios.get(`${API_URL}/${userId}`, {
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
  
      // Send the updated quantity to the backend
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
      setDishes(dishes.filter((dish) => dish.dish_id !== dishId)); // Remove dish from state
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

  // Inline function to format price as currency
  const formatPrice = (price) => {
    if (isNaN(price) || price == null) {
      return "0đ"; // Default price if the value is invalid
    }
    return `${price.toLocaleString()}đ`;
  };

  if (loading) {
    return <p>Loading your cart...</p>;
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
      <h2>Your Shopping Cart</h2>
      {dishes.length === 0 ? (
        <p>Your cart is empty. Add some products!</p>
      ) : (
        <table className="cart-table">
          <thead>
            <tr>
              <th>Dish</th>
              <th>Quantity</th>
              <th>Price</th>
              <th>Subtotal</th>
              <th>Actions</th>
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
                      <button
                        className="remove-btn"
                        onClick={() => removeDish(item.dish_id)}
                      >
                        X
                      </button>
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
        <h3>Cart Summary</h3>
        <p>Total Items: {dishes.reduce((sum, item) => sum + item.quantity, 0)}</p>
        <p>Subtotal: {formatPrice(subtotal)}</p>
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
