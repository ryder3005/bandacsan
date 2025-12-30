<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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

        /* Enhanced Card Effects */
        .card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-radius: 15px;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        /* Stats Cards Special Animation */
        .stats-card {
            animation: slideInUp 0.6s ease-out forwards;
            opacity: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stats-card:nth-child(1) { animation-delay: 0.1s; }
        .stats-card:nth-child(2) { animation-delay: 0.2s; }
        .stats-card:nth-child(3) { animation-delay: 0.3s; }
        .stats-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Button Effects */
        .btn {
            transition: all 0.3s ease;
            border-radius: 10px;
            font-weight: 600;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* Table Effects */
        .table-hover tbody tr {
            transition: all 0.2s ease;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.1);
            transform: scale(1.01);
        }

        /* Loading Animation */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.95);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            50% { transform: rotate(180deg); }
            100% { transform: rotate(360deg); }
        }

        /* Dashboard Special Effects */
        .dashboard-header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            border-radius: 15px;
        }

        .dashboard-header h1 {
            animation: textGlow 2s ease-in-out infinite alternate;
        }

        @keyframes textGlow {
            from { text-shadow: 0 0 10px rgba(255,255,255,0.5); }
            to { text-shadow: 0 0 20px rgba(255,255,255,0.8), 0 0 30px rgba(255,255,255,0.6); }
        }

        /* Floating Action Button */
        .fab {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            box-shadow: 0 6px 25px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            z-index: 1000;
            animation: float 3s ease-in-out infinite;
        }

        .fab:hover {
            transform: scale(1.1) translateY(-5px);
            box-shadow: 0 8px 35px rgba(0,0,0,0.4);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        /* Progress Bars Animation */
        .progress-bar {
            animation: progressFill 2s ease-out;
        }

        @keyframes progressFill {
            from { width: 0%; }
            to { width: var(--progress-width); }
        }

        /* Notification Effects */
        .alert {
            animation: slideInRight 0.5s ease-out;
            border-radius: 10px;
            border: none;
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

        /* Pulse Animation */
        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <div class="page-transition">
        <div class="dashboard-header animate__animated animate__fadeInDown">
            <h1 class="mb-4 text-center"><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
            <p class="text-center mb-0">Chào mừng, <c:out value="${sessionScope.user != null ? sessionScope.user.username : 'Admin'}"/>! Đây là trang quản trị hệ thống.</p>
        </div>
    <p class="text-muted mb-4">Chào mừng, <c:out value="${sessionScope.user != null ? sessionScope.user.username : 'Admin'}"/>! Đây là trang quản trị hệ thống.</p>

    <!-- Quick Stats -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary stats-card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-people"></i> Người dùng</h5>
                    <h3 class="mb-0">${not empty users ? fn:length(users) : 0}</h3>
                    <small>Tổng số người dùng</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success stats-card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-tags"></i> Danh mục</h5>
                    <h3 class="mb-0">${not empty categories ? fn:length(categories) : 0}</h3>
                    <small>Tổng số danh mục</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning stats-card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-box-seam"></i> Sản phẩm</h5>
                    <h3 class="mb-0">${not empty products ? fn:length(products) : 0}</h3>
                    <small>Tổng số sản phẩm</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info stats-card">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-shop"></i> Nhà bán</h5>
                    <h3 class="mb-0">${not empty vendors ? fn:length(vendors) : 0}</h3>
                    <small>Tổng số nhà bán</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="bi bi-lightning"></i> Thao tác nhanh</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/users'/>" class="btn btn-outline-primary w-100">
                        <i class="bi bi-people"></i><br>
                        Quản lý người dùng
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-success w-100">
                        <i class="bi bi-tags"></i><br>
                        Quản lý danh mục
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-warning w-100">
                        <i class="bi bi-box-seam"></i><br>
                        Quản lý sản phẩm
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/vendors'/>" class="btn btn-outline-info w-100">
                        <i class="bi bi-shop"></i><br>
                        Quản lý nhà bán
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Categories List (nếu có) -->
    <c:if test="${not empty categories}">
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="bi bi-tags"></i> Danh mục sản phẩm</span>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-success btn-sm">
                    <i class="bi bi-plus-circle"></i> Xem tất cả
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên (Tiếng Việt)</th>
                            <th>Tên (Tiếng Anh)</th>
                            <th>Số sản phẩm</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cat" items="${categories}" begin="0" end="4">
                            <tr>
                                <td>${cat.id}</td>
                                <td>${cat.nameVi != null ? cat.nameVi : '-'}</td>
                                <td>${cat.nameEn != null ? cat.nameEn : '-'}</td>
                                <td>-</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Empty State -->
    <c:if test="${empty categories && empty users}">
        <div class="card">
            <div class="card-body text-center py-5">
                <i class="bi bi-inbox animate__animated animate__bounceIn" style="font-size: 4rem; color: #ccc;"></i>
                <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                <p class="text-muted">Bắt đầu quản lý hệ thống bằng cách thêm dữ liệu mới.</p>
            </div>
        </div>
    </c:if>
    </div> <!-- End page-transition -->
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Đảm bảo dropdown menu hoạt động trên trang admin dashboard
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
            // Add entrance animations
            setTimeout(function() {
                document.querySelectorAll('.stats-card').forEach(function(card, index) {
                    setTimeout(function() {
                        card.style.opacity = '1';
                    }, index * 100);
                });
            }, 300);
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

        // Add pulse effect to primary stats
        document.querySelectorAll('.stats-card .card-body h3').forEach(function(stat) {
            if (parseInt(stat.textContent.replace(/[^\d]/g, '')) > 0) {
                stat.classList.add('pulse');
            }
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
