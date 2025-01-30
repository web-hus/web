import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Booking_managment.css";
import EditNoteIcon from '@mui/icons-material/EditNote';
import AddShoppingCartIcon from '@mui/icons-material/AddShoppingCart';
import Modal from 'react-modal';

Modal.setAppElement("#root");

function BookingManagement() {
    const [bookings, setBookings] = useState([]);
    const [menuItems, setMenuItems] = useState([]);
    const [cart, setCart] = useState([]);
    const [selectedBooking, setSelectedBooking] = useState(null);
    const [modalIsOpen, setModalIsOpen] = useState(false);
    const [activeTab, setActiveTab] = useState("menu");

    useEffect(() => {
        const fetchBookings = async () => {
            try {
                const response = await axios.get("/api/admin/bookings");
                setBookings(response.data);
            } catch (error) {
                console.error("Error fetching bookings:", error);
            }
        };

        fetchBookings();
    }, []);

    useEffect(() => {
        const fetchMenuItems = async () => {
            try {
                const response = await axios.get("/api/dish/dishes");
                setMenuItems(response.data);
            } catch (error) {
                console.error("Error fetching dishes:", error);
            }
        };

        fetchMenuItems();
    }, []);

    const openModal = (booking) => {
        setSelectedBooking(booking);
        setModalIsOpen(true);
    };

    const closeModal = () => {
        setSelectedBooking(null);
        setModalIsOpen(false);
    };

    const addToCart = (dish) => {
        setCart((prevCart) => {
            const existingItem = prevCart.find((item) => item.dish_id === dish.dish_id);
            if (existingItem) {
                return prevCart.map((item) =>
                    item.dish_id === dish.dish_id ? { ...item, quantity: item.quantity + 1 } : item
                );
            } else {
                return [...prevCart, { ...dish, quantity: 1 }];
            }
        });
    };

    const updateQuantity = (dish_id, amount) => {
        setCart((prevCart) =>
            prevCart.map((item) =>
                item.dish_id === dish_id
                    ? { ...item, quantity: Math.max(0, item.quantity + amount) }
                    : item
            ).filter(item => item.quantity > 0)  // Xóa món có quantity = 0
        );

        // Cập nhật số lượng món ăn trong menu nếu cần
        setMenuItems((prevMenuItems) =>
            prevMenuItems.map((item) =>
                item.dish_id === dish_id
                    ? { ...item, quantity: Math.max(0, (item.quantity || 0) + amount) }
                    : item
            )
        );
    };

    const calculateTotal = () => {
        return cart.reduce((total, item) => total + item.price * item.quantity, 0);
    };

    const handlePayment = () => {
        alert("Xác nhận thanh toán thành công");
        setCart([]);
        closeModal();
    };

    return (
        <div className="card-body">
            <h5 className="card-title">Quản lý đặt bàn</h5>
            <table className="mb-0 table table-bordered">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên khách hàng</th>
                        <th>Số ĐT</th>
                        <th>Ngày</th>
                        <th>Thời gian</th>
                        <th>Số lượng người</th>
                        <th>Yêu cầu đặc biệt</th>
                        <th>Trạng thái</th>
                        <th>Gọi món</th>
                    </tr>
                </thead>
                <tbody>
                    {menuItems.map((item, index) => (
                        <tr key={item.dish_id}>
                            <th scope="row">{index + 1}</th>
                            <td>{item.dish_name}</td>
                            <td>{item.product_category}</td>
                            <td>{item.price}</td>
                            <td>{item.price}</td>
                            <td>{item.price}</td>
                            <td>{item.description}</td>
                            <td>{item.availability ? "Còn hàng" : "Hết hàng"}</td>
                            <td>
                                <EditNoteIcon onClick={() => openModal(item)}></EditNoteIcon>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            {selectedBooking && (
                <Modal isOpen={modalIsOpen} onRequestClose={closeModal} className="modal-content" overlayClassName="modal-overlay">
                    <div className="tab-header">
                        <button className={activeTab === "menu" ? "active" : ""} onClick={() => setActiveTab("menu")}>Menu</button>
                        <button className={activeTab === "cart" ? "active" : ""} onClick={() => setActiveTab("cart")}>Giỏ hàng</button>
                    </div>

                    {activeTab === "menu" ? (
                        <div>
                            <h2>Danh sách món ăn</h2>
                            <div className="menu-header">
                                <span className="menu-title">Món ăn</span>
                                <span className="menu-price">Giá</span>
                                <span className="menu-add">Thêm vào giỏ</span>
                            </div>
                            <ul>
                                {menuItems.map((dish) => {
                                    const fileExtension = dish.dish_name.toLowerCase().includes("png") ? "png" : "jpg";
                                    const encodedIDName = encodeURIComponent(dish.dish_id);
                                    return (
                                        <li key={dish.dish_id} className="menu-item">
                                            <img
                                                src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                                                onError={(e) => { e.target.src = "/images/default.jpg"; }}
                                                alt={dish.dish_name}
                                                className="dish-img"
                                            />
                                            <div className="dish-details">
                                                <span className="dish-name">{dish.dish_name}</span>
                                                <span className="dish-price">{dish.price} VND</span>
                                            </div>
                                            <AddShoppingCartIcon onClick={() => addToCart(dish)}></AddShoppingCartIcon>
                                        </li>
                                    );
                                })}
                            </ul>
                        </div>
                    ) : (
                        <div>
                            <h2>Giỏ hàng</h2>
                            <div className="menu-header-cart">
                                <span className="menu-title-cart">Món ăn</span>
                                <span className="menu-price-cart">Giá</span>
                                <span className="menu-quantity">Số lượng</span>
                                <span className="menu-total">Tổng 1 món</span>
                            </div>
                            <ul>
                                {cart.map((item) => {
                                    const fileExtension = item.dish_name.toLowerCase().includes("png") ? "png" : "jpg";
                                    const encodedIDName = encodeURIComponent(item.dish_id);
                                    return (
                                        <li key={item.dish_id} className="cart-item">
                                            <img
                                                src={`/images/food_img/${encodedIDName}.${fileExtension}`}
                                                onError={(e) => { e.target.src = "/images/default.jpg"; }}
                                                alt={item.dish_name}
                                                className="dish-img"
                                            />
                                            <div className="dish-details-cart">
                                                <span className="dish-name-cart">{item.dish_name}</span>
                                                <span className="dish-price-cart">{item.price} VND</span>
                                            </div>
                                            <div className="cart-item-controls">
                                                <button onClick={() => updateQuantity(item.dish_id, -1)}>-</button>
                                                <span>{item.quantity}</span>
                                                <button onClick={() => updateQuantity(item.dish_id, 1)}>+</button>
                                            </div>
                                            <span className="dish-total">{item.price * item.quantity} VND</span>
                                        </li>
                                    );
                                })}
                            </ul>

                            <h3>Tổng hóa đơn: {calculateTotal()} VND</h3>
                            <button className="btn btn-success" onClick={handlePayment}>Thanh toán</button>
                        </div>
                    )}
                    <button className="btn btn-danger" onClick={closeModal}>Đóng</button>
                </Modal>
            )}
        </div>
    );
}

export default BookingManagement;

