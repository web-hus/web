import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/Order_managment.css";
import ChecklistIcon from '@mui/icons-material/Checklist';

function OrderManagement() {
    const [orders, setOrders] = useState([]); // Store list of orders

    // Fetch all orders from the backend
    useEffect(() => {
        const fetchOrders = async () => {
            try {
                const token = localStorage.getItem("authToken"); // Retrieve the token
                const response = await axios.get("/api/admin/orders", {
                    headers: {
                        Authorization: `Bearer ${token}`, // Pass the token
                    },
                });
                setOrders(response.data); // Save orders
            } catch (error) {
                console.error("Error fetching orders:", error);
            }
        };

        fetchOrders();
    }, []);

    // Helper to format order type
    const getOrderType = (type) => (type === 0 ? "Đến quán ăn" : "Đơn mang về");

    // Helper to format order status
    const getOrderStatus = (status) => {
        switch (status) {
            case 0:
                return "Chờ xử lý";
            case 1:
                return "Đã xác nhận";
            case 2:
                return "Đang giao";
            case 3:
                return "Hoàn thành";
            case 4:
                return "Hủy";
            default:
                return "Không xác định";
        }
    };

    return (
        <div className="card-body">
            <h5 className="card-title">Order Management</h5>
            <table className="mb-0 table table-bordered">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>ID Đơn Hàng</th>
                        <th>ID Khách Hàng</th>
                        <th>Loại Đơn Hàng</th>
                        <th>Ngày Tạo</th>
                        <th>Địa Chỉ Giao Hàng</th>
                        <th>Trạng Thái</th>
                        <th>Danh Sách Món</th>
                    </tr>
                </thead>
                <tbody>
                    {orders.map((order, index) => (
                        <tr key={order.order_id}>
                            <td>{index + 1}</td>
                            <td>{order.order_id}</td>
                            <td>{order.user_id}</td>
                            <td>{getOrderType(order.order_type)}</td>
                            <td>{new Date(order.created_at).toLocaleDateString()}</td>
                            <td>{order.delivery_address || "Không áp dụng"}</td>
                            <td>{getOrderStatus(order.status)}</td>
                            <td>
                                <ChecklistIcon
                                    // onClick={() =>
                                    //     alert(`Danh sách món:\n${order.dishes
                                    //         .map(
                                    //             (dish) =>
                                    //                 `Món: ${dish.dish_id}, Số lượng: ${dish.quantity}`
                                    //         )
                                    //         .join("\n")}`)
                                    // }
                                    // style={{ cursor: "pointer" }}
                                />
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default OrderManagement;
