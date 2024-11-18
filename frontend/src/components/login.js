import React, { useState} from 'react'
import './login.css'
import {Tab, Tabs, TabList, TabPanel} from 'react-tabs'

const Login = () =>{
    const [loginEmail, setLoginEmail] = useState('')
    const [loginPassword, setLoginPassword] = useState('')
    const [signupPassword, setSignupPassword] = useState('')
    const [signupEmail, setSignupEmail] = useState('')
    const [lastname, setLastName] = useState('')
    const [firstname, setFirstName] = useState('')
    const [phonenum, setPhoneNum] = useState('')
    



    return(
        <div className={'mainContainer'}>
            <div className={'functionalContainer'}>
                <Tabs> 
                    <TabList>
                        <Tab>ĐĂNG NHẬP</Tab>
                        <Tab>ĐĂNG KÝ</Tab>
                    </TabList>

                    <TabPanel>
                        <div className={'titleContainer'}>
                            ĐĂNG NHẬP
                        </div>
                        
                        <div className={'inputContainer'}>
                            <input
                                value={loginEmail}
                                placeholder="Email"
                                onChange={(ev) => setLoginEmail(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>

                        <br/>

                        <div className={'inputContainer'}>
                            <input
                                value={loginPassword}
                                placeholder="Mật khẩu"
                                onChange={(ev) => setLoginPassword(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>

                        <br/>

                        <div className={'inputContainer'}>
                            <input className={'inputButton'} type='button' value={'ĐĂNG NHẬP'}/> 
                        </div>
                        <br/>
                        <div>
                            <a className='text' href="">Quên mật khẩu?</a>
                            <div className='text'>Hoặc đăng nhập bằng</div>
                            <br/>
                            <div className='text'>
                                <button className='facebook'>Facebook</button>
                                <button className='google'>Google</button>
                            </div>
                                
                        </div>
                        <br/>
                    </TabPanel>
                    <TabPanel>
                        <div className={'titleContainer'}>
                        ĐĂNG KÝ
                        </div>

                        <div className={'inputContainer'}>
                            <input
                                value={lastname}
                                placeholder="Họ"
                                onChange={(ev) => setLastName(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>

                        <div className={'inputContainer'}>
                            <input
                                value={firstname}
                                placeholder="Tên"
                                onChange={(ev) => setFirstName(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>


                        <div className={'inputContainer'}>
                            <input
                                value={signupEmail}
                                placeholder="Email"
                                onChange={(ev) => setSignupEmail(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>
                    
                        <div className={'inputContainer'}>
                        <input
                            value={phonenum}
                            placeholder="Số điện thoại"
                            onChange={(ev) => setPhoneNum(ev.target.value)}
                            className={'inputBox'}
                        />
                        </div>


                        <div className={'inputContainer'}>
                            <input
                                value={signupPassword}
                                placeholder="Đặt mật khẩu"
                                onChange={(ev) => setSignupPassword(ev.target.value)}
                                className={'inputBox'}
                            />
                        </div>

                        <br/>

                        <div className={'inputContainer'}>
                            <input className={'inputButton'} type='button' value={'ĐĂNG KÝ'}/> 
                        </div>
                    </TabPanel>
                </Tabs>
                <br/>
            </div>
            
        </div>
            
    )
}

export default Login

