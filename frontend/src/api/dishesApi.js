// api/dishesApi.js
import axios from "axios";

export const getAllDishes = async () => {
  try {
    const response = await axios.get("/dishes"); // Đảm bảo API backend chạy tại URL này
    return response.data; // Trả về danh sách món ăn
  } catch (error) {
    console.error("Error fetching dishes:", error);
    throw error;
  }
};
