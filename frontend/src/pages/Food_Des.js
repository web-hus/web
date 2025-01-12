import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getDishById } from "../api/dishesApi"; // API lấy dữ liệu món ăn theo ID
import "../styles/Food_Des.css";

function FoodDes() {
  const { id } = useParams(); // Lấy `dish_id` từ URL
  const [dish, setDish] = useState(null);
  const [quantity, setQuantity] = useState(1); // State để quản lý số lượng

  useEffect(() => {
    const fetchDish = async () => {
      try {
        const data = await getDishById(id); // Gọi API lấy thông tin món ăn
        setDish(data);
      } catch (error) {
        console.error("Failed to fetch dish:", error);
      }
    };

    fetchDish();
  }, [id]);

  if (!dish) {
    return <p>Loading...</p>;
  }

  const fileExtension = dish.dish_name.toLowerCase().includes("png")
    ? "png"
    : "jpg"; // Xác định định dạng ảnh
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
                <button className="addToCartBtn">Thêm vào giỏ hàng</button>
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
