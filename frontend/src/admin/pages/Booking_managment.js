import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Booking_managment.css";

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

    // Hàm xử lý khi chọn loại món ăn
    const handleFilterChange = (category) => {
        if (category === "All") {
            // Nếu chọn "All", hiển thị tất cả món ăn
            setFilteredItems(menuItems);
        } else {
            // Lọc món ăn theo loại được chọn
            const filtered = menuItems.filter((item) => item.product_category === category);
            setFilteredItems(filtered);
        }
    };

    return (
        <div className="card-body">
            <h5 className="card-title">Booking Management</h5>
            <table className="mb-0 table table-bordered">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên Khách Hàng</th>
                        <th>Số ĐT</th>
                        <th>Date</th>
                        <th>Time</th>
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
                            <div className="menuItemButton">Xem thêm</div>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default Booking_managment;
