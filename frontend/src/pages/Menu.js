import React, { useState, useEffect } from "react";
import { getAllDishes } from "../api/dishesApi"; // API lấy dữ liệu món ăn
import "../styles/Menu.css";
import { Link } from "react-router-dom";

function Menu() {
  const [dishes, setDishes] = useState([]);
  const [filteredDishes, setFilteredDishes] = useState([]);
  const [priceRange, setPriceRange] = useState([0, 1000000]); // Mức giá mặc định
  const [categories, setCategories] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState(""); // Món ăn theo loại

  // Lấy danh sách món ăn và categories từ API
  useEffect(() => {
    const fetchDishes = async () => {
      try {
        const data = await getAllDishes();
        setDishes(data);
        setFilteredDishes(data);
        // Tạo danh sách categories từ món ăn đã lấy
        const uniqueCategories = [...new Set(data.map(dish => dish.product_category))];
        setCategories(uniqueCategories);
      } catch (error) {
        console.error("Failed to fetch dishes:", error);
      }
    };

    fetchDishes();
  }, []);

  // Hàm lọc món ăn theo mức giá và loại
  const handleFilterChange = () => {
    let filtered = dishes;

    // Lọc theo mức giá
    filtered = filtered.filter(dish => dish.price >= priceRange[0] && dish.price <= priceRange[1]);

    // Lọc theo loại món ăn
    if (selectedCategory) {
      filtered = filtered.filter(dish => dish.product_category === selectedCategory);
    }

    setFilteredDishes(filtered);
  };

  // Cập nhật giá khi thay đổi
  const handlePriceChange = (e) => {
    const value = e.target.value.split("-").map(Number);
    setPriceRange(value);
  };

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
          <select onChange={handlePriceChange}>
            <option value="0-50000">Dưới 50,000 VND</option>
            <option value="50000-100000">Từ 50,000 - 100,000 VND</option>
            <option value="100000-200000">Từ 100,000 - 200,000 VND</option>
            <option value="200000-1000000">Trên 200,000 VND</option>
          </select>
        </div>

        {/* Bộ lọc theo loại món ăn */}
        <div className="filter">
          <h3>Lọc theo loại món ăn</h3>
          <select onChange={(e) => setSelectedCategory(e.target.value)} value={selectedCategory}>
            <option value="">Tất cả</option>
            {categories.map((category, index) => (
              <option key={index} value={category}>{category}</option>
            ))}
          </select>
        </div>

        <button onClick={handleFilterChange}>Áp dụng bộ lọc</button>
      </div>

      {/* Nội dung món ăn */}
      <div className="menuContent">
        <h1 className="menuTitle">Menu</h1>
        <div className="menuList">
          {filteredDishes.length > 0 ? (
            filteredDishes.map((dish) => {
              const fileExtension = dish.dish_name.toLowerCase().includes('png') ? 'png' : 'jpg'; // Xác định định dạng ảnh
              const encodedDishName = encodeURIComponent(dish.dish_name);
              const encodedCategory = encodeURIComponent(dish.product_category);
              return (
                <div className="menuItem" key={dish.dish_id}>
                  <img
                    src={`/images/${encodedCategory}/${encodedDishName}.${fileExtension}`}
                    onError={(e) => { e.target.src = '/images/default.jpg'; }} // Ảnh mặc định khi không tìm thấy
                    alt={dish.dish_name}
                  />
                  <h2>{dish.dish_name}</h2>
                  <p>{dish.price.toLocaleString()} VND</p>
                  <button
                    className="viewMoreButton"
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
