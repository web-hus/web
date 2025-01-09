import axios from 'axios';

// Hàm đăng ký người dùng mới
export const registerUser = async (userData) => {
  try {
    const response = await axios.post(`/register`, userData);
    return response.data; // Trả về dữ liệu trả về từ API
  } catch (error) {
    console.error('Đăng ký thất bại:', error);
    throw error; // Ném lỗi để frontend xử lý
  }
};

// Hàm đăng nhập
export const loginUser = async (loginData) => {
  try {
    const response = await axios.post(`/login`, loginData);
    return response.data; // Trả về dữ liệu trả về từ API (ví dụ: token)
  } catch (error) {
    console.error('Đăng nhập thất bại:', error);
    throw error; // Ném lỗi để frontend xử lý
  }
};
