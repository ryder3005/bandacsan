BanDacSan - Nền Tảng Thương Mại Điện Tử Đặc Sản Vùng Miền
📖 Giới thiệu Dự án
BanDacSan là một website thương mại điện tử chuyên cung cấp các sản phẩm đặc sản vùng miền, được xây dựng trên nền tảng Java Spring Boot. Hệ thống đóng vai trò là cầu nối giữa các nhà cung cấp địa phương (Vendor) và khách hàng (Customer) trên toàn quốc.

Dự án không chỉ là một website bán hàng thông thường mà còn tích hợp nhiều tính năng nâng cao như: chat thời gian thực giữa người mua và người bán, quản lý đơn hàng đa trạng thái, và hệ thống báo cáo doanh thu trực quan cho người bán hàng.

🚀 Công nghệ Sử dụng
Dự án áp dụng các công nghệ tiên tiến và phổ biến nhất trong lập trình Java Web hiện nay:

Backend:
Spring Boot 3.4.12: Framework chính giúp phát triển ứng dụng nhanh chóng, cấu hình tự động.
Spring Security: Bảo mật hệ thống, phân quyền (Authentication & Authorization).
Spring Data JPA (Hibernate): Tương tác với cơ sở dữ liệu.
Java 17: Ngôn ngữ lập trình chính.
Database:
MySQL: Hệ quản trị cơ sở dữ liệu quan hệ.
Frontend:
JSP / JSTL: Template engine để render giao diện phía server.
HTML5 / CSS3 / JavaScript: Xây dựng giao diện người dùng.
Bootstrap: Framework CSS giúp website hiển thị tốt trên mọi thiết bị (Responsive).
Tools:
Maven: Quản lý thư viện và build dự án.
IntelliJ IDEA / Eclipse: Môi trường phát triển tích hợp (IDE).
✨ Tính năng Nổi bật
1. Phân hệ Khách hàng (Customer)
Đăng ký/Đăng nhập: Tạo tài khoản nhanh chóng, bảo mật mật khẩu.
Tìm kiếm & Lọc sản phẩm: Tìm theo tên, khoảng giá, danh mục, hoặc nhà cung cấp.
Giỏ hàng thông minh: Thêm/sửa/xóa sản phẩm, tự động tính tổng tiền.
Đặt hàng (Checkout): Quy trình đặt hàng đơn giản, hỗ trợ thanh toán khi nhận hàng (COD).
Trò chuyện (Chat): Nhắn tin trực tiếp với chủ shop để hỏi về sản phẩm trước khi mua.
Lịch sử đơn hàng: Theo dõi trạng thái đơn hàng (đang xử lý, đang giao, đã giao).
2. Phân hệ Người bán (Vendor)
Đăng ký gian hàng: Người dùng có thể đăng ký trở thành người bán.
Quản lý sản phẩm: Thêm mới, cập nhật thông tin, hình ảnh, giá bán, kho hàng.
Quản lý đơn hàng: Tiếp nhận đơn hàng mới, xác nhận giao hàng hoặc hủy đơn.
Báo cáo thống kê: Xem doanh thu theo ngày/tháng, số lượng đơn hàng bán ra.
3. Phân hệ Quản trị viên (Admin)
Quản lý Danh mục: Thêm/sửa/xóa các loại đặc sản (Ví dụ: Đặc sản miền Tây, Tây Bắc...).
Quản lý Người dùng: Xem danh sách người dùng, khóa tài khoản vi phạm.
🛠️ Hướng dẫn Cài đặt & Chạy ứng dụng
Để chạy được dự án này trên máy cá nhân, bạn vui lòng làm theo các bước sau:

Bước 1: Chuẩn bị môi trường
Hãy đảm bảo máy tính của bạn đã cài đặt:

JDK 17 (Java Development Kit).
MySQL Server (Khuyên dùng MySQL Workbench hoặc XAMPP).
Maven (Thường đã tích hợp sẵn trong IntelliJ IDEA).
Bước 2: Cấu hình Cơ sở dữ liệu
Mở MySQL, tạo một database mới tên là bandacsan.
CREATE DATABASE bandacsan;
(Tùy chọn) Chạy file 
database.sql
 kèm theo để tạo bảng (Nếu không chạy, Hibernate sẽ tự động tạo bảng khi khởi động app).
Mở file 
src/main/resources/application.properties
 và cập nhật thông tin kết nối:
spring.datasource.url=jdbc:mysql://localhost:3306/bandacsan?useSSL=false
spring.datasource.username=root  <-- Tên đăng nhập MySQL của bạn
spring.datasource.password=1234  <-- Mật khẩu MySQL của bạn
Bước 3: Chạy ứng dụng
Mở dự án bằng IntelliJ IDEA.
Đợi Maven tải hết các thư viện (Dependencies).
Tìm file 
Springboot3412Application.java
 và nhấn nút Run.
Bước 4: Trải nghiệm
Mở trình duyệt truy cập: http://localhost:8080
Tài khoản Admin mặc định (nếu đã chạy file SQL):
User: admin
Pass: admin (hoặc pass bạn đã hash)
📂 Cấu trúc Thư mục
src/main/java: Chứa mã nguồn Java.
controller: Các lớp điều hướng request (UserPageController, VendorController...).
entity: Các lớp đại diện cho bảng dữ liệu (Product, User, Order...).
repository: Các interface tương tác database.
service: Các lớp xử lý nghiệp vụ logic.
src/main/resources: Chứa file cấu hình và giao diện.
templates hoặc webapp: Chứa file JSP/HTML.
static: Chứa CSS, JS, Img.
🤝 Đóng góp
Mọi ý kiến đóng góp xin vui lòng gửi Pull Request hoặc tạo Issue trên Github.

📜 Bản quyền
Dự án mã nguồn mở, phục vụ mục đích học tập và nghiên cứu.
