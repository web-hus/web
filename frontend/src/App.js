import React, { useEffect } from 'react';

function App() {
  useEffect(() => {
    const apiUrl = process.env.REACT_APP_API_URL;
    console.log("API URL:", apiUrl);
    // Ví dụ gọi API
    fetch(`${apiUrl}/some-endpoint`)
      .then(response => response.json())
      .then(data => console.log(data))
      .catch(error => console.error("Error fetching data:", error));
  }, []);

  return <div className="App">My React App</div>;
}

document.body.style.backgroundColor = '#143B36'

export default App;
