import React from 'react';

const CartSummary = ({ cartItems }) => {
  const calculateTotal = () => {
    return cartItems.reduce(
      (total, item) => total + item.price * item.quantity,
      0
    );
  };

  const totalAmount = calculateTotal();

  return (
    <div className="cart-summary">
      <h3>Order Summary</h3>
      <div className="summary">
        <div className="summary-item">
          <span>Subtotal</span>
          <span>${totalAmount.toFixed(2)}</span>
        </div>
        <div className="summary-item">
          <span>Shipping</span>
          <span>Free</span>
        </div>
        <div className="summary-item">
          <span>Total</span>
          <span>${totalAmount.toFixed(2)}</span>
        </div>
      </div>
      <button className="checkout-btn">Proceed to Checkout</button>
    </div>
  );
};

export default CartSummary;
