import React, { useState, useEffect } from "react";
import axios from "axios";
import "../styles/User_managment.css";

function Booking_order() {
    const [menuItems, setMenuItems] = useState([]); // Lưu danh sách tất cả người dùng
    const [filteredItems, setFilteredItems] = useState([]); // Lưu danh sách người dùng đã lọc
    const [searchTerm, setSearchTerm] = useState(""); // Lưu từ khóa tìm kiếm

    // Fetch tất cả người dùng từ backend
    useEffect(() => {
        const fetchMenuItems = async () => {
            try {
                const response = await axios.get("/users"); // Gọi API lấy danh sách người dùng
                setMenuItems(response.data);
                setFilteredItems(response.data); // Mặc định hiển thị tất cả người dùng
            } catch (error) {
                console.error("Error fetching users:", error);
            }
        };

        fetchMenuItems();
    }, []);

    // Hàm xử lý tìm kiếm
    const handleSearch = (e) => {
        const value = e.target.value.toLowerCase();
        setSearchTerm(value);

        // Lọc danh sách theo từ khóa
        const filtered = menuItems.filter(
            (item) =>
                item.user_name.toLowerCase().includes(value) ||
                item.address.toLowerCase().includes(value) ||
                item.email.toLowerCase().includes(value) ||
                item.phone.includes(value)
        );
        setFilteredItems(filtered);
    };

    return (
        <div>
            {/* Thanh tìm kiếm */}
            <nav className="navbar bg-body-tertiary">
                <div className="container-fluid">
                    <form className="d-flex" role="search">
                        <input
                            className="form-control me-2"
                            type="search"
                            placeholder="Tìm kiếm theo tên, địa chỉ, email hoặc số điện thoại"
                            aria-label="Search"
                            value={searchTerm}
                            onChange={handleSearch} // Gọi hàm xử lý tìm kiếm
                            style={{width: "500px", height: "40px"}}
                        />
                        {/* <button
                            className="btn btn-outline-success"
                            type="button"
                            onClick={() => console.log("Search triggered!")}
                            style={{ height: "40px" }} // Đồng bộ chiều cao
                        >
                            Search
                        </button> */}
                    </form>
                </div>
            </nav>

            {/* Bảng hiển thị danh sách người dùng */}
            <div className="card-body">
                <h5 className="card-title">Quản lý người dùng</h5>
                <table className="mb-0 table table-bordered">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên người dùng</th>
                            <th>Địa chỉ</th>
                            <th>Email</th>
                            <th>Số ĐT</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredItems.map((item, index) => (
                            <tr key={item.user_id}>
                                <th scope="row">{index + 1}</th>
                                <td>{item.user_name}</td>
                                <td>{item.address}</td>
                                <td>{item.email}</td>
                                <td>{item.phone}</td>
                            </tr>
                        ))}
                        {filteredItems.length === 0 && (
                            <tr>
                                <td colSpan="5" style={{ textAlign: "center" }}>
                                    Không tìm thấy kết quả phù hợp
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}

export default Booking_order;
