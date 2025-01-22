// verify_registration.js

import React, { useEffect, useState } from "react";
import "../styles/Log_Sign_In.css"; // Use the same CSS for consistent styling
import axios from "axios";

function VerifyRegistration() {
    const [message, setMessage] = useState(""); // Success message
    const [error, setError] = useState(""); // Error message

    // Utility function to get URL parameters
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

    useEffect(() => {
        async function verifyRegistration() {
            const token = getQueryParam("token");
            console.log("token is", token)

            if (!token) {
                setError("Verification token is missing!");
                return;
            }

            try {
                const response = await axios.post("http://localhost:8000/registration/verify", {
                    token: token,
                });

                setMessage(response.data.message);
                // Optionally redirect the user after successful verification
                setTimeout(() => {
                    window.location.href = "/log_sign_in";
                }, 3000);
            } catch (err) {
                if (err.response) {
                    // Server-side error
                    setError(`Error: ${err.response.data.detail}`);
                } else {
                    // Network or other error
                    setError("An error occurred during verification. Please try again.");
                }
            }
        }

        verifyRegistration();
    }, []);

    return (
        <div className="log-sign-in-container">
            <div className="form-container">
                <h2>Xác nhận đăng ký</h2>
                {message && <div className="success-message">{message}</div>}
                {error && <div className="error-message">{error}</div>}
                {!message && !error && <p>Đang xử lý xác nhận đăng ký...</p>}
            </div>
        </div>
    );
}

export default VerifyRegistration;
