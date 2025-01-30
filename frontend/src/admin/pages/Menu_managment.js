import React, { useState, useEffect } from "react";
import axios from "axios"; // Import axios
import "../styles/Menu_managment.css";
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';
import SaveIcon from '@mui/icons-material/Save';
import CancelIcon from '@mui/icons-material/Cancel';
import axiosInstance from "../../api/api";


function MenuManagement() {
    const [menuItems, setMenuItems] = useState([]); // Store all menu items
    const [filteredItems, setFilteredItems] = useState([]); // Store filtered items
    const [editingRow, setEditingRow] = useState(null); // Store row being edited
    const [editedValues, setEditedValues] = useState({}); // Store edited values

    // Fetch all menu items from the backend
    useEffect(() => {
        const fetchMenuItems = async () => {
            try {
                const response = await axiosInstance.get("/api/dish/dishes");
                setMenuItems(response.data);
                setFilteredItems(response.data); // Show all items by default
            } catch (error) {
                console.error("Error fetching dishes:", error);
            }
        };

        fetchMenuItems();
    }, []);

    // Handle filtering by category
    const handleFilterChange = (category) => {
        if (category === "All") {
            setFilteredItems(menuItems);
        } else {
            const filtered = menuItems.filter((item) => item.product_category === category);
            setFilteredItems(filtered);
        }
    };

    // Handle delete action
    const handleDelete = async (dishId) => {
        try {
            const token = localStorage.getItem("authToken");
            await axiosInstance.delete(`/api/admin/dishes/${dishId}`, {
                headers: { Authorization: `Bearer ${token}` },
            });
            setMenuItems((prev) => prev.filter((item) => item.dish_id !== dishId));
            setFilteredItems((prev) => prev.filter((item) => item.dish_id !== dishId));
        } catch (error) {
            console.error("Error deleting dish:", error);
        }
    };

    // Handle edit action
    const handleEdit = (dishId) => {
        setEditingRow(dishId);
        const dish = menuItems.find((item) => item.dish_id === dishId);
        setEditedValues(dish); // Pre-fill with current values
    };

    // Handle save action
    const handleSave = async () => {
        try {
            const token = localStorage.getItem("authToken");
            await axiosInstance.put(`/api/admin/dishes/${editedValues.dish_id}`, editedValues, {
                headers: { Authorization: `Bearer ${token}` },
            });
            setMenuItems((prev) =>
                prev.map((item) =>
                    item.dish_id === editedValues.dish_id ? { ...item, ...editedValues } : item
                )
            );
            setFilteredItems((prev) =>
                prev.map((item) =>
                    item.dish_id === editedValues.dish_id ? { ...item, ...editedValues } : item
                )
            );
            setEditingRow(null);
        } catch (error) {
            console.error("Error updating dish:", error);
        }
    };

    // Handle cancel action
    const handleCancel = () => {
        setEditingRow(null);
        setEditedValues({});
    };

    // Handle input change during editing
    const handleInputChange = (field, value) => {
        setEditedValues((prev) => ({ ...prev, [field]: value }));
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
                            <button
                                className="btn btn-success btn-sm dropdown-toggle"
                                type="button"
                                id="categoryDropdown"
                                data-bs-toggle="dropdown"
                                aria-expanded="false"
                            >
                                Loại
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
                            {editingRow === item.dish_id ? (
                                <>
                                    <td>
                                        <input
                                            type="text"
                                            value={editedValues.dish_name || ""}
                                            onChange={(e) =>
                                                handleInputChange("dish_name", e.target.value)
                                            }
                                        />
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            value={editedValues.product_category || ""}
                                            onChange={(e) =>
                                                handleInputChange("product_category", e.target.value)
                                            }
                                        />
                                    </td>
                                    <td>
                                        <input
                                            type="number"
                                            value={editedValues.price || ""}
                                            onChange={(e) => handleInputChange("price", e.target.value)}
                                        />
                                    </td>
                                    <td>
                                        <input
                                            type="text"
                                            value={editedValues.description || ""}
                                            onChange={(e) =>
                                                handleInputChange("description", e.target.value)
                                            }
                                        />
                                    </td>
                                    <td>
                                        <select
                                            value={editedValues.availability ? "Còn hàng" : "Hết hàng"}
                                            onChange={(e) =>
                                                handleInputChange(
                                                    "availability",
                                                    e.target.value === "Còn hàng"
                                                )
                                            }
                                        >
                                            <option value="Còn hàng">Còn hàng</option>
                                            <option value="Hết hàng">Hết hàng</option>
                                        </select>
                                    </td>
                                    <td>
                                        <SaveIcon
                                            onClick={handleSave}
                                            style={{ cursor: "pointer", marginRight: "8px" }}
                                        />
                                        <CancelIcon
                                            onClick={handleCancel}
                                            style={{ cursor: "pointer" }}
                                        />
                                    </td>
                                </>
                            ) : (
                                <>
                                    <td>{item.dish_name}</td>
                                    <td>{item.product_category}</td>
                                    <td>{item.price}</td>
                                    <td>{item.description}</td>
                                    <td>{item.availability ? "Còn hàng" : "Hết hàng"}</td>
                                    <td>
                                        <EditIcon
                                            onClick={() => handleEdit(item.dish_id)}
                                            style={{ cursor: "pointer", marginRight: "8px" }}
                                        />
                                        <DeleteIcon
                                            onClick={() => handleDelete(item.dish_id)}
                                            style={{ cursor: "pointer" }}
                                        />
                                    </td>
                                </>
                            )}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
}

export default MenuManagement;
