import React, { useState, useEffect } from "react";
import { getAllDishes } from "../api/dishesApi";
import "../styles/Menu.css";
import { Link } from "react-router-dom";

function Menu() {
  const [dishes, setDishes] = useState([]);
  const [filteredDishes, setFilteredDishes] = useState([]);
  const [priceRange, setPriceRange] = useState([0, 1000000]);
  const [selectedCategory, setSelectedCategory] = useState("Tất cả");

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

  const handlePriceChange = (e) => {
    const value = e.target.value;
    setPriceRange(value === "Tất cả" ? [0, 1000000] : value.split("-").map(Number));
  };

  const handleCategoryChange = (e) => {
    setSelectedCategory(e.target.value);
  };

  useEffect(() => {
    const filtered = dishes.filter((dish) => {
      const isWithinPriceRange = dish.price >= priceRange[0] && dish.price <= priceRange[1];
      const isWithinCategory = selectedCategory === "Tất cả" || dish.product_category === selectedCategory;
      return isWithinPriceRange && isWithinCategory;
    });
    setFilteredDishes(filtered);
  }, [priceRange, selectedCategory, dishes]);

  return (
    <div className="menuContainer">
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
        
        <div className="filter">
          <h3>Lọc theo mức giá</h3>
          {["Tất cả","0-49000", "50000-99000", "100000-199000", "200000-1000000"].map((range, index) => (
            <label key={index}>
              <input type="radio" name="priceFilter" value={range} onChange={handlePriceChange} />
              {range === "Tất cả" ? "Tất cả" : range.replace("-", " - ") + " VND"}
            </label>
          ))}
        </div>

        <div className="filter">
          <h3>Lọc theo loại món ăn</h3>
          {["Tất cả", "Khai vị", "Món chính", "Món phụ", "Tráng miệng", "Đồ uống"].map((category, index) => (
            <div>
              <label key={index}>
              <input type="radio" name="categoryFilter" value={category} onChange={handleCategoryChange} />
              {category}
            </label>
            </div>
          ))}
        </div>
      </div>

      <div className="menuContent">
        <h1 className="menuTitle">Thực Đơn Nhà Hàng 3 Miền</h1>
        <div className="menuList">
          {filteredDishes.length > 0 ? (
            filteredDishes.map((dish) => {
              const fileExtension = dish.dish_name.toLowerCase().includes("png") ? "png" : "jpg";
              const encodedIDName = encodeURIComponent(dish.dish_id);
              return (
                <div className="menuItem" key={dish.dish_id}>
                  <img
                    src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                    onError={(e) => { e.target.src = "/images/default.jpg"; }}
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
