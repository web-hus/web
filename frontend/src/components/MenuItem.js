// import React from "react";

// function MenuItem({ image, name, price }) {
//   return (
//     <div className="menuItem">
//       <div style={{ backgroundImage: `url(${image})` }}> </div>
//       <h1> {name} </h1>
//       <p> {price.toLocaleString()} VND </p>
//     </div>
//   );
// }

// export default MenuItem;

import React from "react";

function MenuItem({ image, name, price, discount }) {
  return (
    <div className="menuItem">
      <div className="menuItemImage" style={{ backgroundImage: `url(${image})` }}>
        {discount && <span className="discount">-{discount}%</span>}
      </div>
      <h1 className="menuItemName">{name}</h1>
      <p className="menuItemPrice">{price.toLocaleString()} VND</p>
      <button className="menuItemButton">Xem chi tiết</button>
    </div>
  );
}

export default MenuItem;
