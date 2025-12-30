<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard - Quản lý cửa hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
            border-radius: 0 0 50px 50px;
        }

        .hero-section h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 20px;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stats-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .stats-card:hover::before {
            left: 100%;
        }

        .stats-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .stats-icon {
            font-size: 3rem;
            opacity: 0.8;
            margin-bottom: 15px;
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .quick-action-card {
            background: white;
            border: none;
            border-radius: 20px;
            padding: 30px 20px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            height: 100%;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .quick-action-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            transition: all 0.3s ease;
        }

        .quick-action-card:nth-child(1) .quick-action-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .quick-action-card:nth-child(2) .quick-action-icon {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .quick-action-card:nth-child(3) .quick-action-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .quick-action-card:nth-child(4) .quick-action-icon {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .quick-action-card:hover .quick-action-icon {
            transform: scale(1.1);
        }

        .recent-activity {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            padding: 30px;
            margin-top: 40px;
        }

        .activity-item {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            border-left: 5px solid #667eea;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .welcome-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 20px;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100px;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <div class="welcome-badge animate__animated animate__fadeInLeft">
                    <i class="fas fa-crown me-2"></i>
                    Chào mừng Vendor: <strong><c:out value="${sessionScope.user != null ? sessionScope.user.username : 'Vendor'}"/></strong>
                </div>
                <h1 class="animate__animated animate__fadeInUp">Quản lý cửa hàng của bạn</h1>
                <p class="lead animate__animated animate__fadeInUp animate__delay-1s">
                    Nơi bạn có thể quản lý sản phẩm, theo dõi đơn hàng và phát triển kinh doanh hiệu quả.
                </p>
            </div>
            <div class="col-lg-4 text-center">
                <i class="fas fa-store-alt animate__animated animate__bounceIn" style="font-size: 8rem; color: rgba(255,255,255,0.8);"></i>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Statistics Cards -->
    <div class="row mb-5">
        <div class="col-12">
            <h2 class="section-title animate__animated animate__fadeInUp">Thống kê cửa hàng</h2>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card stats-card animate__animated animate__fadeInUp">
                <div class="card-body text-center">
                    <div class="stats-icon">
                        <i class="fas fa-box-open"></i>
                    </div>
                    <div class="stats-number">${totalProducts != null ? totalProducts : 0}</div>
                    <h6 class="card-title mb-0">Tổng sản phẩm</h6>
                    <small class="opacity-75">Đang kinh doanh</small>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card stats-card animate__animated animate__fadeInUp animate__delay-1s">
                <div class="card-body text-center">
                    <div class="stats-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stats-number">${totalOrders != null ? totalOrders : 0}</div>
                    <h6 class="card-title mb-0">Đơn hàng</h6>
                    <small class="opacity-75">Tháng này</small>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card stats-card animate__animated animate__fadeInUp animate__delay-2s">
                <div class="card-body text-center">
                    <div class="stats-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="stats-number"><fmt:formatNumber value="${monthlyRevenue != null ? monthlyRevenue : 0}" pattern="#,##0"/></div>
                    <h6 class="card-title mb-0">Doanh thu</h6>
                    <small class="opacity-75">VNĐ</small>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card stats-card animate__animated animate__fadeInUp animate__delay-3s">
                <div class="card-body text-center">
                    <div class="stats-icon">
                        <i class="fas fa-bell"></i>
                    </div>
                    <div class="stats-number">${unreadMessages != null ? unreadMessages : 0}</div>
                    <h6 class="card-title mb-0">Thông báo</h6>
                    <small class="opacity-75">Chưa đọc</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mb-5">
        <div class="col-12">
            <h2 class="section-title animate__animated animate__fadeInUp">Thao tác nhanh</h2>
        </div>
    </div>
    <div class="row mb-5">
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="quick-action-card animate__animated animate__fadeInUp">
                <a href="<c:url value='/vendor/products'/>" class="text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-boxes"></i>
                    </div>
                    <h5 class="card-title mb-2">Quản lý sản phẩm</h5>
                    <p class="text-muted small mb-0">Thêm, sửa, xóa sản phẩm của bạn</p>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="quick-action-card animate__animated animate__fadeInUp animate__delay-1s">
                <a href="<c:url value='/vendor/orders'/>" class="text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h5 class="card-title mb-2">Đơn hàng</h5>
                    <p class="text-muted small mb-0">Xem và quản lý đơn hàng</p>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="quick-action-card animate__animated animate__fadeInUp animate__delay-2s">
                <a href="<c:url value='/vendor/shop'/>" class="text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-store"></i>
                    </div>
                    <h5 class="card-title mb-2">Quản lý Shop</h5>
                    <p class="text-muted small mb-0">Cập nhật thông tin cửa hàng</p>
                </a>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="quick-action-card animate__animated animate__fadeInUp animate__delay-3s">
                <a href="<c:url value='/vendor/revenue'/>" class="text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h5 class="card-title mb-2">Doanh thu</h5>
                    <p class="text-muted small mb-0">Xem báo cáo và thống kê</p>
                </a>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="recent-activity animate__animated animate__fadeInUp">
        <div class="row">
            <div class="col-12">
                <h3 class="text-center mb-4" style="color: #2c3e50; font-weight: 600;">
                    <i class="fas fa-history me-2"></i>Hoạt động gần đây
                </h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="activity-item">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fas fa-plus-circle text-success" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Sản phẩm mới</h6>
                            <p class="text-muted small mb-0">Bạn có thể thêm sản phẩm mới vào cửa hàng</p>
                        </div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fas fa-shopping-cart text-primary" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Đơn hàng</h6>
                            <p class="text-muted small mb-0">Theo dõi đơn hàng và giao hàng kịp thời</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="activity-item">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fas fa-chart-bar text-warning" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Thống kê</h6>
                            <p class="text-muted small mb-0">Xem báo cáo doanh thu và hiệu suất</p>
                        </div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fas fa-cog text-info" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Cài đặt</h6>
                            <p class="text-muted small mb-0">Tùy chỉnh thông tin cửa hàng của bạn</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
