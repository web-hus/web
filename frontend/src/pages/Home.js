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
        <h1>Pizza Phe La</h1>
        <p>PIZZA TO FIT ANY TASTE</p>
        <Link to="/menu">
          <button>ORDER NOW</button>
        </Link>
      </div>
    </div>
  );
}

export default Home;