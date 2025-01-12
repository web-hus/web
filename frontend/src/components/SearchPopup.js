import React, { useState } from "react";
import "../styles/SearchPopup.css";

const SearchPopup = ({ isVisible }) => {
  const [searchQuery, setSearchQuery] = useState("");

  const searchResults = [
    { id: 1, name: "Cơm Chiên Hải Sản", price: "89.000₫", image: "https://via.placeholder.com/80x80" },
    { id: 2, name: "Cơm Sườn Nướng", price: "65.000₫", image: "https://via.placeholder.com/80x80" },
    { id: 3, name: "Cơm Đùi Gà Chiên Giòn", price: "58.000₫", image: "https://via.placeholder.com/80x80" },
    { id: 4, name: "Cơm Chả Cua Hoàng Kim", price: "75.000₫", image: "https://via.placeholder.com/80x80" },
  ];

  const handleSearchChange = (e) => {
    setSearchQuery(e.target.value);
  };

  const handleSearchSubmit = (e) => {
    e.preventDefault();
    alert(`Searching for: ${searchQuery}`);
  };

  if (!isVisible) return null;

  return (
    <div className="search-popup">
      <form onSubmit={handleSearchSubmit} className="search-form">
        <input
          type="text"
          placeholder="Tìm kiếm món ăn của bạn..."
          value={searchQuery}
          onChange={handleSearchChange}
          autoFocus
        />
        <button type="submit" className="search-button">
          🔍
        </button>
      </form>
      <div className="search-results">
        <h3>Kết quả tìm kiếm:</h3>
        <ul>
          {searchResults.map((result) => (
            <li key={result.id} className="search-item">
              <img src={result.image} alt={result.name} />
              <div className="item-details">
                <p className="item-name">{result.name}</p>
                <p className="item-price">{result.price}</p>
              </div>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default SearchPopup;
