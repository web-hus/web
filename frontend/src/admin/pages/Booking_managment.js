import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Booking_managment.css";
import EditNoteIcon from '@mui/icons-material/EditNote';

function Booking_managment() {
    const [menuItems, setMenuItems] = useState([]); // Lưu danh sách tất cả các món ăn
    const [filteredItems, setFilteredItems] = useState([]); // Lưu danh sách món ăn đã lọc

    // Fetch tất cả các món ăn từ backend
    useEffect(() => {
        const fetchMenuItems = async () => {
            try {
                const response = await axios.get("/api/dish/dishes"); // Gọi API lấy tất cả món ăn
                setMenuItems(response.data);
                setFilteredItems(response.data); // Mặc định hiển thị tất cả món ăn
            } catch (error) {
                console.error("Error fetching dishes:", error);
            }
        };

        fetchMenuItems();
    }, []);

    return (
        <div className="card-body">
            <h5 className="card-title">Booking Management</h5>
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
                    {filteredItems.map((item, index) => (
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
                            <EditNoteIcon></EditNoteIcon>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default Booking_managment;
