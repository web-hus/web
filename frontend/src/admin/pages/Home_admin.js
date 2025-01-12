import React from "react";
// import { Link } from "react-router-dom";
import "../styles/Home_admin.css";
import bannerVideo from "../../assets/Now_in_your_area.mp4";

function Home_admin() {
  return (
    <div className="home">
      <video className="background-video" autoPlay loop muted>
        <source src={bannerVideo} type="video/mp4" />
      </video>
      <div className="headerContainer">
        <h1>3 Miền's Home</h1>
        <p>Trang quản lý chính thức nhà hàng 3 Miền </p>
      </div>
    </div>
  );
}

export default Home_admin;
