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
        <h1>Liên lạc chúng tôi</h1>

        {isSubmitted ? (
          <p className="successMessage" aria-live="polite">
            Gửi thành công!
          </p>
        ) : (
          <form id="contact-form" onSubmit={handleSubmit} method="POST">
            <label htmlFor="name">Tên</label>
            <input
              id="name"
              name="name"
              placeholder=""
              type="text"
              required
            />

            <label htmlFor="email">Email</label>
            <input
              id="email"
              name="email"
              placeholder=""
              type="email"
              required
            />

            <label htmlFor="message">Lời nhắn</label>
            <textarea
              id="message"
              name="message"
              rows="6"
              placeholder=""
              required
            ></textarea>

            <button type="submit">Gửi</button>
          </form>
        )}

        {/* OpenStreetMap embed with zoomed-in view of Hanoi (10x zoom) */}
        <div className="map-container">
          <iframe
            src="https://www.openstreetmap.org/export/embed.html?bbox=105.806440%2C20.994916%2C105.809578%2C20.996962&layer=mapnik"
            width="100%"
            height="400"
            frameBorder="0"
            scrolling="no"
            title="OpenStreetMap"
          />
          <br />
          <small>
            <a href="https://www.openstreetmap.org/?mlat=20.995939&mlon=105.808009#map=15/20.995939/105.808009">
              Mở rộng
            </a>
          </small>
        </div>
      </div>
    </div>
  );
}

export default Contact;
