<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhà bán hàng - Vendor Dashboard</title>
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
            border-top: 4px solid #1abc9c;
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
            box-shadow: 0 0 0 0.2rem rgba(26, 188, 156, 0.25);
            border-color: #1abc9c;
        }

        /* Table Effects */
        .table-hover tbody tr {
            transition: all 0.2s ease;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(26, 188, 156, 0.1);
            transform: scale(1.01);
        }

        /* Sidebar Animation */
        .sidebar-menu a {
            position: relative;
            overflow: hidden;
        }

        .sidebar-menu a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .sidebar-menu a:hover::before {
            left: 100%;
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
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
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
            background: linear-gradient(135deg, #16a085 0%, #1abc9c 100%);
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
    </style>
    <sitemesh:write property='head'/>
    <style>
        * {
            font-family: 'Inter', 'Roboto', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f5f7fa;
            font-family: 'Inter', 'Roboto', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #16a085 0%, #1abc9c 100%);
            color: white;
            padding: 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }
        .sidebar-header {
            padding: 20px;
            background: rgba(0,0,0,0.2);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .sidebar-header h4 {
            margin: 0;
            font-weight: 600;
            color: white;
        }
        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar-menu li {
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        .sidebar-menu a {
            display: block;
            padding: 15px 20px;
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        .sidebar-menu a:hover {
            background: rgba(255,255,255,0.15);
            color: white;
            border-left-color: #f39c12;
        }
        .sidebar-menu a.active {
            background: rgba(243, 156, 18, 0.2);
            color: white;
            border-left-color: #f39c12;
        }
        .sidebar-menu i {
            width: 20px;
            margin-right: 10px;
        }
        .main-content {
            padding: 20px;
        }
        .top-navbar {
            background: white;
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-info span {
            color: #16a085;
            font-weight: 500;
        }
        footer {
            background: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="sidebar-header">
                    <h4><i class="bi bi-shop"></i> Khu vực Nhà bán</h4>
                </div>
                <ul class="sidebar-menu">
                    <li>
                        <a href="<c:url value='/vendor/dashboard'/>">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/shop'/>">
                            <i class="bi bi-building"></i> Quản lý Shop
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/products'/>">
                            <i class="bi bi-box-seam"></i> Sản phẩm
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/orders'/>">
                            <i class="bi bi-cart-check"></i> Đơn hàng
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/revenue'/>">
                            <i class="bi bi-cash-coin"></i> Doanh thu
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/blogs'/>">
                            <i class="bi bi-journal-text"></i> Blog của tôi
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/vendor/chat'/>">
                            <i class="bi bi-chat-dots"></i> Chat với khách
                        </a>
                    </li>
                    <li>
                        <a href="<c:url value='/'/>">
                            <i class="bi bi-house"></i> Về trang chủ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="top-navbar">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-0" style="color: #16a085;">
                                Vendor Dashboard
                            </h5>
                        </div>
                        <div class="user-info">
                            <c:if test="${not empty sessionScope.user}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-success btn-sm dropdown-toggle" type="button" id="vendorDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-circle"></i> ${sessionScope.user.username}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="vendorDropdown">
                                        <li><a class="dropdown-item" href="<c:url value='/profile'/>">
                                            <i class="bi bi-person"></i> Thông tin cá nhân
                                        </a></li>
                                        <li><a class="dropdown-item" href="<c:url value='/vendor/dashboard'/>">
                                            <i class="bi bi-shop"></i> Quản lý shop
                                        </a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">
                                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                        </a></li>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <main class="main-content">
                    <div class="page-transition">
                        <sitemesh:write property='body'/>
                    </div>
                </main>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p class="mb-0">
                &copy; <%= java.time.Year.now() %> Website Quảng bá và Kinh doanh Đặc sản Quê hương
            </p>
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

