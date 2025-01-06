import React, { useEffect, useState } from "react";
import { getAllDishes } from "../api/dishesApi"; // API lấy dữ liệu món ăn
import "../styles/Menu.css";
import { Link } from "react-router-dom";

function Menu() {
  const [dishes, setDishes] = useState([]);

  useEffect(() => {
    const fetchDishes = async () => {
      try {
        const data = await getAllDishes();
        setDishes(data);
      } catch (error) {
        console.error("Failed to fetch dishes:", error);
      }
    };

    fetchDishes();
  }, []);

  return (
    <div className="menuContainer">
      {/* Sidebar */}
      <div className="menuSidebar">
        <h2>Danh mục sản phẩm</h2>
        <ul>
          <li><Link to="/">Trang chủ</Link></li>
          <li><Link to="/about">Giới thiệu</Link></li>
          <li><Link to="/menu">Menu</Link></li>
          <li>Món ăn nổi bật</li>
          <li>Tin tức</li>
          <li><Link to="/contact">Liên hệ</Link></li>
          <li><Link to="/set_table">Đặt bàn</Link></li>
        </ul>
      </div>

      {/* Nội dung món ăn */}
      <div className="menuContent">
        <h1 className="menuTitle">Menu</h1>
        <div className="menuList">
        {dishes.length > 0 ? (
            dishes.map((dish) => {
              const fileExtension = dish.dish_name.toLowerCase().includes('png') ? 'png' : 'jpg'; // xác định định dạng ảnh
              const encodedDishName = encodeURIComponent(dish.dish_name); // mã hóa tên món ăn
              const encodedCategory = encodeURIComponent(dish.product_category); // mã hóa tên danh mục
              
              return (
                <div className="menuItem" key={dish.dish_id}>
                  <img
                    src={`/images/${encodedCategory}/${encodedDishName}.${fileExtension}`}
                    onError={(e) => { e.target.src = '/images/default.jpg'; }} // ảnh mặc định khi không tìm thấy
                    alt={dish.dish_name}
                  />
                  <h2>{dish.dish_name}</h2>
                  <p>{dish.price.toLocaleString()} VND</p>
                </div>
              );
            })
          ) : (
            <p>Loading dishes...</p>
          )}
        </div>
      </div>
    </div>
  );
}

export default Menu;
