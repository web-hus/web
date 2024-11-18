import React from "react";
import MultiplePizzas from "../assets/multiplePizzas.jpeg";
import "../styles/About.css";
function About() {
  return (
    <div className="about">
      <div
        className="aboutTop"
        style={{ backgroundImage: `url(${MultiplePizzas})` }}
      ></div>
      <div className="aboutBottom">
        <h1> ABOUT US</h1>
        <p><strong>Welcome to Pizza Phe La - Hanoi's Freshest Slice of Italy!</strong></p>

        <p>Founded in 2024, Pizza Phe La brings the art of authentic Italian pizza to the bustling city of Hanoi, Vietnam. 
          Inspired by time-honored recipes and a passion for exceptional flavor, we pride ourselves on serving pizzas that 
          capture the essence of Italy, right here in your neighborhood. At Pizza Phe La, we believe that great pizzas start 
          with premium ingredients. We source our tomatoes from sun-soaked fields, our herbs from local growers, and our meats 
          and cheeses from trusted suppliers to ensure every bite is fresh and delicious. Our pizzas are baked to perfection in 
          traditional wood-fired ovens, giving them that unmistakable smoky flavor that only authentic techniques can provide. 
          Visit us at Pizza Phe La, where tradition, quality, and fresh ingredients come together to create a pizza experience 
          like no other. We look forward to welcoming you and sharing our love for pizza!</p>

      </div>
    </div>
  );
}

export default About;
