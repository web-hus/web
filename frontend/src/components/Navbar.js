import React, { useState } from "react";
import Logo from "../assets/pizzaLogo.png";
import { Link } from "react-router-dom";
import SearchIcon from '@mui/icons-material/Search';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import PlaceIcon from '@mui/icons-material/Place';
import PersonIcon from '@mui/icons-material/Person';
import "../styles/Navbar.css";

function Navbar() {
  const [openLinks, setOpenLinks] = useState(false);

  const toggleNavbar = () => {
    setOpenLinks(!openLinks);
  };

  return (
    <div className="navbar">
      <div className="leftSide" id={openLinks ? "open" : "close"}>
        <img src={Logo} alt="Logo" />
      </div>
      <div className="rightSide">
        <div className="links">
          <Link to="/">Home</Link>
          <Link to="/menu">Menu</Link>
          <Link to="/about">About</Link>
          <Link to="/contact">Contact</Link>
          <Link to="/set_table">Đặt bàn</Link>
        </div>
        <div className="Icon">
          <Link to=""><SearchIcon /></Link>
          <Link to=""><ShoppingCartIcon /></Link>
          <Link to=""><PlaceIcon /></Link>
          <Link to="/log_sign_in"><PersonIcon /></Link>
        </div>
      </div>
    </div>
  );
}

export default Navbar;
