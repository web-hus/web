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

export const addToCart = async (cartData) => {
  try {
    const response = await axios.post("/api/cart/cart/add-dish", cartData, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("authToken")}`, // Include token for authentication
      },
    });
    return response.data;
  } catch (error) {
    // Handle error gracefully
    console.error("Error adding dish to cart:", error.response?.data || error.message);
    throw new Error(
      error.response?.data?.detail || "Unable to add dish to cart. Please try again."
    );
  }
};

export const getCartById = async (cartId) => {
  try {
    const response = await axios.get(`/api/cart/cart/${cartId}`, {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("authToken")}`, // Add token if required
      },
    });
    return response.data; // Return the cart details
  } catch (error) {
    console.error("Error fetching cart:", error.response?.data || error.message);
    throw new Error("Failed to fetch cart details.");
  }
};

