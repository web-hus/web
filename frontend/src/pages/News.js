import React from "react";
import Res1 from "../assets/banner_sample/1.png";
import Res2 from "../assets/banner_sample/2.png";
import Res3 from "../assets/banner_sample/3.png";
import Res4 from "../assets/banner_sample/4.png";
import Res5 from "../assets/banner_sample/5.png";
import News1 from "../assets/News_img/tiet_canh.jpg";
import News2 from "../assets/News_img/nom_bo.jpg";
import News3 from "../assets/News_img/pho_bo.jpg";
import News4 from "../assets/News_img/dam_gio.jpg";
import News5 from "../assets/News_img/chao_suon.jpg";
import News6 from "../assets/News_img/canh_chua.jpg";
import "../styles/News.css";

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
                    {[Res1, Res2, Res3, Res4, Res5].map((img, index) => (
                        <div
                            key={index}
                            className={`carousel-item ${index === 0 ? "active" : ""}`}
                        >
                            <img src={img} className="d-block w-100" alt={`Slide ${index + 1}`} />
                        </div>
                    ))}
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

            <h1 className="news-title">Tin tức Ẩm Thực 3 Miền</h1>

            {/* News Section */}
            <div className="container mt-5 news-section">
                <div className="row">
                    {[
                        {
                            img: News1,
                            title: "Tiết canh vào danh sách 100 món tệ nhất thế giới 2025",
                            text: "Tiết canh của Việt Nam xếp thứ 52 trong top 100 món ăn tệ nhất và bị đánh giá 2,7 sao, bánh bao blodpalt chế biến từ máu tuần lộc tại Phần Lan đứng vị trí ...",
                            link: "https://vnexpress.net/tiet-canh-vao-danh-sach-100-mon-te-nhat-the-gioi-2025-4838487.html",
                        },
                        {
                            img: News2,
                            title: "Các món Việt vào bảng xếp hạng ẩm thực thế giới 2024",
                            text: "Bên cạnh phở và bánh mì nổi tiếng, rau muống xào, canh chua cá, gà luộc, chè ba màu cũng được gọi tên trong top món ngon thế giới 2024, thêm gợi ý ...",
                            link: "https://vnexpress.net/cac-mon-viet-vao-bang-xep-hang-am-thuc-the-gioi-2024-4838000.html",
                        },
                        {
                            img: News3,
                            title: "Phở bò là món Việt duy nhất vào top 100 thế giới 2025",
                            text: "Phở bò xếp thứ 93 trong danh sách 100 món ngon nhất thế giới do Taste Atlas, website được ví như cẩm nang ẩm thực quốc tế, bình chọn.",
                            link: "https://vnexpress.net/pho-bo-la-mon-viet-duy-nhat-vao-top-100-the-gioi-2025-4837233.html",
                        },
                        {
                            img: News4,
                            title: "10 món miền Tây phổ biến trong đám giỗ",
                            text: "Mâm cơm đãi khách dịp đám giỗ của người miền Tây thường bày biện nhiều món, thể hiện sự phong phú ẩm thực và hiếu khách ở vùng sông nước.",
                            link: "https://vnexpress.net/10-mon-mien-tay-pho-bien-trong-dam-gio-4824448.html",
                        },
                        {
                            img: News5,
                            title: "Những món hút khách khi Hà Nội se lạnh",
                            text: "Hà Nội có nhiều món ăn thường xuất hiện khi chuyển mùa, chỉ cần trời hơi lạnh nhiều người đã lên kế hoạch rủ nhau đi ăn. Đó hầu hết là các món ăn vặt ...",
                            link: "https://vnexpress.net/nhung-mon-hut-khach-khi-ha-noi-se-lanh-4809188.html",
                        },
                        {
                            img: News6,
                            title: "Canh chua cá Việt Nam vào top ngon nhất thế giới",
                            text: "Canh chua cá, lẩu cá linh bông điên điển là những món ăn từ cá nổi tiếng tại Việt Nam được thực khách quốc tế chấm điểm cao, theo Taste Atlas.",
                            link: "https://vnexpress.net/canh-chua-ca-viet-nam-vao-top-ngon-nhat-the-gioi-4770103.html",
                        }
                    ].map((news, index) => (
                        <div className="col-lg-4 col-md-6 col-sm-12 mb-4" key={index}>
                            <div className="card h-10">
                                <img src={news.img} className="card-img-top" alt={news.title} />
                                <div className="card-body text-start">
                                    <h5 className="card-title">{news.title}</h5>
                                    <p className="card-text">{news.text}</p>
                                    <a href={news.link} className="btn btn-primary" target="_blank" rel="noopener noreferrer">
                                        Xem thêm
                                    </a>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
            <div className="news-marquee">
                <div className="marquee-wrapper">
                    <p className="marquee-text">
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                    </p>
                    <p className="marquee-text">
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                    </p>
                    <p className="marquee-text">
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                    </p>
                </div>
            </div>

        </div>
    );
}

export default About;
