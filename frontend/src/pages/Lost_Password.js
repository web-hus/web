import React, { useState } from "react";
import "../styles/Log_Sign_In.css";
import { requestPasswordReset } from "../api/Log_Sign_In_Api"; // API to handle the password reset

function LostPassword() {
  const [formData, setFormData] = useState({ email: "" });
  const [error, setError] = useState(""); // State for error message
  const [message, setMessage] = useState(""); // State for success message

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reset error message on form submission
    setMessage(""); // Reset success message on form submission

    try {
      // Call API to request password reset
      // const response = await requestPasswordReset(formData.email);
      setMessage("Link đặt lại mật khẩu đã được gửi đến Email của bạn!");
    } catch (err) {
      setError("Error: " + err.response.data.detail || "Đã xảy ra lỗi");
    }
  };

  return (
    <div className="log-sign-in-container">
      <div className="form-container">
        <h2>Quên mật khẩu?</h2>
        <p>Điền Email của bạn và chúng tôi sẽ gửi cho bạn link để đặt lại mật khẩu.</p>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="email">Địa chỉ Email</label>
            <input
              type="email"
              id="email"
              required
              value={formData.email}
              onChange={(e) => setFormData({ email: e.target.value })}
            />
          </div>
          <button type="submit" className="submit-btn">
            Yêu cầu Link đặt lại
          </button>
        </form>
        {error && <div className="error-message">{error}</div>}
        {message && <div className="success-message">{message}</div>}
      </div>
    </div>
  );
}

export default LostPassword;
