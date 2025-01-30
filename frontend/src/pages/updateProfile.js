import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/UpdateProfile.css";
import axiosInstance from "../api/api";

const UpdateProfile = () => {
  const [formData, setFormData] = useState({
    user_name: "",
    age: "",
    gender: "",
    address: "",
    email: "",
    phone: "",
    password: "",
  });

  const [loading, setLoading] = useState(false);
  const [successMessage, setSuccessMessage] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  // Fetch user profile data
  useEffect(() => {
    const fetchUserProfile = async () => {
      try {
        const response = await axiosInstance.get("/api/profile/api/profile/me", {
          headers: {
            Authorization: `Bearer ${localStorage.getItem("authToken")}`,
          },
        });
        setFormData(response.data);
      } catch (error) {
        console.error("Error fetching profile:", error);
        setErrorMessage("Failed to load profile data.");
      }
    };

    fetchUserProfile();
  }, []);

  // Handle input changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setSuccessMessage("");
    setErrorMessage("");

    try {
      const response = await axiosInstance.put("/api/profile/api/profile/me", formData, {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
      setSuccessMessage("Profile updated successfully!");
      setFormData(response.data); // Update the form data with the latest data
    } catch (error) {
      console.error("Error updating profile:", error);
      setErrorMessage(
        error.response?.data?.detail || "Failed to update profile."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="update-profile-container">
      <div className="form-container">
        <h2>Cập nhật thông tin</h2>
        {successMessage && <p className="success-message">{successMessage}</p>}
        {errorMessage && <p className="error-message">{errorMessage}</p>}
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="user_name">Họ và tên</label>
            <input
              type="text"
              id="user_name"
              name="user_name"
              required
              value={formData.user_name}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="age">Tuổi</label>
            <input
              type="number"
              id="age"
              name="age"
              min="16"
              max="90"
              required
              value={formData.age}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="gender">Giới tính (M/F)</label>
            <input
              type="text"
              id="gender"
              name="gender"
              required
              value={formData.gender}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="address">Địa chỉ</label>
            <input
              type="text"
              id="address"
              name="address"
              required
              value={formData.address}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input
              type="email"
              id="email"
              name="email"
              required
              value={formData.email}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="phone">Số điện thoại</label>
            <input
              type="text"
              id="phone"
              name="phone"
              required
              pattern="^0\d{9}$"
              title="Số điện thoại cần có 10 chữ số bắt đầu bằng số 0."
              value={formData.phone}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="password">Mật khẩu</label>
            <input
              type="password"
              id="password"
              name="password"
              required
              pattern="^(?=.*\d)(?=.*[!@#$%^&*()\-=+[\]{}|;:,.<>?\/])[A-Za-z\d!@#$%^&*()\-=+[\]{}|;:,.<>?\/]{8,}$"
              title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ số và một ký tự đặc biệt."
              value={formData.password}
              onChange={handleChange}
            />
          </div>
          <button type="submit" className="submit-btn" disabled={loading}>
            {loading ? "Đang cập nhật..." : "Cập nhật thông tin"}
          </button>
        </form>
      </div>
    </div>
  );
};

export default UpdateProfile;
