// api/config.js
import axios from "axios";

// Get the API base URL from the environment variable
const apiUrl = process.env.REACT_APP_API_URL || "http://localhost:8000"; 

// Create and export an axios instance with the base URL
const axiosInstance = axios.create({
  baseURL: apiUrl, // This will dynamically use the base URL based on the environment
});

export default axiosInstance;