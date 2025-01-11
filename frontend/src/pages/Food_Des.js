import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getDishById } from "../api/dishesApi"; // API lấy dữ liệu món ăn theo ID
import "../styles/Food_Des.css";

function FoodDes() {
  const { id } = useParams(); // Lấy `dish_id` từ URL
  const [dish, setDish] = useState(null);

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
  const fileExtension = dish.dish_name.toLowerCase().includes('png') ? 'png' : 'jpg'; // Xác định định dạng ảnh
  const encodedIDName = encodeURIComponent(dish.dish_id);

  return (
    <div className="foodDesContainer">
      <h1>{dish.dish_name}</h1>

      <img
        src={`/images/food_img/${encodedIDName}.${fileExtension}`}
        onError={(e) => { e.target.src = '/images/default.jpg'; }}
        alt={dish.dish_name}
      />
      <p><strong>Giá:</strong> {dish.price.toLocaleString()} VND</p>
      <p><strong>Mô tả:</strong> {dish.description}</p>
    </div>
  );
}

export default FoodDes;
