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
    // Create FormData object and append username and password
    // const formData = new FormData();
    // formData.append('username', loginData.username);
    // formData.append('password', loginData.password);
    console.log("email is", loginData.email)
    console.log("password is", loginData.password)
    const formData = new URLSearchParams();
    formData.append('grant_type', 'password');
    formData.append('username', loginData.email);
    formData.append('password', loginData.password);
    formData.append('scope', '');
    formData.append('client_id', '');
    formData.append('client_secret', '');
    // Send POST request with form data
    console.log(formData.toString());  // Outputs the URL-encoded data string

    const response = await axios.post('/login',formData, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded', // Ensure correct content type
      }
    });

    const token = response.data.access_token; // Get the token from the response

    // Set the token in axios headers for future requests
    axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;

    // Store the token in localStorage
    localStorage.setItem('authToken', token);

    // Redirect to another page after successful login
    window.location.href = '/'; // Thay bằng '/test' để thử API đăng nhập

  } catch (error) {
    console.error('Login failed:', error.response?.data?.detail || error);

    throw error;
  }
};

// Hàm helper giúp lấy token
export const getAuthToken = () => {
  return localStorage.getItem('authToken');
};

// Hàm ví dụ về quyền truy cập
// Sử dụng hàm dưới để có ví dụ về API và nhận token
export const fetchUserData = async () => {
  try {
    const token = getAuthToken();
    console.log("local authToken:",localStorage.getItem('authToken'))

    if (!token) throw new Error('No token found. Please login again.');

    const response = await axios.get('/users/me', 
      {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    return response.data;
  } catch (error) {
    console.error('Error fetching user data:', error);
    throw error;
  }
};
