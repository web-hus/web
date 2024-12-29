import React from "react";
import Res1 from "../assets/banner_sample/1.png";
import Res2 from "../assets/banner_sample/2.png";
import Res3 from "../assets/banner_sample/3.png";
import Res4 from "../assets/banner_sample/4.png";
import Res5 from "../assets/banner_sample/5.png";
import News1 from "../assets/News_img/bacon.png";
import News2 from "../assets/News_img/pasta.png";
import News3 from "../assets/News_img/ssam.png";
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

            {/* News Section */}
            <div className="container mt-5 news-section">
                <div className="row">
                    {[
                        {
                            img: News1,
                            title: "Tin tức 1",
                            text: "Đây là nội dung ngắn của bài viết số 1.",
                            link: "https://www.seriouseats.com/bacon-wapped-shrimp-recipe-8766097",
                        },
                        {
                            img: News2,
                            title: "Tin tức 2",
                            text: "Đây là nội dung ngắn của bài viết số 2.",
                            link: "https://www.seriouseats.com/rosette-al-forno-bolognese-lasagna-recipe-8760861",
                        },
                        {
                            img: News3,
                            title: "Tin tức 3",
                            text: "Đây là nội dung ngắn của bài viết số 3.",
                            link: "https://www.seriouseats.com/turkey-ssam-recipe-8749227",
                        },
                    ].map((news, index) => (
                        <div className="col-lg-4 col-md-6 col-sm-12 mb-4" key={index}>
                            <div className="card h-100">
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
                    </p>
                    <p className="marquee-text">
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                    </p>
                    <p className="marquee-text">
                        Nhà hàng chúng tôi chuyên phục vụ ẩm thực 3 miền. Hãy theo dõi tin tức để hiểu hơn về văn hóa ẩm thực Việt Nam và nhiều thông tin ưu đãi nhé.
                    </p>
                </div>
            </div>

        </div>
    );
}

export default About;
