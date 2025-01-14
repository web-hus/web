import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getDishById, addToCart, getCartById } from "../api/dishesApi";
import "../styles/Food_Des.css";
import { getUserProfile } from "../api/userAPI";

function FoodDes() {
  const { id } = useParams();
  const [dish, setDish] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [message, setMessage] = useState("");
  const [cartId, setCartId] = useState(null);

  useEffect(() => {
    const fetchDish = async () => {
      try {
        const data = await getDishById(id);
        setDish(data);
      } catch (error) {
        console.error("Failed to fetch dish:", error);
      }
    };

    fetchDish();
  }, [id]);

  useEffect(() => {
    const fetchCart = async () => {
      try {
        const userProfile = await getUserProfile();
        const userId = userProfile.user_id;

        const cartData = await getCartById(userId);
        setCartId(cartData.cart_id);
      } catch (error) {
        console.error("Failed to fetch cart ID:", error);
      }
    };

    fetchCart();
  }, []);

  if (!dish) {
    return <p>Loading...</p>;
  }

  const fileExtension = dish.dish_name.toLowerCase().includes("png")
    ? "png"
    : "jpg";
  const encodedIDName = encodeURIComponent(dish.dish_id);

  const handleQuantityChange = (e) => {
    const value = parseInt(e.target.value, 10);
    if (!isNaN(value) && value > 0) {
      setQuantity(value);
    }
  };

  const incrementQuantity = () => {
    setQuantity((prevQuantity) => prevQuantity + 1);
  };

  const decrementQuantity = () => {
    setQuantity((prevQuantity) => (prevQuantity > 1 ? prevQuantity - 1 : 1));
  };

  const handleAddToCart = async () => {
    try {
      if (!cartId) {
        throw new Error("Cart ID not found.");
      }

      const cartData = {
        cart_id: cartId,
        dish_id: dish.dish_id,
        quantity: quantity,
      };

      const response = await addToCart(cartData);
      setMessage(response.message || "Đã thêm vào giỏ hàng!");
    } catch (error) {
      console.error("Failed to add to cart:", error);
      setMessage("Có lỗi xảy ra khi thêm vào giỏ hàng.");
    }
  };

  return (
    <div className="foodDesContainer">
      <div className="container text-center">
        <div className="row g-2">
          <div className="col-7">
            <div className="p-3">
              <div className="foodImageSection">
                <img
                  src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                  onError={(e) => {
                    e.target.src = "/images/default.jpg";
                  }}
                  alt={dish.dish_name}
                  className="foodImage"
                />
              </div>
            </div>
          </div>
          <div className="col-5">
            <div className="p-3">
              <div className="foodInfoSection">
                <h1 className="foodName">{dish.dish_name}</h1>
                <p className="foodPrice">{dish.price.toLocaleString()} VND</p>
                <h5>Số lượng</h5>
                <div className="input_number_product">
                  <button
                    className="button_qty"
                    onClick={decrementQuantity}
                    type="button"
                  >
                    -
                  </button>
                  <input
                    type="number"
                    id="qtym"
                    name="quantity"
                    value={quantity}
                    maxLength="3"
                    className="prd_quantity"
                    onChange={handleQuantityChange}
                  />
                  <button
                    className="button_qty"
                    onClick={incrementQuantity}
                    type="button"
                  >
                    +
                  </button>
                </div>
                <button className="addToCartBtn" onClick={handleAddToCart}>
                  Thêm vào giỏ hàng
                </button>
                {message && <p className="message">{message}</p>}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="foodDescription">
        <h3>Mô tả</h3>
        <p>{dish.description}</p>
      </div>
    </div>
  );
}

export default FoodDes;
