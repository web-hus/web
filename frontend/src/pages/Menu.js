import React, { useState, useEffect } from "react";
import { getAllDishes } from "../api/dishesApi"; // API lấy dữ liệu món ăn
import "../styles/Menu.css";
import { Link } from "react-router-dom";

function Menu() {
  const [dishes, setDishes] = useState([]);
  const [filteredDishes, setFilteredDishes] = useState([]);
  const [priceRange, setPriceRange] = useState([0, 1000000]); // Mức giá mặc định
  const [selectedCategory, setSelectedCategory] = useState("all"); // Loại món ăn mặc định

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

  // Hàm xử lý thay đổi loại món ăn
  const handleCategoryChange = (e) => {
    setSelectedCategory(e.target.value);
  };

  // Lọc dữ liệu dựa trên giá và loại món ăn
  useEffect(() => {
    const filtered = dishes.filter((dish) => {
      const isWithinPriceRange =
        dish.price >= priceRange[0] && dish.price <= priceRange[1];
      const isWithinCategory =
        selectedCategory === "all" || dish.product_category === selectedCategory;

      return isWithinPriceRange && isWithinCategory;
    });

    setFilteredDishes(filtered);
  }, [priceRange, selectedCategory, dishes]);

  return (
    <div className="menuContainer">
      {/* Sidebar */}
      <div className="menuSidebar">
        <h2>Danh mục sản phẩm</h2>
        <ul>
          <li><Link to="/">Trang chủ</Link></li>
          <li><Link to="/about">Giới thiệu</Link></li>
          <li><Link to="/menu">Menu</Link></li>
          <li><Link to="/news">Tin tức</Link></li>
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
            50,000 - 99,000 VND
          </label>
          <label>
            <input
              type="radio"
              name="priceFilter"
              value="100000-199000"
              onChange={handlePriceChange}
            />
            100,000 - 199,000 VND
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

        {/* Bộ lọc loại món ăn */}
        <div className="filter">
          <h3>Lọc theo loại món ăn</h3>
          <select value={selectedCategory} onChange={handleCategoryChange}>
            <option value="all">Tất cả</option>
            <option value="Khai vị">Khai vị</option>
            <option value="Món chính">Món chính</option>
            <option value="Món phụ">Món phụ</option>
            <option value="Tráng miệng">Tráng miệng</option>
            <option value="Đồ uống">Đồ uống</option>
          </select>
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
              return (
                <div className="menuItem" key={dish.dish_id}>
                  <img
                    src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                    onError={(e) => { e.target.src = '/images/default.jpg'; }} // Ảnh mặc định khi không tìm thấy
                    alt={dish.dish_name}
                  />
                  <h2 className="menuItemName">{dish.dish_name}</h2>
                  <p className="menuItemPrice">{dish.price.toLocaleString()} VND</p>
                  <Link to={`/food/${dish.dish_id}`} className="menuItemButtonLink">
                    <div className="menuItemButton">Xem thêm</div>
                  </Link>
                </div>
              );
            })
          ) : (
            <p>Không có món ăn nào phù hợp.</p>
          )}
        </div>
      </div>
    </div>
  );
}

export default Menu;
