// api/dishesApi.js
import axios from "axios";

export const getAllDishes = async () => {
  try {
    const response = await axios.get("/api/dish/dishes"); // Đảm bảo API backend chạy tại URL này
    return response.data; // Trả về danh sách món ăn
  } catch (error) {
    console.error("Error fetching dishes:", error);
    throw error;
  }
};

export const getDishById = async (id) => {
  try {
    const response = await axios.get(`/api/dish/dishes/${id}`); // Sử dụng axios để gọi API theo ID
    return response.data; // Trả về thông tin món ăn
  } catch (error) {
    console.error("Error fetching dish:", error);
    throw error; // Ném lỗi nếu có sự cố khi lấy dữ liệu
  }
};
