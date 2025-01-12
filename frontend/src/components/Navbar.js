import React, { useState, useEffect } from "react";
import Logo from "../assets/Logo_res.png";
import { Link, useLocation, useNavigate } from "react-router-dom";
import SearchPopup from "./SearchPopup";

import SearchIcon from "@mui/icons-material/Search";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
import PlaceIcon from "@mui/icons-material/Place";
import PersonIcon from "@mui/icons-material/Person";
import "../styles/Navbar.css";

function Navbar() {
  const [openLinks, setOpenLinks] = useState(false);
  const [showSearchPopup, setShowSearchPopup] = useState(false);
  const location = useLocation(); // Detect route changes
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("authToken");
    navigate("/log_sign_in");
  };

  const isAuthenticated = localStorage.getItem("authToken") !== null;

  const toggleNavbar = () => {
    setOpenLinks(!openLinks);
  };

  const toggleSearchPopup = () => {
    setShowSearchPopup(!showSearchPopup);
  };

  useEffect(() => {
    // Close the popup whenever the route changes
    setShowSearchPopup(false);
  }, [location]);

  return (
    <div className="navbar">
      <div className="leftSide" id={openLinks ? "open" : "close"}>
        <img src={Logo} alt="Logo" />
      </div>
      <div className="rightSide">
        <div className="links">
          <Link to="/">Trang chủ</Link>
          <Link to="/menu">Thực đơn</Link>
          <Link to="/about">Giới thiệu</Link>
          <Link to="/news">Tin tức</Link>
          <Link to="/contact">Liên hệ</Link>
          <Link to="/set_table">Đặt bàn</Link>
          {isAuthenticated && (
            <Link to="/" className="nav-link" onClick={handleLogout}>
              Đăng xuất
            </Link>
          )}
        </div>
        <div className="Icon">
          <div className="icon-wrapper" onClick={toggleSearchPopup}>
            <SearchIcon />
          </div>
          <Link to="">
            <ShoppingCartIcon />
          </Link>
          <Link to="https://www.openstreetmap.org/?mlat=20.995939&mlon=105.808009#map=15/20.995939/105.808009">
            <PlaceIcon />
          </Link>
          <Link to="/log_sign_in">
            <PersonIcon />
          </Link>
        </div>
      </div>
      {showSearchPopup && <SearchPopup isVisible={showSearchPopup} />}
    </div>
  );
}

export default Navbar;
