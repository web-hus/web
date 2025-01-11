import React from 'react';
import '../styles/CartItem.css';

const CartItem = ({ item, updateQuantity, removeItem }) => {
  return (
    <div className="cart-item">
      <img src={item.image} alt={item.name} />
      <div className="item-details">
        <h4>{item.name}</h4>
        <p>${item.price}</p>
        <div className="quantity">
          <button
            onClick={() =>
              updateQuantity(item.id, Math.max(item.quantity - 1, 1))
            }
          >
            -
          </button>
          <input
            type="number"
            value={item.quantity}
            onChange={(e) =>
              updateQuantity(item.id, parseInt(e.target.value) || 1)
            }
            min="1"
          />
          <button onClick={() => updateQuantity(item.id, item.quantity + 1)}>
            +
          </button>
        </div>
        <button className="remove-btn" onClick={() => removeItem(item.id)}>
          Remove
        </button>
      </div>
    </div>
  );
};

export default CartItem;
