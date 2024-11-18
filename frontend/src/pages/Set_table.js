import React, { useState } from "react";
import PizzaLeft from "../assets/pizzaLeft.jpg";
import "../styles/Set_table.css";

function SetTable() {
    const [formData, setFormData] = useState({
      name: "",
      email: "",
      phone: "",
      date: "",
      numberOfPeople: "",
      time: "",
    });
  
    const handleChange = (e) => {
      const { name, value } = e.target;
      setFormData({
        ...formData,
        [name]: value,
      });
    };
  
    const handleSubmit = (e) => {
      e.preventDefault();
      // Xử lý gửi form hoặc lưu dữ liệu ở đây
      alert("Đặt bàn thành công!");
    };
  
    return (
        <div className="setTablePage">
      <div className="setTableContainer">
        <h2>Liên hệ đặt bàn</h2>
        <form onSubmit={handleSubmit} className="setTableForm">
          <div className="inputGroup">
            <label htmlFor="name">Tên của bạn:</label>
            <input
              type="text"
              id="name"
              name="name"
              placeholder="Tên của bạn..."
              value={formData.name}
              onChange={handleChange}
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="email">Email của bạn:</label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={formData.email}
              onChange={handleChange}
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="phone">Số điện thoại của bạn:</label>
            <input
              type="text"
              id="phone"
              name="phone"
              placeholder="Số điện thoại..."
              value={formData.phone}
              onChange={handleChange}
            />
          </div>
          <div className="inputGroup">
            <label htmlFor="date">Bạn có thể đến dùng ngày nào?</label>
            <input
              type="date"
              id="date"
              name="date"
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
              value={formData.time}
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