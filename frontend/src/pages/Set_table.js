import React, { useState } from "react";
import PizzaLeft from "../assets/pizzaLeft.jpg";
import "../styles/Set_table.css";

function SetTable() {
    const [formData, setFormData] = useState({
      date: "",
      numberOfPeople: "",
      time: "",
      SpecialRequest: ""
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
    
      // Xử lý gửi form hoặc lưu dữ liệu
      alert("Đặt bàn thành công!");
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
              min={new Date().toISOString().split('T')[0]}
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
              min = "1"
              max = "50"
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
              value={formData.time || "09:00"} // Mặc định thời gian là 09:00
              onChange={handleChange}
              min="09:00" // Giới hạn giờ bắt đầu
              max="22:00" // Giới hạn giờ kết thúc (11:00 PM)
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