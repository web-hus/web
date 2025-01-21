import axios from 'axios';

// Hàm đăng ký người dùng mới
export const registerUser = async (userData) => {
  try {
    const response = await axios.post(`/api/auth/auth/register`, userData);
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

    const response = await axios.post('/api/auth/auth/token',formData, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded', // Ensure correct content type
      }
    });

    const token = response.data.access_token; // Get the token from the response

    // Set the token in axios headers for future requests
    axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;

    localStorage.setItem('authToken', token);
    
    window.location.href = '/'; // Thay bằng '/test' để thử API đăng nhập

  } catch (error) {
    console.error('Login failed:', error.response?.data?.detail || error);

    throw error;
  }
};

export async function requestPasswordReset(email) {
  try {
    const response = await axios.post('/password/forgot', { email });
    return response.data; // The response should include the message and expiration time
  } catch (error) {
    if (error.response) {
      // Server responded with a status outside of 2xx range
      throw new Error(error.response.data.detail || 'An error occurred while requesting a password reset.');
    } else if (error.request) {
      // No response received from the server
      throw new Error('No response from server. Please try again later.');
    } else {
      // Error in setting up the request
      throw new Error(error.message);
    }
  }
}

export async function updatePassword(password, confirmPassword) {
  try {
    // Extract the token from the URL
    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get('token');

    if (!token) {
      throw new Error('Reset token is missing from the URL.');
    }
    console.log(token)
    // Make the API call
    const response = await axios.post('/password/reset', {
      new_password: password,
      confirm_password: confirmPassword,
      token: token
    });

    return response.data; // Should contain a success message like "Password reset successfully"
  } catch (error) {
    if (error.response) {
      // Server responded with a status outside of 2xx range
      throw new Error(error.response.data.detail || 'An error occurred while updating the password.');
    } else if (error.request) {
      // No response received from the server
      throw new Error('No response from server. Please try again later.');
    } else {
      // Error in setting up the request
      throw new Error(error.message);
    }
  }
}