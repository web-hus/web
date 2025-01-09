import React, { useState } from "react";
import "../styles/Log_Sign_In.css";
import { registerUser, loginUser } from "../api/Log_Sign_In_Api"; // Import API

function Log_Sign_In() {
  const [isLogin, setIsLogin] = useState(true); // Trạng thái để chuyển đổi giữa đăng nhập và đăng ký
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    firstName: "",
    lastName: "",
    phone: "",
  });
  const [error, setError] = useState(""); // Thêm state để lưu lỗi nếu có

  // Hàm xử lý sự kiện khi nhấn nút Đăng Nhập hoặc Đăng Ký
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(""); // Reset lỗi mỗi khi người dùng nhấn submit

    try {
      if (isLogin) {
        console.log("Đăng nhập...");
        // Gọi API đăng nhập
        const response = await loginUser({
          email: formData.email,
          password: formData.password,
        });
        console.log("Đăng nhập thành công:", response);
        alert("Đăng nhập thành công!");
      } else {
        console.log("Đăng ký...");
        // Gọi API đăng ký
        const response = await registerUser({
          email: formData.email,
          password: formData.password,
          firstName: formData.firstName,
          lastName: formData.lastName,
          phone: formData.phone,
        });
        console.log("Đăng ký thành công:", response);
        alert("Đăng ký thành công! Vui lòng đăng nhập.");
        
        // Reset lại form sau khi đăng ký thành công
        setFormData({
          email: "",
          password: "",
          firstName: "",
          lastName: "",
          phone: "",
        });
      }
    } catch (err) {
      console.error("Lỗi:", err);
      setError("Đã có lỗi xảy ra. Vui lòng thử lại.");
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
                  placeholder="ví dụ: nguyenvana@gmai.com"
                  required
                  value={formData.email}
                  onChange={(e) =>
                    setFormData({ ...formData, email: e.target.value })
                  }
                />
                <label htmlFor="password">Mật khẩu</label>
                <input
                  type="password"
                  id="password"
                  placeholder="Nhập mật khẩu của bạn"
                  required
                  pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$"
                  title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và ký tự đặc biệt."
                  value={formData.password}
                  onChange={(e) =>
                    setFormData({ ...formData, password: e.target.value })
                  }
                />
              </>
            ) : (
              <>
                <label htmlFor="firstName">Họ</label>
                <input
                  type="text"
                  id="firstName"
                  placeholder="ví dụ: Nguyễn"
                  required
                  value={formData.firstName}
                  onChange={(e) =>
                    setFormData({ ...formData, firstName: e.target.value })
                  }
                />
                <label htmlFor="lastName">Tên</label>
                <input
                  type="text"
                  id="lastName"
                  placeholder="ví dụ: Văn A"
                  required
                  value={formData.lastName}
                  onChange={(e) =>
                    setFormData({ ...formData, lastName: e.target.value })
                  }
                />
                <label htmlFor="email">Email</label>
                <input
                  type="email"
                  id="email"
                  placeholder="ví dụ: nguyenvana@gmai.com"
                  required
                  value={formData.email}
                  onChange={(e) =>
                    setFormData({ ...formData, email: e.target.value })
                  }
                />
                <label htmlFor="phone">Số điện thoại</label>
                <input
                  type="text"
                  id="phone"
                  placeholder="ví dụ: 0123456789"
                  required
                  value={formData.phone}
                  onChange={(e) =>
                    setFormData({ ...formData, phone: e.target.value })
                  }
                />
                <label htmlFor="password">Mật khẩu</label>
                <input
                  type="password"
                  id="password"
                  placeholder="Nhập mật khẩu của bạn"
                  required
                  pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$"
                  title="Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và ký tự đặc biệt."
                  value={formData.password}
                  onChange={(e) =>
                    setFormData({ ...formData, password: e.target.value })
                  }
                />
              </>
            )}
          </div>
          <button type="submit" className="submit-btn">
            {isLogin ? "Đăng nhập" : "Đăng ký"}
          </button>
        </form>
        {error && <div className="error-message">{error}</div>}
        <div className="social-login">
          <button className="facebook">Facebook</button>
          <button className="google">Google</button>
        </div>
      </div>
    </div>
  );
}

export default Log_Sign_In;
