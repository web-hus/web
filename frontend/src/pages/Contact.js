import React, { useState } from "react";
import PizzaLeft from "../assets/pizzaLeft.jpg";
import "../styles/Contact.css";

function Contact() {
  const [isSubmitted, setIsSubmitted] = useState(false);

  const handleSubmit = (event) => {
    event.preventDefault();
    setIsSubmitted(true);
  };

  return (
    <div className="contact">
      <div
        className="leftSide"
        style={{ backgroundImage: `url(${PizzaLeft})` }}
      ></div>
      <div className="rightSide">
        <h1>Contact Us</h1>

        {isSubmitted ? (
          <p className="successMessage">Form submitted successfully!</p>
        ) : (
          <form id="contact-form" onSubmit={handleSubmit} method="POST">
            <label htmlFor="name">Full Name</label>
            <input name="name" placeholder="Enter full name..." type="text" required />
            <label htmlFor="email">Email</label>
            <input name="email" placeholder="Enter email..." type="email" required />
            <label htmlFor="message">Message</label>
            <textarea
              rows="6"
              placeholder="Enter message..."
              name="message"
              required
            ></textarea>
            <button type="submit">Send Message</button>
          </form>
        )}
      </div>
    </div>
  );
}

export default Contact;
