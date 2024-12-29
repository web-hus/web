import React, { useState } from "react";
import { MenuList } from "../helpers/MenuList";
import MenuItem from "../components/MenuItem";
import { Link } from "react-router-dom"; 
import "../styles/Menu.css";

function Menu() {
  const [selectedPrice, setSelectedPrice] = useState(null);

  const filterByPrice = (menuItem) => {
    if (!selectedPrice) return true;
    const [min, max] = selectedPrice;
    return menuItem.price >= min && (!max || menuItem.price <= max);
  };

  return (
    <div className="menuPage">
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
        <h2>Chọn mức giá</h2>
        <div className="filter">
          <label>
            <input
              type="radio"
              name="price"
              onChange={() => setSelectedPrice([0, 100000])}
            />
            Dưới 100.000 VND
          </label>
          <label>
            <input
              type="radio"
              name="price"
              onChange={() => setSelectedPrice([100000, 200000])}
            />
            100.000 - 200.000 VND
          </label>
          <label>
            <input
              type="radio"
              name="price"
              onChange={() => setSelectedPrice([200000, 300000])}
            />
            200.000 - 300.000 VND
          </label>
          <label>
            <input type="radio" name="price" onChange={() => setSelectedPrice([300000])} />
            Trên 300.000 VND
          </label>
        </div>
      </div>
      <div className="menuContent">
        <h1 className="menuTitle">Tất cả món ăn</h1>
        <div className="menuList">
          {MenuList.filter(filterByPrice).map((menuItem, key) => (
            <MenuItem
              key={key}
              image={menuItem.image}
              name={menuItem.name}
              price={menuItem.price}
              discount={menuItem.discount}
            />
          ))}
        </div>
      </div>
    </div>
  );
}

export default Menu;
