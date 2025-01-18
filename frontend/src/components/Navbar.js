import React, { useState, useEffect } from "react";
import Logo from "../assets/Logo_res.png";
import { Link, useLocation, useNavigate } from "react-router-dom";
import SearchPopup from "./SearchPopup";

import SearchIcon from "@mui/icons-material/Search";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
import PlaceIcon from "@mui/icons-material/Place";
import PersonIcon from "@mui/icons-material/Person";
import "../styles/Navbar.css";

import { getUserProfile } from "../api/userAPI";

function Navbar() {
  const [openLinks, setOpenLinks] = useState(false);
  const [showSearchPopup, setShowSearchPopup] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false); // State to track admin status
  const location = useLocation(); // Detect route changes
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("authToken");
    setIsAdmin(false); // Reset isAdmin to false on logout
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

  // Fetch admin status when the component mounts
  useEffect(() => {
    const checkAdminStatus = async () => {
      try {
        const userProfile = await getUserProfile(); // Fetch user profile
        setIsAdmin(userProfile.role === 1); // Set admin status if role is 1
      } catch (error) {
        console.error("Failed to fetch user profile:", error);
        setIsAdmin(false); // Ensure isAdmin is false in case of error
      }
    };

    checkAdminStatus();
  }, []);

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

          {/* Admin Link - only visible if isAdmin is true */}
          {isAdmin && (
            <Link to="/Home_admin">Admin</Link>
          )}

          {/* Logout Link - only visible if the user is authenticated */}
          {isAuthenticated && (
            <Link to="/" className="nav-link" onClick={handleLogout}>
              Đăng xuất
            </Link>
          )}
        </div>
        <div className="Icon">
          {/* Uncomment Search Icon if needed */}
          {/* <div className="icon-wrapper" onClick={toggleSearchPopup}>
            <SearchIcon />
          </div> */}
          <Link to="/Cart">
            <ShoppingCartIcon />
          </Link>
          <a 
            href="https://www.openstreetmap.org/?mlat=20.995939&mlon=105.808009#map=15/20.995939/105.808009" 
            target="_blank" 
            rel="noopener noreferrer"
          >
            <PlaceIcon />
          </a>

          <Link to={isAuthenticated ? "/update_profile" : "/log_sign_in"}>
            <PersonIcon />
          </Link>
        </div>
      </div>
      {showSearchPopup && <SearchPopup isVisible={showSearchPopup} />}
    </div>
  );
}

export default Navbar;
