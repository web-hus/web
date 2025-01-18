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
import Payment from "./pages/Payment";
import FoodDes from "./pages/Food_Des";
import Cart from "./pages/Cart";
import LostPassword from "./pages/Lost_Password";
import NewPassword from "./pages/New_Password";
import Home_admin from "./admin/pages/Home_admin";
import Menu_managment from "./admin/pages/Menu_managment"
import User_managment from "./admin/pages/User_managment"
import Dashboard from "./admin/pages/Dashboard"
import Booking_managment from "./admin/pages/Booking_managment"
import Order_managment from "./admin/pages/Order_managment"
import Booking_order from "./admin/pages/Booking_order"
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

import { getUserProfile } from "./api/userAPI";

function App() {
  const isAuthenticated = localStorage.getItem("authToken") !== null;
  const [isAdmin, setIsAdmin] = React.useState(() =>
    localStorage.getItem("isAdmin") === "true"
  );
  const [isLoading, setIsLoading] = React.useState(true); // Add loading state

  React.useEffect(() => {
    const fetchAdminStatus = async () => {
      if (isAuthenticated) {
        try {
          const userProfile = await getUserProfile();
          const isAdminStatus = userProfile.role === 1;
          setIsAdmin(isAdminStatus); // Update state
          localStorage.setItem("isAdmin", isAdminStatus); // Persist in localStorage
        } catch (error) {
          console.error("Error fetching user profile:", error);
          setIsAdmin(false); // Default to non-admin
          localStorage.removeItem("isAdmin");
        }
      } else {
        setIsAdmin(false); // Clear admin status if not authenticated
        localStorage.removeItem("isAdmin");
      }
      setIsLoading(false); // Fetch is complete
    };

    fetchAdminStatus();
  }, [isAuthenticated]);

  const NotAuthorizedHandler = () => {
    alert("Không có quyền truy cập!");
    return <Navigate to="/" replace />;
  };


  return (
    <div className="App">
      <Router>
        <Navbar />
        <Routes>
          {/* Public Routes */}
          <Route path="/" exact element={<Home />} />
          <Route path="/menu" exact element={<Menu />} />
          <Route path="/about" exact element={<About />} />
          <Route path="/contact" exact element={<Contact />} />
          <Route path="/Set_table" exact element={<SetTable />} />
          <Route path="/log_sign_in" exact element={<LogSignIn />} />
          <Route path="/news" exact element={<News />} />
          <Route path="/food/:id" exact element={<FoodDes />} />


          {/* 
          <Route 
            path="/Home_admin" 
            element={isAdmin ? <Home_admin /> : <NotAuthorizedHandler />} 
          />
          <Route path="/Menu_management"
            element={isAdmin ? <Menu_managment /> : <NotAuthorizedHandler/>}
          />
          <Route path="/User_management"
            element={isAdmin ? <User_managment /> : <NotAuthorizedHandler/>}
          /> */}

          <Route path="/Home_admin" exact element={<Home_admin />} />
          <Route path="/Menu_managment" exact element={<Menu_managment />} />
          <Route path="/User_managment" exact element={<User_managment />} />
          <Route path="/Dashboard" exact element={<Dashboard />} />
          {/* <Route path="/Test" element={<UserProfile />} /> */}
          <Route path="/Order_managment" element={<Order_managment />}
          />
          <Route path="/Booking_managment" element={<Booking_managment />}
          />
          <Route path="/Booking_order" element={<Booking_order />}
          />

          <Route path="/Payment" element={<Payment />} />
          <Route path="/Cart" element={<Cart />} />
          <Route path="/LostPassword" exact element={<LostPassword />} />
          <Route path="/NewPassword" exact element={<NewPassword />} />

          {/* Admin-Only Routes */}
          <Route
            path="/Home_admin"
            element={isAdmin ? <Home_admin /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/Dashboard"
            element={isAdmin ? <Dashboard /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/Menu_managment"
            element={isAdmin ? <Menu_managment /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/User_managment"
            element={isAdmin ? <User_managment /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/Order_managment"
            element={isAdmin ? <Order_managment /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/Booking_managment"
            element={isAdmin ? <Booking_managment /> : <NotAuthorizedHandler />}
          />
          <Route
            path="/Booking_order"
            element={isAdmin ? <Booking_order /> : <NotAuthorizedHandler />}
          />

          {/* Catch-All Route for Unknown Paths */}
          <Route path="*" element={<Navigate to="/" />} />
        </Routes>
        <Footer />
      </Router>
    </div>
  );
}

export default App;
