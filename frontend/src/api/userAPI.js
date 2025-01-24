import axios from "axios";
import axiosInstance from "./api";

export const getUserProfile = async () => {
  try {
    const response = await axiosInstance.get("/api/profile/api/profile/me", {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("authToken")}`, // Add token if required
      },
    });
    return response.data; // Return the user data
  } catch (error) {
    console.error("Error fetching user profile:", error.response?.data || error.message);
    throw new Error("Failed to fetch user profile.");
  }
};