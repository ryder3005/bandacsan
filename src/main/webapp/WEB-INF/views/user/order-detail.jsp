<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id} - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-detail-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }
        .order-detail-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            overflow: hidden;
        }
        .order-detail-card-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
        }
        .order-item {
            border-bottom: 1px solid #f8f9fa;
            padding: 20px;
        }
        .order-item:last-child {
            border-bottom: none;
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
        }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-shipping { background: #d4edda; color: #155724; }
        .status-delivered { background: #d1ecf1; color: #0c5460; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<jsp:include page="/WEB-INF/common/toast-handler.jsp" />

<div class="order-detail-header">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="mb-3"><i class="fas fa-receipt me-3"></i>Chi tiết đơn hàng #${order.id}</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb bg-transparent p-0 mb-0">
                        <li class="breadcrumb-item"><a href="<c:url value='/user/home'/>" class="text-white-50">Trang chủ</a></li>
                        <li class="breadcrumb-item"><a href="<c:url value='/user/orders'/>" class="text-white-50">Đơn hàng</a></li>
                        <li class="breadcrumb-item active text-white">Chi tiết</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-lg-8">
            <!-- Order Items -->
            <div class="order-detail-card">
                <div class="order-detail-card-header">
                    <h4 class="mb-0"><i class="fas fa-shopping-bag me-2"></i>Sản phẩm</h4>
                </div>
                <div class="card-body p-0">
                    <c:forEach var="item" items="${order.items}">
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
                                            <i class="fas fa-image text-muted" style="font-size: 2rem;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="flex-grow-1">
                                    <h5 class="mb-1">${item.productNameVi}</h5>
                                    <p class="text-muted mb-1">Số lượng: ${item.quantity}</p>
                                    <p class="text-muted mb-0">Đơn giá: <fmt:formatNumber value="${item.price}" pattern="#,##0"/> đ</p>
                                </div>
                                <div class="text-end">
                                    <h5 class="mb-0 text-primary"><fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/> đ</h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <!-- Order Info -->
            <div class="order-detail-card">
                <div class="order-detail-card-header">
                    <h4 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng</h4>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <strong>Trạng thái:</strong>
                        <div class="mt-2">
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">
                                    <span class="status-badge status-pending">Chờ xử lý</span>
                                </c:when>
                                <c:when test="${order.status == 'SHIPPING'}">
                                    <span class="status-badge status-shipping">Đang giao</span>
                                </c:when>
                                <c:when test="${order.status == 'DELIVERED'}">
                                    <span class="status-badge status-delivered">Đã giao</span>
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="status-badge status-cancelled">Đã hủy</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <hr>
                    <div class="mb-3">
                        <strong>Mã đơn hàng:</strong>
                        <p class="mb-0">#${order.id}</p>
                    </div>
                    <div class="mb-3">
                        <strong>Ngày đặt:</strong>
                        <p class="mb-0"><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                    </div>
                    <c:if test="${not empty order.payment}">
                        <div class="mb-3">
                            <strong>Phương thức thanh toán:</strong>
                            <p class="mb-0">${order.payment.method}</p>
                        </div>
                        <div class="mb-3">
                            <strong>Trạng thái thanh toán:</strong>
                            <p class="mb-0">${order.payment.status}</p>
                        </div>
                    </c:if>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <strong class="fs-5">Tổng tiền:</strong>
                        <h4 class="mb-0 text-primary"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> đ</h4>
                    </div>
                    <hr>
                    <c:if test="${order.status == 'SHIPPING'}">
                        <form method="post" action="<c:url value='/user/orders/${order.id}/confirm-delivered'/>" onsubmit="return confirm('Bạn có chắc chắn đã nhận được hàng? Đơn hàng sẽ chuyển sang trạng thái đã giao.');">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-check-circle me-2"></i>Xác nhận đã nhận hàng
                            </button>
                        </form>
                    </c:if>
                    <a href="<c:url value='/user/orders'/>" class="btn btn-outline-secondary w-100 mt-2">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

