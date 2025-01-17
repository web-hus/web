import React, { useState } from "react";
import "../styles/main.css";
import bannerVideo from "../../assets/vietnamese_food.mp4";
import { Link } from "react-router-dom";

function Home_admin() {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true); // Trạng thái ban đầu của sidebar

  // Hàm toggle sidebar
  const toggleSidebar = () => {
    setIsSidebarOpen(!isSidebarOpen);
  };

  return (
    <div className="app-main">
      <div className={`app-sidebar sidebar-shadow ${isSidebarOpen ? '' : 'closed'}`}>
        <div className="app-header__logo">
          <div className="logo-src"></div>
          <div className="header__pane ml-auto">
            <div>
              <button
                type="button"
                className="hamburger close-sidebar-btn hamburger--elastic"
                onClick={toggleSidebar}
              >
                <span className="hamburger-box">
                  <span className="hamburger-inner"></span>
                </span>
              </button>
            </div>
          </div>
        </div>
        <div className="app-header__mobile-menu">
          <div>
            <button type="button" className="hamburger hamburger--elastic mobile-toggle-nav">
              <span className="hamburger-box">
                <span className="hamburger-inner"></span>
              </span>
            </button>
          </div>
        </div>
        <div className="app-header__menu">
          <span>
            <button type="button" className="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
              <span className="btn-icon-wrapper">
                <i className="fa fa-ellipsis-v fa-w-6"></i>
              </span>
            </button>
          </span>
        </div>
        <div className="scrollbar-sidebar">
          <div className="app-sidebar__inner">
            <ul className="vertical-nav-menu">
              <li className="app-sidebar__heading">Dashboards</li>
              <li>
                <a href="/Dashboard" target="_blank" rel="noopener noreferrer">
                  <i className="metismenu-icon pe-7s-rocket"></i>
                  Dashboard 3 miền
                </a>
              </li>
              <li className="app-sidebar__heading">Quản lý nhà hàng</li>
              <li>
                <a>
                  <i className="metismenu-icon pe-7s-diamond"></i>
                  Quản lý món ăn
                  <i className="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                  <li>
                    <a href="/Menu_managment" target="_blank" rel="noopener noreferrer">
                      <i className="metismenu-icon"></i>
                      Thực đơn
                    </a>
                  </li>
                </ul>
              </li>
              <li>
                <a>
                  <i className="metismenu-icon pe-7s-car"></i>
                  Quản lý đơn hàng
                  <i className="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                  <li>
                    <a href="/Booking_managment" target="_blank" rel="noopener noreferrer">
                      <i className="metismenu-icon"></i>Danh sách đặt bàn
                    </a>
                  </li>
                  <li>
                    <a href="/Order_managment" target="_blank" rel="noopener noreferrer">
                      <i className="metismenu-icon"></i>Danh sách đặt hàng
                    </a>
                  </li>
                </ul>
              </li>
              <li>
                <a>
                  <i className="metismenu-icon pe-7s-display2"></i>
                  Quản lý user
                  <i className="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                  <li>
                    <a href="/User_managment" target="_blank" rel="noopener noreferrer">
                      <i className="metismenu-icon"></i>
                      Danh sách khách hàng
                    </a>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div className="home">
        <video className="background-video" autoPlay loop muted>
          <source src={bannerVideo} type="video/mp4" />
        </video>
        <div className="headerContainer">
          <h1>3 Miền's Home</h1>
          <p>Trang quản lý chính thức nhà hàng 3 Miền </p>
        </div>
      </div>
    </div>
  );
}

export default Home_admin;
