import React from "react";
import InstagramIcon from '@mui/icons-material/Instagram';
// import TwitterIcon from "@material-ui/icons/Twitter";
import FacebookIcon from '@mui/icons-material/Facebook';
import LinkedInIcon from '@mui/icons-material/LinkedIn';
import YouTubeIcon from '@mui/icons-material/YouTube';
import "../styles/Footer.css";

function Footer() {
  return (
    <div className="footer">
      <div className="socialMedia">
        <a href="https://www.instagram.com/pizza/" target="_blank" rel="noopener noreferrer">
          <InstagramIcon />
        </a>
        <a href="https://www.youtube.com/@pizzachannel" target="_blank" rel="noopener noreferrer">
          <YouTubeIcon />
        </a>
        <a href="https://www.facebook.com/PizzaPizzaCanada" target="_blank" rel="noopener noreferrer">
          <FacebookIcon />
        </a>
        <a href="https://www.linkedin.com/company/pizza4ps/" target="_blank" rel="noopener noreferrer">
          <LinkedInIcon />
        </a>
      </div>
      <p> Theo dõi chúng tôi để nhận nhiều ưu đãi hấp dẫn nhé! </p>
    </div>
  );
}

export default Footer;
