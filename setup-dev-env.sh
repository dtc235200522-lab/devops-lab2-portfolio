#!/bin/bash
echo "=== AUTOMATED DEV ENVIRONMENT SETUP ==="

# 1. Kiểm tra trạng thái Docker Engine
echo "[1/4] Kiểm tra Docker..."
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker chưa chạy! Vui lòng mở ứng dụng Docker Desktop trên máy."
    exit 1
fi
echo "✔ Docker đã sẵn sàng."

# 2. Xóa Container cũ nếu đang tồn tại (tránh xung đột cổng 3000)
echo "[2/4] Dọn dẹp môi trường cũ..."
docker stop lab2-app 2>/dev/null || true
docker rm lab2-app 2>/dev/null || true

# 3. Tự động Build Docker Image
echo "[3/4] Đang build Docker Image từ Dockerfile..."
docker build -t devops-lab2-app .

# 4. Tự động Khởi chạy Container
echo "[4/4] Đang khởi chạy Container..."
docker run -d -p 3000:3000 --name lab2-app devops-lab2-app

echo ""
echo "=== SETUP TỰ ĐỘNG HOÀN TẤT ==="
echo "Ứng dụng đang chạy tại địa chỉ: http://localhost:3000"