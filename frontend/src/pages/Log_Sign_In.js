import React, { useState } from "react";
import "../styles/Log_Sign_In.css";

function Log_Sign_In() {
  const [isLogin, setIsLogin] = useState(true); // Trạng thái để chuyển đổi giữa đăng nhập và đăng ký
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    firstName: "",
    lastName: "",
    phone: "",
  });

  // Hàm xử lý sự kiện khi nhấn nút Đăng Nhập hoặc Đăng Ký
  const handleSubmit = (e) => {
    e.preventDefault();

    if (isLogin) {
      console.log("Đăng nhập...");
      // Xử lý đăng nhập ở đây
    } else {
      // Xử lý đăng ký ở đây
      console.log("Đăng ký...");
      // Giả sử đăng ký thành công
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
        <div className="social-login">
          <button className="facebook">Facebook</button>
          <button className="google">Google</button>
        </div>
      </div>
    </div>
  );
}

export default Log_Sign_In;
