import "./App.css";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Menu from "./pages/Menu";
import About from "./pages/About";
import Contact from "./pages/Contact";
import SetTable from "./pages/Set_table";
import LogSignIn from "./pages/Log_Sign_In";
import News from "./pages/News"
import { BrowserRouter as Router, Route, Routes} from "react-router-dom";
import React from 'react';
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

function App() {
  return (
    <div className="App">
      <Router>
        <Navbar />
        <Routes>
          <Route path="/" exact element={<Home />} />
          <Route path="/menu" exact element={<Menu />} />
          <Route path="/about" exact element={<About />} />
          <Route path="/contact" exact element={<Contact />} />
          <Route path="/set_table" exact element={<SetTable />} />
          <Route path="/log_sign_in" exact element={<LogSignIn />} />
          <Route path="/news" exact element={<News />} />
        </Routes>
        <Footer />
      </Router>
    </div>
  );
}

export default App;
