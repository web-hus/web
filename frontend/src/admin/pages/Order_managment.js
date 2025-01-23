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
                const token = localStorage.getItem("authToken"); // Retrieve the token
                const response = await axios.get("/api/admin/orders", {
                    headers: {
                        Authorization: `Bearer ${token}`, // Pass the token
                    },
                });
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
                        <th>ID Khách Hàng</th>
                        {/* <th>Số ĐT</th> */}
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
                            <td>{item.user_id}</td>
                            {/* <td>{item.product_category}</td> */}
                            <td>{item.order_date}</td>
                            <td>{item.delivery_address}</td>
                            <td>{item.status}</td>
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
