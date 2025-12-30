<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <sitemesh:write property="head"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 24px;
            color: white !important;
        }
        .navbar-nav .nav-link {
            color: rgba(255,255,255,0.9) !important;
            font-weight: 500;
            padding: 8px 15px !important;
            margin: 0 5px;
            border-radius: 8px;
            transition: all 0.3s;
        }
        .navbar-nav .nav-link:hover {
            background: rgba(255,255,255,0.2);
            color: white !important;
        }
        .navbar-nav .nav-link.active {
            background: rgba(255,255,255,0.3);
        }
        .user-dropdown .dropdown-toggle {
            color: white !important;
            background: rgba(255,255,255,0.2);
            border: none;
            border-radius: 8px;
            padding: 8px 15px;
        }
        .user-dropdown .dropdown-menu {
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            border: none;
            margin-top: 10px;
        }
        .main-content {
            min-height: calc(100vh - 200px);
            padding: 30px 0;
        }
        footer {
            background: #2c3e50;
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }
        footer a {
            color: #ecf0f1;
            text-decoration: none;
        }
        footer a:hover {
            color: white;
            text-decoration: underline;
        }
        .btn-cart {
            position: relative;
        }
        .badge-cart {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/user/home'/>">
                <i class="bi bi-shop"></i> Đặc sản quê hương
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/home'/>">
                            <i class="bi bi-house"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/products'/>">
                            <i class="bi bi-box-seam"></i> Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/categories'/>">
                            <i class="bi bi-tags"></i> Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/user/blogs'/>">
                            <i class="bi bi-journal-text"></i> Blog
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/user/cart'/>">
                                    <i class="bi bi-cart3"></i> Giỏ hàng
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/user/orders'/>">
                                    <i class="bi bi-receipt"></i> Đơn hàng
                                </a>
                            </li>
                            <li class="nav-item dropdown user-dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle"></i> ${sessionScope.user.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item" href="<c:url value='/user/profile'/>">
                                        <i class="bi bi-person"></i> Thông tin cá nhân
                                    </a></li>
                                    <li><a class="dropdown-item" href="<c:url value='/user/reviews'/>">
                                        <i class="bi bi-star"></i> Đánh giá của tôi
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">
                                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/login'/>">
                                    <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/register'/>">
                                    <i class="bi bi-person-plus"></i> Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <sitemesh:write property="body"/>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Về chúng tôi</h5>
                    <p>Website quảng bá và kinh doanh đặc sản quê hương Việt Nam</p>
                </div>
                <div class="col-md-4">
                    <h5>Liên hệ</h5>
                    <p><i class="bi bi-envelope"></i> Email: info@dacsanquehuong.com</p>
                    <p><i class="bi bi-telephone"></i> Hotline: 1900-xxxx</p>
                </div>
                <div class="col-md-4">
                    <h5>Theo dõi</h5>
                    <p>
                        <a href="#"><i class="bi bi-facebook"></i> Facebook</a> |
                        <a href="#"><i class="bi bi-instagram"></i> Instagram</a>
                    </p>
                </div>
            </div>
            <hr style="border-color: rgba(255,255,255,0.2);">
            <div class="text-center">
                <p class="mb-0">&copy; <%= java.time.Year.now() %> Đặc sản quê hương. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
