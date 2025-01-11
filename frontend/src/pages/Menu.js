import React, { useState, useEffect } from "react";
import { getAllDishes } from "../api/dishesApi"; // API lấy dữ liệu món ăn
import "../styles/Menu.css";
import { Link } from "react-router-dom";

function Menu() {
  const [dishes, setDishes] = useState([]);
  const [filteredDishes, setFilteredDishes] = useState([]);
  const [priceRange, setPriceRange] = useState([0, 1000000]); // Mức giá mặc định

  // Lấy danh sách món ăn từ API
  useEffect(() => {
    const fetchDishes = async () => {
      try {
        const data = await getAllDishes();
        setDishes(data);
        setFilteredDishes(data);
      } catch (error) {
        console.error("Failed to fetch dishes:", error);
      }
    };

    fetchDishes();
  }, []);

  // Cập nhật hàm handlePriceChange
  const handlePriceChange = (e) => {
    const value = e.target.value;
    if (value === "all") {
      setPriceRange([0, 1000000]); // Reset lại phạm vi giá
    } else {
      const [minPrice, maxPrice] = value.split('-').map(Number);
      setPriceRange([minPrice, maxPrice]);
    }
  };

  // Lọc món ăn theo mức giá đã chọn
  useEffect(() => {
    const filtered = dishes.filter(dish => dish.price >= priceRange[0] && dish.price <= priceRange[1]);
    setFilteredDishes(filtered);
  }, [priceRange, dishes]);

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

        {/* Bộ lọc giá */}
        <div className="filter">
          <h3>Lọc theo mức giá</h3>

          <label>
            <input
              type="radio"
              name="priceFilter"
              value="0-49000"
              onChange={handlePriceChange}
            />
            Dưới 50,000 VND
          </label>

          <label>
            <input
              type="radio"
              name="priceFilter"
              value="50000-99000"
              onChange={handlePriceChange}
            />
            Từ 50,000 - 99,000 VND
          </label>

          <label>
            <input
              type="radio"
              name="priceFilter"
              value="100000-199000"
              onChange={handlePriceChange}
            />
            Từ 100,000 - 199,000 VND
          </label>

          <label>
            <input
              type="radio"
              name="priceFilter"
              value="200000-1000000"
              onChange={handlePriceChange}
            />
            Trên 200,000 VND
          </label>

          <label>
            <input
              type="radio"
              name="priceFilter"
              value="all"
              onChange={handlePriceChange}
            />
            Tất cả
          </label>
        </div>

      </div>

      {/* Nội dung món ăn */}
      <div className="menuContent">
        <h1 className="menuTitle">Menu</h1>
        <div className="menuList">
          {filteredDishes.length > 0 ? (
            filteredDishes.map((dish) => {
              const fileExtension = dish.dish_name.toLowerCase().includes('png') ? 'png' : 'jpg'; // Xác định định dạng ảnh
              const encodedIDName = encodeURIComponent(dish.dish_id);
              // const encodedCategory = encodeURIComponent(dish.product_category);
              return (
                <div className="menuItem" key={dish.dish_id}>
                  <img
                    src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                    onError={(e) => { e.target.src = '/images/default.jpg'; }} // Ảnh mặc định khi không tìm thấy
                    alt={dish.dish_name}
                  />
                  <h2 className="menuItemName">{dish.dish_name}</h2>
                  <p className="menuItemPrice">{dish.price.toLocaleString()} VND</p>
                  <button
                    className="menuItemButton"
                    onClick={() => window.open(`/food/${dish.dish_id}`, "_blank")}
                  >
                    Xem thêm
                  </button>
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
