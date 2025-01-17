import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Order_managment.css";
import ChecklistIcon from '@mui/icons-material/Checklist';

function Order_managment() {
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
            <h5 className="card-title">Order Management</h5>
            <table className="mb-0 table table-bordered">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên Khách Hàng</th>
                        <th>Số ĐT</th>
                        <th>Ngày đặt hàng</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Trạng thái</th>
                        <th>Danh sách món</th>
                    </tr>
                </thead>
                <tbody>
                    {filteredItems.map((item, index) => (
                        <tr key={item.dish_id}>
                            <th scope="row">{index + 1}</th>
                            <td>{item.dish_name}</td>
                            <td>{item.product_category}</td>
                            <td>{item.price}</td>
                            <td>{item.description}</td>
                            <td>{item.availability ? "Còn hàng" : "Hết hàng"}</td>
                            <td>
                            <ChecklistIcon></ChecklistIcon>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}


export default Order_managment;
