import React, { useState } from "react";
import "../styles/Contact.css";

function Contact() {
  const [isSubmitted, setIsSubmitted] = useState(false);

  const handleSubmit = (event) => {
    event.preventDefault();
    setIsSubmitted(true);
    event.target.reset(); // Reset form fields after submission
  };

  return (
    <div className="contact">
      <div className="rightSide">
        <h1>Contact Us</h1>

        {isSubmitted ? (
          <p className="successMessage" aria-live="polite">
            Form submitted successfully!
          </p>
        ) : (
          <form id="contact-form" onSubmit={handleSubmit} method="POST">
            <label htmlFor="name">Full Name</label>
            <input
              id="name"
              name="name"
              placeholder="Enter full name..."
              type="text"
              required
            />

            <label htmlFor="email">Email</label>
            <input
              id="email"
              name="email"
              placeholder="Enter email..."
              type="email"
              required
            />

            <label htmlFor="message">Message</label>
            <textarea
              id="message"
              name="message"
              rows="6"
              placeholder="Enter message..."
              required
            ></textarea>

            <button type="submit">Send Message</button>
          </form>
        )}

        {/* OpenStreetMap embed with zoomed-in view of Hanoi (10x zoom) */}
        <div className="map-container">
          <iframe
            src="https://www.openstreetmap.org/export/embed.html?bbox=105.85%2C21.02%2C105.87%2C21.04&layer=mapnik"
            width="100%"
            height="400"
            frameBorder="0"
            scrolling="no"
            title="OpenStreetMap"
          />
          <br />
          <small>
            <a href="https://www.openstreetmap.org/?mlat=21.0285&mlon=105.8542#map=15/21.0285/105.8542">
              View Larger Map
            </a>
          </small>
        </div>
      </div>
    </div>
  );
}

export default Contact;
