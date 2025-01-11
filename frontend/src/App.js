import React from "react";
import { BrowserRouter as Router, Route, Routes, Navigate } from "react-router-dom";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Menu from "./pages/Menu";
import About from "./pages/About";
import Contact from "./pages/Contact";
import SetTable from "./pages/Set_table";
import LogSignIn from "./pages/Log_Sign_In";
import News from "./pages/News";
import FoodDes from "./pages/Food_Des"; // Import FoodDes page
import UserProfile from "./pages/test"; // UserProfile page


function App() {
  // Check if the user is authenticated (for example, using localStorage or a context)
  console.log(localStorage.getItem("authToken"))
  const isAuthenticated = localStorage.getItem("authToken") !== null;

  return (
    <div className="App">
      <Router>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/menu" element={<Menu />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/log_sign_in" element={<LogSignIn />} />
          <Route path="/news" element={<News />} />
          <Route path="/food/:id" element={<FoodDes />} />
          <Route path="/Test" element={<UserProfile />} />

          {/* Conditionally protect the /set_table route */}
          <Route
            path="/set_table"
            element={isAuthenticated ? <SetTable /> : <Navigate to="/log_sign_in" />}
          />
        </Routes>
        <Footer />
      </Router>
    </div>
  );
}

export default App;
