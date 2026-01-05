
````md
# 🛒 BanDacSan  
### Nền tảng Thương mại Điện tử Đặc sản Vùng miền

---

## 📖 Giới thiệu Dự án

**BanDacSan** là một website **thương mại điện tử chuyên về đặc sản vùng miền Việt Nam**, được xây dựng bằng **Java Spring Boot**.  
Hệ thống đóng vai trò là **cầu nối giữa nhà cung cấp địa phương (Vendor)** và **khách hàng (Customer)** trên toàn quốc.

Dự án không chỉ là một website bán hàng thông thường mà còn tích hợp nhiều tính năng nâng cao như:

- 💬 Chat thời gian thực giữa người mua và người bán  
- 📦 Quản lý đơn hàng đa trạng thái  
- 📊 Báo cáo và thống kê doanh thu trực quan cho người bán  

Mục tiêu của dự án là xây dựng một nền tảng thương mại điện tử **hiện đại, bảo mật và dễ mở rộng**, phục vụ cho **mục đích học tập và nghiên cứu**.

---

## 🚀 Công nghệ Sử dụng

### 🔧 Backend
- Spring Boot 3.4.12
- Spring Security (Authentication & Authorization)
- Spring Data JPA (Hibernate)
- Java 17

### 🗄️ Database
- MySQL

### 🎨 Frontend
- JSP / JSTL
- HTML5 / CSS3 / JavaScript
- Bootstrap (Responsive UI)

### 🛠️ Tools
- Maven
- IntelliJ IDEA / Eclipse

---

## ✨ Tính năng Nổi bật

### 👤 1. Khách hàng (Customer)
- Đăng ký / Đăng nhập an toàn (mã hóa mật khẩu)
- Tìm kiếm & lọc sản phẩm theo tên, giá, danh mục, nhà cung cấp
- Giỏ hàng thông minh (thêm / sửa / xóa sản phẩm)
- Đặt hàng (COD)
- Chat trực tiếp với người bán
- Theo dõi trạng thái & lịch sử đơn hàng

---

### 🏪 2. Người bán (Vendor)
- Đăng ký gian hàng
- Quản lý sản phẩm (CRUD)
- Quản lý đơn hàng
- Thống kê & báo cáo doanh thu

---

### 🛡️ 3. Quản trị viên (Admin)
- Quản lý danh mục đặc sản
- Quản lý người dùng
- Khóa tài khoản vi phạm

---

## 🛠️ Hướng dẫn Cài đặt & Chạy ứng dụng

### 🔹 Bước 1: Chuẩn bị môi trường
Cài đặt:
- JDK 17
- MySQL Server
- Maven

---

### 🔹 Bước 2: Cấu hình Database

Tạo database:
```sql
CREATE DATABASE bandacsan;
````

Cấu hình trong `application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/bandacsan?useSSL=false
spring.datasource.username=root
spring.datasource.password=1234
```

---

### 🔹 Bước 3: Chạy ứng dụng

* Mở project bằng IntelliJ IDEA
* Chạy file `Springboot3412Application.java`

---

### 🔹 Bước 4: Truy cập

* URL: [http://localhost:8080](http://localhost:8080)

Tài khoản Admin (nếu có dữ liệu mẫu):

```
Username: admin
Password: admin
```

---

## 📂 Cấu trúc Thư mục

```
src/main/java
 ├── controller
 ├── entity
 ├── repository
 ├── service

src/main/resources
 ├── webapp / templates
 ├── static
 └── application.properties
```

---

## 🤝 Đóng góp
Mọi đóng góp xin vui lòng tạo **Pull Request** hoặc **Issue** trên GitHub.
## 📜 Bản quyền

Dự án mã nguồn mở, phục vụ cho mục đích **học tập và nghiên cứu**.

### ✅ Cách dùng
1. Vào **repository GitHub**
2. Mở file `README.md` (hoặc tạo mới)
3. **Dán toàn bộ nội dung trên**
4. Commit → Done ✅

