import React, { useState } from "react";
import "../styles/Payment.css";

const Payment = () => {
  const [formData, setFormData] = useState({
    fullName: "",
    email: "",
    address: "",
    cardNumber: "",
    expirationDate: "",
    cvv: "",
  });

  const [paymentStatus, setPaymentStatus] = useState("");

  // Handle input change
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Handle form submission (simulated payment process)
  const handleSubmit = (e) => {
    e.preventDefault();

    // Simple validation for demonstration purposes
    if (formData.cardNumber && formData.cvv) {
      setPaymentStatus("Payment Successful! Thank you for your purchase.");
    } else {
      setPaymentStatus("Payment Failed. Please check your payment details.");
    }
  };

  return (
    <div className="Payment">
      <h2>Payment Information</h2>

      <div style={{ display: "flex", justifyContent: "space-between", marginTop: "20px" }}>
        {/* Form Section */}
        <div style={{ width: "65%", padding: "20px", borderRight: "1px solid #ccc" }}>
          <h3>Personal Information</h3>
          <form onSubmit={handleSubmit}>
            <div style={{ marginBottom: "10px" }}>
              <label>Full Name:</label>
              <input
                type="text"
                name="fullName"
                value={formData.fullName}
                onChange={handleChange}
                required
                placeholder="Enter your full name"
                style={{ width: "100%", padding: "10px", marginTop: "5px" }}
              />
            </div>

            <div style={{ marginBottom: "10px" }}>
              <label>Email:</label>
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                placeholder="Enter your email"
                style={{ width: "100%", padding: "10px", marginTop: "5px" }}
              />
            </div>

            <div style={{ marginBottom: "10px" }}>
              <label>Shipping Address:</label>
              <textarea
                name="address"
                value={formData.address}
                onChange={handleChange}
                required
                placeholder="Enter shipping address"
                style={{ width: "100%", padding: "10px", marginTop: "5px" }}
              />
            </div>

            <h3>Payment Information</h3>

            <div style={{ marginBottom: "10px" }}>
              <label>Card Number:</label>
              <input
                type="text"
                name="cardNumber"
                value={formData.cardNumber}
                onChange={handleChange}
                required
                placeholder="Card number"
                style={{ width: "100%", padding: "10px", marginTop: "5px" }}
              />
            </div>

            <div style={{ display: "flex", justifyContent: "space-between" }}>
              <div style={{ width: "48%", marginBottom: "10px" }}>
                <label>Expiration Date (MM/YY):</label>
                <input
                  type="text"
                  name="expirationDate"
                  value={formData.expirationDate}
                  onChange={handleChange}
                  required
                  placeholder="MM/YY"
                  style={{ width: "100%", padding: "10px", marginTop: "5px" }}
                />
              </div>

              <div style={{ width: "48%", marginBottom: "10px" }}>
                <label>CVV:</label>
                <input
                  type="text"
                  name="cvv"
                  value={formData.cvv}
                  onChange={handleChange}
                  required
                  placeholder="CVV"
                  style={{ width: "100%", padding: "10px", marginTop: "5px" }}
                />
              </div>
            </div>

            {/* Payment Button */}
            <div style={{ marginTop: "30px", display: "flex", justifyContent: "center" }}>
              <button
                type="submit"
                style={{
                  padding: "12px 30px",
                  backgroundColor: "#4CAF50",
                  color: "white",
                  border: "none",
                  borderRadius: "5px",
                  cursor: "pointer",
                  fontSize: "16px",
                }}
              >
                Confirm Payment
              </button>
            </div>
          </form>
        </div>

        {/* Cart Section */}
        <div style={{ width: "30%", padding: "20px" }}>
          <div
            style={{
              padding: "20px",
              border: "1px solid #ccc",
              borderRadius: "5px",
              backgroundColor: "#f9f9f9",
            }}
          >
            <h3>Order Summary</h3>
            <p><strong>Item 1:</strong> Awesome Product</p>
            <p><strong>Item 2:</strong> Another Great Product</p>
            <p><strong>Total Price:</strong> $49.99</p>
            <p style={{ fontWeight: "bold" }}>Total: $49.99</p>
          </div>
        </div>
      </div>

      {paymentStatus && (
        <div
          style={{
            padding: "10px",
            marginTop: "20px",
            border: "1px solid #ccc",
            backgroundColor: paymentStatus.includes("Failed") ? "#f8d7da" : "#d4edda",
            color: paymentStatus.includes("Failed") ? "#721c24" : "#155724",
            borderRadius: "5px",
            textAlign: "center",
          }}
        >
          {paymentStatus}
        </div>
      )}
    </div>
  );
};

export default Payment;
