import React, { useState } from "react";
import "../styles/Log_Sign_In.css";
import { registerUser, loginUser } from "../api/Log_Sign_In_Api"; // Import API
import { createCart } from "../api/dishesApi" // Import createCart API"
import { Link } from "react-router-dom";

function Log_Sign_In() {
  const [isLogin, setIsLogin] = useState(true); // State to toggle between login and registration
  const [LoginFormData, setLoginFormData] = useState({
    email: "",
    password: "",
  });
  const [RegisterFormData, setRegisterFormData] = useState({
    email: "",
    password: "",
    name: "",
    age: "",
    gender: "",
    address: "",
    phone: "",
  });
  const [error, setError] = useState(""); // State to store error messages

  // Handle submit event for login or registration
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reset error state each time the user submits

    try {
      if (isLogin) {
        console.log("Đăng nhập...");
        // Call API for login
        const response = await loginUser({
          email: LoginFormData.email,
          password: LoginFormData.password,
        });

        console.log("Đăng nhập thành công:", response);
        alert("Đăng nhập thành công!");
      } else {
        console.log("Đăng ký...");
        // Call API for registration
        const response = await registerUser({
          email: RegisterFormData.email,
          password: RegisterFormData.password,
          user_name: RegisterFormData.name,
          age: RegisterFormData.age,
          gender: RegisterFormData.gender,
          address: RegisterFormData.address,
          phone: RegisterFormData.phone,
        });

        console.log("Registration successful:", response);
      alert(
        `Registration successful! Cart created with ID: ${response.cart_id}. Please log in.`
      );

        // Reset registration form data after successful registration
        setRegisterFormData({
          email: "",
          password: "",
          name: "",
          age: "",
          gender: "",
          address: "",
          phone: "",
        });
      }
    } catch (err) {
      console.error("Lỗi:", err);

      if (err.response) {
        // Check the status code for specific error handling
        switch (err.response.status) {
          case 400:
            setError("Email đã tồn tại hoặc thông tin không hợp lệ. Vui lòng kiểm tra lại.");
            break;
          case 401:
            setError("Sai thông tin đăng nhập. Vui lòng thử lại.");
            break;
          case 500:
            setError("Lỗi máy chủ. Vui lòng thử lại sau.");
            break;
          default:
            setError("Đã có lỗi xảy ra. Vui lòng thử lại.");
        }
      }
    }
  };

  return (
    <div className="log-sign-in-container">
      <div className="form-container">
        <div className="tabs">
          <button
            className={isLogin ? "active" : ""}
            onClick={() => setIsLogin(true)}
          >
            ĐĂNG NHẬP
          </button>
          <button
            className={!isLogin ? "active" : ""}
            onClick={() => setIsLogin(false)}
          >
            ĐĂNG KÝ
          </button>
        </div>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            {isLogin ? (
              <>
                <label htmlFor="email">Email</label>
                <input
                  type="email"
                  id="email"
                  required
                  value={LoginFormData.email}
                  onChange={(e) =>
                    setLoginFormData({ ...LoginFormData, email: e.target.value })
                  }
                />
                <label htmlFor="password">Mật khẩu</label>
                <input
                  type="password"
                  id="password"
                  required
                  pattern="^(?=.*\d)(?=.*[!@#$%^&*()\-=+[\]{}|;:,.<>?\/])[A-Za-z\d!@#$%^&*()\-=+[\]{}|;:,.<>?\/]{8,}$"
                  title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ số và một ký tự đặc biệt."
                  value={LoginFormData.password}
                  onChange={(e) =>
                    setLoginFormData({ ...LoginFormData, password: e.target.value })
                  }
                />
              </>
            ) : (
              <>
                <label htmlFor="name">Họ và tên</label>
                <input
                  type="text"
                  id="name"
                  required
                  value={RegisterFormData.name}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, name: e.target.value })
                  }
                />
                <label htmlFor="age">Tuổi</label>
                <input
                  type="number"
                  id="age"
                  required
                  min="16"
                  max="90"
                  title="Tuổi trong khoảng 16-90."
                  value={RegisterFormData.age}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, age: e.target.value })
                  }
                />
                <label htmlFor="gender">Giới tính</label>
                <input
                  type="text"
                  id="gender"
                  required
                  value={
                    RegisterFormData.gender === "M"
                      ? "Nam"
                      : RegisterFormData.gender === "F"
                      ? "Nữ"
                      : ""
                  }
                  onClick={(e) => {
                    const currentValue = RegisterFormData.gender;
                    const newValue = currentValue === "M" ? "F" : "M";
                    setRegisterFormData({ ...RegisterFormData, gender: newValue });
                  }}
                  readOnly
                  className="input-box"
                />
                <label htmlFor="address">Địa chỉ</label>
                <input
                  type="text"
                  id="address"
                  required
                  value={RegisterFormData.address}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, address: e.target.value })
                  }
                />
                <label htmlFor="email">Email</label>
                <input
                  type="email"
                  id="email"
                  required
                  value={RegisterFormData.email}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, email: e.target.value })
                  }
                />
                <label htmlFor="phone">Số điện thoại</label>
                <input
                  type="text"
                  id="phone"
                  required
                  pattern="^0\d{9}$"
                  maxLength={10}
                  title="Số điện thoại cần có 10 chữ số bắt đầu bằng số 0."
                  value={RegisterFormData.phone}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, phone: e.target.value })
                  }
                />
                <label htmlFor="password">Mật khẩu</label>
                <input
                  type="password"
                  id="password"
                  required
                  pattern="^(?=.*\d)(?=.*[!@#$%^&*()\-=+[\]{}|;:,.<>?\/])[A-Za-z\d!@#$%^&*()\-=+[\]{}|;:,.<>?\/]{8,}$"
                  title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ số và một ký tự đặc biệt."
                  value={RegisterFormData.password}
                  onChange={(e) =>
                    setRegisterFormData({ ...RegisterFormData, password: e.target.value })
                  }
                />
              </>
            )}
          </div>
          <button type="submit" className="submit-btn">
            {isLogin ? "Đăng nhập" : "Đăng ký"}
          </button>
          {isLogin && (
            <div className="lost-password">
              <a href="/LostPassword">Quên mật khẩu?</a>
            </div>
          )}
        </form>
        {error && <div className="error-message">{error}</div>}
      </div>
    </div>
  );
}

export default Log_Sign_In;
