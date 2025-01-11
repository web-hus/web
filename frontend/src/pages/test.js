import React, { useState } from 'react';
import { fetchUserData } from '../api/Log_Sign_In_Api';

function UserProfile() {
  const [userData, setUserData] = useState(null);
  const [error, setError] = useState(null);

  const handleFetchUserData = async () => {
    try {
      const data = await fetchUserData();
      setUserData(data);
    } catch (err) {
      setError(err.message);
    }
  };

  return (
    <div>
      <button onClick={handleFetchUserData}>Fetch User Data</button>
      
      {error && <div>Error: {error}</div>}
      {userData && (
        <div>
          <h1>User Profile</h1>
          <p>Email: {userData.email}</p>
          <p>Name: {userData.name}</p>
          {/* Render other user data */}
        </div>
      )}
    </div>
  );
}

export default UserProfile;
