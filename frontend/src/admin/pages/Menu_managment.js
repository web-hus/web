import React, { useState, useEffect } from "react";
import axios from "axios"; // Import axios
import "../styles/Menu_managment.css";
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';

function Menu_managment() {
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
            <h5 className="card-title">Menu Management</h5>
            <table className="mb-0 table table-bordered">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Món ăn</th>
                        <th>
                            {/* <div class="dropdown">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Dropdown button
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another action</a>
                                    <a class="dropdown-item" href="#">Something else here</a>
                                </div>
                            </div> */}

                            {/* <div className="dropdown d-inline-block ms-2"> */}
                            <button
                                className="btn btn-success btn-sm dropdown-toggle"
                                type="button"
                                id="categoryDropdown"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                            >Loại
                            </button>
                            <ul className="dropdown-menu" aria-labelledby="categoryDropdown">
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("All")}
                                    >
                                        All
                                    </button>
                                </li>
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("Khai vị")}
                                    >
                                        Khai vị
                                    </button>
                                </li>
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("Món chính")}
                                    >
                                        Món chính
                                    </button>
                                </li>
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("Món phụ")}
                                    >
                                        Món phụ
                                    </button>
                                </li>
                                <li>
                                    <hr className="dropdown-divider" />
                                </li>
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("Tráng miệng")}
                                    >
                                        Tráng miệng
                                    </button>
                                </li>
                                <li>
                                    <button
                                        className="dropdown-item"
                                        onClick={() => handleFilterChange("Đồ uống")}
                                    >
                                        Đồ uống
                                    </button>
                                </li>
                            </ul>
                        </th>
                        <th>Giá</th>
                        <th>Mô tả</th>
                        <th>Trạng thái</th>
                        <th>Thay đổi</th>
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
                                <EditIcon></EditIcon>
                                <DeleteIcon></DeleteIcon>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default Menu_managment;
