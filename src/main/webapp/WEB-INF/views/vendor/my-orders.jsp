<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        .orders-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .order-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: none;
            overflow: hidden;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .order-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
        }

        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-shipping { background: #d4edda; color: #155724; }
        .status-delivered { background: #d1ecf1; color: #0c5460; }
        .status-cancelled { background: #f8d7da; color: #721c24; }

        .order-item {
            border-bottom: 1px solid #f8f9fa;
            padding: 15px 20px;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
        }

        .order-total {
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: #667eea;
        }

        .btn-view-detail {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            color: white;
            transition: all 0.3s ease;
        }

        .btn-view-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
            color: white;
        }

        .empty-orders {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            margin: 40px 0;
        }

        .empty-orders i {
            font-size: 5rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .filter-tabs {
            background: white;
            border-radius: 15px;
            padding: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .filter-tab {
            border: none;
            background: transparent;
            color: #666;
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .filter-tab.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .filter-tab:hover:not(.active) {
            background: #f8f9fa;
            color: #333;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<!-- Orders Header -->
<section class="orders-header">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="animate__animated animate__fadeInDown">
                    <i class="fas fa-receipt me-3"></i>Đơn hàng của tôi
                </h1>
                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                    Theo dõi và quản lý tất cả đơn hàng của bạn
                </p>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Alert Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeInDown" role="alert">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Filter Tabs -->
    <div class="filter-tabs animate__animated animate__fadeInUp">
        <div class="d-flex justify-content-center">
            <button class="filter-tab active" onclick="filterOrders('all')">Tất cả</button>
            <button class="filter-tab" onclick="filterOrders('PENDING')">Chờ xử lý</button>
            <button class="filter-tab" onclick="filterOrders('SHIPPING')">Đang giao</button>
            <button class="filter-tab" onclick="filterOrders('DELIVERED')">Đã giao</button>
            <button class="filter-tab" onclick="filterOrders('CANCELLED')">Đã hủy</button>
        </div>
    </div>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}" varStatus="status">
                <div class="order-card animate__animated animate__fadeInUp" style="animation-delay: ${status.index * 0.1}s" data-status="${not empty order.status ? order.status.name() : 'PENDING'}">
                    <div class="order-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-1">Đơn hàng #${order.id}</h5>
                                <small>Ngày đặt: 
                                    <c:choose>
                                        <c:when test="${not empty order.createdAt}">
                                            ${fn:substring(order.createdAt.toString(), 0, 10)} ${fn:substring(order.createdAt.toString(), 11, 16)}
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="text-end">
                                <c:choose>
                                    <c:when test="${not empty order.status}">
                                        <span class="order-status status-${fn:toLowerCase(order.status.name())}">${order.status.name()}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="order-status status-pending">PENDING</span>
                                    </c:otherwise>
                                </c:choose>
                                <div class="mt-2 d-flex gap-2">
                                    <a href="<c:url value='/vendor/my-orders/${order.id}'/>" class="btn btn-view-detail btn-sm">
                                        <i class="fas fa-eye me-1"></i>Xem chi tiết
                                    </a>
                                    <c:if test="${not empty order.status && order.status.name() == 'PENDING'}">
                                        <form method="post" action="<c:url value='/vendor/my-orders/${order.id}/cancel'/>" style="display: inline;" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id}? Đơn hàng sẽ không thể khôi phục sau khi hủy.');">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fas fa-times-circle me-1"></i>Hủy đơn hàng
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${not empty order.status && order.status.name() == 'SHIPPING'}">
                                        <form method="post" action="<c:url value='/vendor/my-orders/${order.id}/confirm-delivered'/>" style="display: inline;" onsubmit="return confirm('Bạn có chắc chắn đã nhận được hàng? Đơn hàng sẽ chuyển sang trạng thái đã giao.');">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="fas fa-check-circle me-1"></i>Xác nhận đã nhận hàng
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="order-items">
                        <c:forEach var="item" items="${order.items}" begin="0" end="1">
                            <div class="order-item">
                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty item.productImage}">
                                            <img src="<c:url value='/files/${item.productImage}'/>"
                                                 alt="${item.productNameVi}"
                                                 class="product-image me-3">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image bg-light d-flex align-items-center justify-content-center me-3 border">
                                                <i class="fas fa-image text-muted" style="font-size: 1.5rem;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">${item.productNameVi}</h6>
                                        <small class="text-muted">Số lượng: ${item.quantity} × <fmt:formatNumber value="${item.price}" pattern="#,##0"/> đ</small>
                                    </div>
                                    <div class="fw-bold text-primary">
                                        <fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/> đ
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="order-total">
                        <div class="total-amount">
                            Tổng tiền: <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> đ
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-orders animate__animated animate__fadeInUp">
                <i class="fas fa-shopping-bag"></i>
                <h3>Bạn chưa có đơn hàng nào</h3>
                <p class="text-muted">Hãy bắt đầu mua sắm để xem đơn hàng tại đây</p>
                <a href="<c:url value='/user/products'/>" class="btn btn-primary btn-lg">
                    <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function filterOrders(status) {
        // Update active tab
        document.querySelectorAll('.filter-tab').forEach(tab => tab.classList.remove('active'));
        event.target.classList.add('active');

        // Filter orders
        const orders = document.querySelectorAll('.order-card');

        orders.forEach(order => {
            if (status === 'all' || order.dataset.status === status) {
                order.style.display = 'block';
            } else {
                order.style.display = 'none';
            }
        });
    }

    // Add loading effect to links
    document.querySelectorAll('a[href*="/vendor/my-orders/"]').forEach(link => {
        link.addEventListener('click', function() {
            const btn = this;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang tải...';
            btn.disabled = true;
        });
    });
</script>
</body>
</html>

