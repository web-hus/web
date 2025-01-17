import React from "react";
import { Link } from "react-router-dom";
import "../styles/Home.css";
import bannerVideo from "../assets/Now_in_your_area.mp4";

function Home() {
  return (
    
    <div className="home">
      <video className="background-video" autoPlay loop muted>
        <source src={bannerVideo} type="video/mp4" />
      </video>
      <div className="headerContainer">
        <h1>ẨM THỰC 3 MIỀN</h1>
        <p>HƯƠNG VỊ TỪ NAM RA BẮC</p>
        <Link to="/menu">
          <button>Đặt hàng</button>
        </Link>
      </div>
    </div>
  );
}

export default Home;