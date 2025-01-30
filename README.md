cd từ thư mục backend
uvicorn app.main:app --reload
cd từ thư mục frontend
npm run start

# HƯỚNG DẪN CHẠY DOCKER

1. Tải và chạy Docker Desktop
2. cd vào /web
3. Chạy lệnh: docker-compose up --build
4. Đợi đến khi các container chạy hết trừ web-backend1
5. Chạy web-backend1 sau khi container của database đã sẵn sàng
6. Thử nghiệm trang web trên http://localhost:3000/
7. Tắt bằng Ctrl C
8. Tắt container của Docker bằng docker-compose down -v

người dùng admin: 
- admin@gm.com
- admin@123

người dùng bình thường:
- thuvokhanh05199@gmail.com
- vothu921/