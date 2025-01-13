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
import Payment from "./pages/Payment"
import FoodDes from "./pages/Food_Des"; // Import FoodDes page
import UserProfile from "./pages/test"; // UserProfile page
import Cart from "./pages/Cart";
import LostPassword from "./pages/Lost_Password";
import NewPassword from "./pages/New_Password";
import FoodDes from "./pages/Food_Des"; 
import Home_admin from "./admin/pages/Home_admin"; 
import Menu_managment from "./admin/pages/Menu_managment"
import User_managment from "./admin/pages/User_managment"
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import React from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

function App() {
  // Check if the user is authenticated (for example, using localStorage or a context)
  console.log(localStorage.getItem("authToken"))
  const isAuthenticated = localStorage.getItem("authToken") !== null;

  return (
    <div className="App">
      <Router>
        <Navbar />
        <Routes>
          {/* Conditionally protect the /set_table route */}
          {/* <Route
            path="/set_table"
            element={isAuthenticated ? <SetTable /> : <Navigate to="/log_sign_in" />}
          /> */}
          {/* Frontend cho user*/}
          <Route path="/" exact element={<Home />} />
          <Route path="/menu" exact element={<Menu />} />
          <Route path="/about" exact element={<About />} />
          <Route path="/contact" exact element={<Contact />} />
          <Route path="/set_table" exact element={<SetTable />} />
          <Route path="/log_sign_in" exact element={<LogSignIn />} />
          <Route path="/news" exact element={<News />} />
          <Route path="/food/:id" exact element={<FoodDes />} />

          <Route path="/Home_admin" exact element={<Home_admin />} />
          <Route path="/Menu_managment" exact element={<Menu_managment />} />
          <Route path="/User_managment" exact element={<User_managment />} />
          
          <Route path="/Test" element={<UserProfile />} />
          <Route path="/Payment" element={<Payment />} />
          <Route path="/Cart" element={<Cart />} />
          <Route path="/set_table" element={<SetTable />} />
          <Route path="/LostPassword" exact element={<LostPassword />} />
          <Route path="/NewPassword" exact element={<NewPassword />} />
        </Routes>
        <Footer />
      </Router>
    </div>
  );
}

export default App;
