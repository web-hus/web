cd từ thư mục backend
uvicorn app.main:app --reload
cd từ thư mục frontend
npm run start

# HƯỚNG DẪN CHẠY DOCKER

1. Tải và chạy Docker Desktop
2. cd vào /web
3. Chạy lệnh: docker-compose up --build
4. Thử nghiệm trang web trên http://localhost:3000/
5. Tắt bằng Ctrl C
6. Tắt container của Docker bằng docker-compose down -v