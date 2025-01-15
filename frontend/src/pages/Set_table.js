import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { getUserProfile } from "../api/userAPI"; // Import the user profile API

import axios from "axios";

import "../styles/Set_table.css";

function SetTable() {
  const [formData, setFormData] = useState({
    date: "",
    numberOfPeople: "",
    time: "",
    SpecialRequest: ""
  });

  const navigate = useNavigate(); // Initialize useNavigate
  const isAuthenticated = localStorage.getItem("authToken") !== null;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!isAuthenticated) {
      // Show alert and redirect to login
      alert("Bạn cần đăng nhập để đặt bàn!");
      navigate("/log_sign_in");
      return;
    }

    const token = localStorage.getItem("authToken");
    const userProfile = await getUserProfile();
    const userId = userProfile.user_id;

    // Step 1: Create booking
    const bookingData = {
      user_id: userId,
      date: formData.date,
      time: formData.time,
      num_people: formData.numberOfPeople,
      special_requests: formData.SpecialRequest,
    };

    try {
      console.log(bookingData)
      // Make the API request to create a booking
      const bookingResponse = await axios.post("/api/bookings/bookings/", bookingData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Booking created successfully:", bookingResponse.data);

      // Step 2: Create order after booking
      const orderData = {
        user_id: userId,
        order_type: 0,
        status:null,
        booking_id: bookingResponse.data.booking_id,
        delivery_address: null, // Assuming delivery address is empty for now, you can customize as per your requirement
        dishes: [], // Assuming no dishes for now, this should be handled as needed
      };
      console.log(orderData)
      // Create the order after the booking is successful
      const orderResponse = await axios.post("/api/orders/orders/", orderData, {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      console.log("Order created successfully:", orderResponse.data);
      
      // Redirect to the cart or order page after successfully creating the booking and order
      alert("Đặt bàn và đơn hàng đã được tạo thành công!");
    } catch (err) {
      console.error("Error creating booking or order:", err);
      alert("Có lỗi xảy ra khi đặt bàn. Vui lòng thử lại.");
    }
  };

  return (
    <div className="setTablePage">
      <div className="setTableContainer">
        <h2>Liên hệ đặt bàn</h2>
        <form onSubmit={handleSubmit} className="setTableForm">
          <div className="inputGroup">
            <label htmlFor="date">Bạn có thể đến dùng ngày nào?</label>
            <input
              type="date"
              id="date"
              name="date"
              required
              min={new Date().toISOString().split("T")[0]}
              value={formData.date}
              onChange={handleChange}
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="numberOfPeople">Bạn đi mấy người?</label>
            <input
              type="number"
              id="numberOfPeople"
              name="numberOfPeople"
              placeholder="Số người..."
              min="1"
              max="50"
              required
              value={formData.numberOfPeople}
              onChange={handleChange}
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="time">Thời gian bạn đến?</label>
            <input
              type="time"
              id="time"
              name="time"
              required
              value={formData.time || "09:00"} // Default time is 09:00
              onChange={handleChange}
              min="09:00" // Earliest allowed time
              max="22:00" // Latest allowed time
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="SpecialRequest">Bạn có yêu cầu đặc biệt nào không?</label>
            <input
              type="text"
              id="SpecialRequest"
              name="SpecialRequest"
              value={formData.SpecialRequest}
              onChange={handleChange}
            />
          </div>
          <div className="note">
            <p>
              Khách đặt tiệc hội nghị, liên hệ vui lòng gọi trực tiếp: 1900 6750
            </p>
          </div>
          <button type="submit" className="submitButton">
            Đặt bàn ngay
          </button>
        </form>
      </div>
    </div>
  );
}

export default SetTable;
