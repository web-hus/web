import React, { useState } from "react";
import "../styles/Log_Sign_In.css"; // Use the same CSS for consistent styling
import { updatePassword } from "../api/Log_Sign_In_Api"; // API to update the password

function NewPassword() {
  const [formData, setFormData] = useState({ password: "", confirmPassword: "" });
  const [error, setError] = useState(""); // State for error message
  const [message, setMessage] = useState(""); // State for success message

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reset error message on form submission
    setMessage(""); // Reset success message on form submission

    if (formData.password !== formData.confirmPassword) {
      setError("Mật khẩu không trùng!.");
      return;
    }

    try {
      // Call API to update the password
      const response = await updatePassword(formData.password, formData.confirmPassword);
      setMessage("Đặt lại mật khẩu thành công!");
    } catch (err) {
      setError("Error: " + err.response || "Đã xảy ra lỗi.");
    }
  };

  return (
    <div className="log-sign-in-container">
      <div className="form-container">
        <h2>Đặt lại mật khẩu</h2>
        <p>Điền và xác nhận mật khẩu ở dưới.</p>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="password">Mật khẩu mới</label>
            <input
              type="password"
              id="password"
              required
              pattern="^(?=.*\d)(?=.*[!@#$%^&*()\-=+[\]{}|;:,.<>?\/])[A-Za-z\d!@#$%^&*()\-=+[\]{}|;:,.<>?\/]{8,}$"
              title="Password must be at least 8 characters, including a number and a special character."
              value={formData.password}
              onChange={(e) =>
                setFormData({ ...formData, password: e.target.value })
              }
            />
          </div>
          <div className="form-group">
            <label htmlFor="confirmPassword">Xác nhận mật khẩu</label>
            <input
              type="password"
              id="confirmPassword"
              required
              value={formData.confirmPassword}
              onChange={(e) =>
                setFormData({ ...formData, confirmPassword: e.target.value })
              }
            />
          </div>
          <button type="submit" className="submit-btn">
          Đặt lại mật khẩu
          </button>
        </form>
        {error && <div className="error-message">{error}</div>}
        {message && <div className="success-message">{message}</div>}
      </div>
    </div>
  );
}

export default NewPassword;
