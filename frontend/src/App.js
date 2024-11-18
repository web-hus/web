import './App.css';
import React from 'react'
import Login from './components/login';
import {useEffet, useState} from 'react'
import {BrowserRouter, Route, Routes} from 'react-router-dom'


function App() {
  const [loggedIn, setLoggedIn] = useState(false)
  const [email, setEmail] = useState('')

  return (
    <>
      <div className='App-header'>
        header
      </div>

      <div className='nav-bar'>
        Trang chủ > Đăng nhập
      </div>
  
      <div className="Login">
        <Login/>
      </div>
    </>
    
  )
}
document.body.style.backgroundColor = '#143B36'
export default App;
