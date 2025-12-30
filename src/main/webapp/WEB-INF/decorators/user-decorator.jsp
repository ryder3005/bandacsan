<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặc sản quê hương</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet"/>
    <style>
        /* Page Transition Effects */
        .page-transition {
            opacity: 0;
            animation: fadeInUp 0.6s ease-out forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Card Hover Effects */
        .card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        /* Button Effects */
        .btn {
            transition: all 0.3s ease;
            border-radius: 8px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Form Input Effects */
        .form-control, .form-select {
            transition: all 0.3s ease;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .form-control:focus, .form-select:focus {
            transform: scale(1.02);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            border-color: #667eea;
        }

        /* Table Effects */
        .table-hover tbody tr {
            transition: all 0.2s ease;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
            transform: scale(1.01);
        }

        /* Navbar Animation */
        .navbar-nav .nav-link {
            position: relative;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background-color: white;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .navbar-nav .nav-link:hover::after {
            width: 100%;
        }

        /* User Dropdown Animation */
        .user-dropdown .dropdown-menu {
            animation: dropdownFade 0.3s ease-out;
        }

        @keyframes dropdownFade {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Stats Cards Animation */
        .stats-card {
            animation: slideInLeft 0.6s ease-out forwards;
            opacity: 0;
        }

        .stats-card:nth-child(1) { animation-delay: 0.1s; }
        .stats-card:nth-child(2) { animation-delay: 0.2s; }
        .stats-card:nth-child(3) { animation-delay: 0.3s; }
        .stats-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Notification Effects */
        .alert {
            animation: slideInRight 0.5s ease-out;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(100%);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Pulse Animation for Active Elements */
        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        /* Gradient Backgrounds */
        .gradient-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .gradient-success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        .gradient-warning {
            background: linear-gradient(135deg, #fcb045 0%, #fd1d1d 100%);
        }

        .gradient-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        /* Floating Action Button */
        .fab {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .fab:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 30px rgba(0,0,0,0.4);
        }

        /* Modal Effects */
        .modal-content {
            animation: modalFadeIn 0.3s ease-out;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: scale(0.9) translateY(-20px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        /* Product Card Animation */
        .product-card {
            transition: all 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-10px) rotate(1deg);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        /* Search Bar Animation */
        .search-container {
            position: relative;
            overflow: hidden;
        }

        .search-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            animation: searchShine 3s infinite;
        }

        @keyframes searchShine {
            0% { left: -100%; }
            100% { left: 100%; }
        }
    </style>
    <sitemesh:write property="head"/>
    <style>
        * {
            font-family: 'Inter', 'Roboto', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            font-family: 'Inter', 'Roboto', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            <div class="page-transition">
                <sitemesh:write property="body"/>
            </div>
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
    <script>
        // Đảm bảo dropdown menu hoạt động trên tất cả các trang
        document.addEventListener('DOMContentLoaded', function() {
            // Đóng dropdown khi click bên ngoài
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.dropdown')) {
                    // Đóng tất cả dropdown đang mở
                    document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
                        menu.classList.remove('show');
                        var toggle = menu.previousElementSibling;
                        if (toggle) {
                            toggle.setAttribute('aria-expanded', 'false');
                        }
                    });
                }
            });

            // Ngăn dropdown đóng khi click bên trong menu
            document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
                menu.addEventListener('click', function(event) {
                    event.stopPropagation();
                });
            });

            // Đảm bảo dropdown toggle hoạt động
            document.querySelectorAll('.dropdown-toggle').forEach(function(toggle) {
                toggle.addEventListener('click', function(event) {
                    event.preventDefault();
                    event.stopPropagation();

                    var menu = this.nextElementSibling;
                    if (menu && menu.classList.contains('dropdown-menu')) {
                        // Đóng dropdown khác trước
                        document.querySelectorAll('.dropdown-menu.show').forEach(function(otherMenu) {
                            if (otherMenu !== menu) {
                                otherMenu.classList.remove('show');
                                var otherToggle = otherMenu.previousElementSibling;
                                if (otherToggle) {
                                    otherToggle.setAttribute('aria-expanded', 'false');
                                }
                            }
                        });

                        // Toggle menu hiện tại
                        var isExpanded = this.getAttribute('aria-expanded') === 'true';
                        if (isExpanded) {
                            menu.classList.remove('show');
                            this.setAttribute('aria-expanded', 'false');
                        } else {
                            menu.classList.add('show');
                            this.setAttribute('aria-expanded', 'true');
                        }
                    }
                });
            });

            // Loading functions
            function showLoading() {
                document.getElementById('loadingOverlay').style.display = 'flex';
            }

            function hideLoading() {
                document.getElementById('loadingOverlay').style.display = 'none';
            }

            // Intercept all form submissions and links for loading effect
            document.querySelectorAll('form').forEach(function(form) {
                form.addEventListener('submit', function() {
                    showLoading();
                });
            });

            // Add loading effect to all links (except external or hash links)
            document.querySelectorAll('a').forEach(function(link) {
                if (!link.href.includes('#') && !link.href.includes('javascript:') &&
                    link.hostname === window.location.hostname) {
                    link.addEventListener('click', function() {
                        showLoading();
                    });
                }
            });

            // Hide loading when page is loaded
            window.addEventListener('load', function() {
                hideLoading();
            });

            // Add animation classes to stats cards
            document.querySelectorAll('.card').forEach(function(card, index) {
                if (card.closest('.row') && card.closest('.row').querySelectorAll('.card').length >= 3) {
                    card.classList.add('stats-card');
                }
            });

            // Add product card animations
            document.querySelectorAll('.card').forEach(function(card) {
                if (card.querySelector('img') || card.querySelector('.card-title')) {
                    card.classList.add('product-card');
                }
            });

            // Add smooth scroll to anchor links
            document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
                anchor.addEventListener('click', function(e) {
                    e.preventDefault();
                    var target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });
    </script>

    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <!-- Floating Action Button -->
    <button class="fab" onclick="window.scrollTo({top: 0, behavior: 'smooth'})" title="Lên đầu trang">
        <i class="bi bi-arrow-up"></i>
    </button>
</body>
</html>
