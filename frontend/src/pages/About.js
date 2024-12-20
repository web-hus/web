import React from "react";
import Res1 from "../assets/banner_sample/1.png";
import Res2 from "../assets/banner_sample/2.png";
import Res3 from "../assets/banner_sample/3.png";
import Res4 from "../assets/banner_sample/4.png";
import Res5 from "../assets/banner_sample/5.png";
import "../styles/About.css";

function About() {
  return (
    <div className="about">
      <div
        id="carouselExampleAutoplaying"
        className="carousel slide"
        data-bs-ride="carousel"
        data-bs-interval="3000"
      >
        <div className="carousel-inner">
          <div className="carousel-item active">
            <img src={Res1} className="d-block w-100" alt="Pizza 1" />
          </div>
          <div className="carousel-item">
            <img src={Res2} className="d-block w-100" alt="Pizza 2" />
          </div>
          <div className="carousel-item">
            <img src={Res3} className="d-block w-100" alt="Pizza 3" />
          </div>
          <div className="carousel-item">
            <img src={Res4} className="d-block w-100" alt="Pizza 3" />
          </div>
          <div className="carousel-item">
            <img src={Res5} className="d-block w-100" alt="Pizza 3" />
          </div>
        </div>
        <button
          className="carousel-control-prev"
          type="button"
          data-bs-target="#carouselExampleAutoplaying"
          data-bs-slide="prev"
        >
          <span className="carousel-control-prev-icon" aria-hidden="true"></span>
          <span className="visually-hidden">Previous</span>
        </button>
        <button
          className="carousel-control-next"
          type="button"
          data-bs-target="#carouselExampleAutoplaying"
          data-bs-slide="next"
        >
          <span className="carousel-control-next-icon" aria-hidden="true"></span>
          <span className="visually-hidden">Next</span>
        </button>
      </div>

      <div className="aboutBottom">
        <h1>ABOUT US</h1>
        <p>
          <strong>Welcome to Pizza Phe La - Hanoi's Freshest Slice of Italy!</strong>
        </p>
        <p>
          Lịch sử: Nhà hàng của chúng tôi ra đời từ tình yêu sâu sắc với ẩm thực Việt Nam, được ấp ủ sau hành trình xuyên Việt của những người sáng lập – say mê khám phá và có cơ hội được thưởng thức những tinh hoa từ khắp ba miền đất nước. Hành trình đó không chỉ là thưởng thức cảnh đẹp sắc nước hương trời mà còn thấu hiểu nét độc đáo của từng món ăn, từ hương vị thanh tao của miền Bắc, nét mộc mạc dân dã của miền Trung, đến sự đậm đà say mê của ẩm thực miền Nam.
        </p>

        <p>
          Mang đến cho thực khách một trải nghiệm ẩm thực chân thực và sâu sắc nhất, gần gũi như chính quê hương của từng món ăn là triết lý của chúng tôi. Vì vậy, chúng tôi cam kết giữ gìn hương vị nguyên bản của từng món qua bàn tay tài hoa của đội ngũ đầu bếp – những người đã lớn lên, hiểu rõ phong vị và tự hào về những món ăn quê nhà của họ.
        </p>

        <p>
          Sứ mệnh của chúng tôi là kết nối thực khách với hành trình hương vị của ba miền Việt Nam, nơi mỗi món ăn là một câu chuyện và mỗi hương vị là một trải nghiệm khó quên. Nhà hàng chúng tôi cam kết về nguyên liệu chọn lọc và phong cách chế biến riêng biệt của từng món ăn: không chỉ là bữa ăn, mà là một chuyến du ngoạn qua từng miền đất nước, ngay trên bàn ăn.
        </p>

        <p>
          Chúng tôi hân hạnh được đồng hành cùng quý thực khách trên hành trình ẩm thực đầy tinh tế nhưng cũng rất nguyên bản, và mong muốn mang đến cho quý vị những khoảnh khắc tuyệt vời nhất khi khám phá ẩm thực Việt Nam.
        </p>
      </div>
    </div>
  );
}

export default About;
