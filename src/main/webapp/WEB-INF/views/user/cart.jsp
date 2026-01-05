<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Giỏ hàng - Đặc sản quê hương</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
                <style>
                    .cart-header {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 40px 0;
                        margin-bottom: 40px;
                    }

                    .cart-item {
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                        padding: 20px;
                        margin-bottom: 20px;
                        transition: all 0.3s ease;
                    }

                    .cart-item:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                    }

                    .product-image {
                        width: 80px;
                        height: 80px;
                        object-fit: cover;
                        border-radius: 10px;
                    }

                    .quantity-input {
                        width: 80px;
                        text-align: center;
                        border-radius: 8px;
                        border: 2px solid #e0e6ed;
                        padding: 8px 12px;
                    }

                    .btn-cart-action {
                        border-radius: 8px;
                        padding: 8px 16px;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .cart-summary {
                        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                        color: white;
                        border-radius: 15px;
                        padding: 30px;
                        position: sticky;
                        top: 20px;
                    }

                    .cart-total {
                        font-size: 2rem;
                        font-weight: 700;
                        margin-bottom: 20px;
                    }

                    .empty-cart {
                        text-align: center;
                        padding: 80px 20px;
                        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                        border-radius: 20px;
                        margin: 40px 0;
                    }

                    .empty-cart i {
                        font-size: 5rem;
                        color: #667eea;
                        margin-bottom: 20px;
                    }

                    .btn-continue-shopping {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        border: none;
                        border-radius: 50px;
                        padding: 15px 30px;
                        font-size: 1.1rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .btn-continue-shopping:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
                        color: white;
                    }

                    .btn-checkout {
                        background: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
                        border: none;
                        border-radius: 50px;
                        padding: 15px 30px;
                        font-size: 1.1rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .btn-checkout:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
                        color: white;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/common/header.jsp" />

                <!-- Cart Header -->
                <section class="cart-header">
                    <div class="container">
                        <div class="row">
                            <div class="col-12 text-center">
                                <h1 class="animate__animated animate__fadeInDown">
                                    <i class="fas fa-shopping-cart me-3"></i>Giỏ hàng của bạn
                                </h1>
                                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                                    Kiểm tra và quản lý các sản phẩm trong giỏ hàng
                                </p>
                            </div>
                        </div>
                    </div>
                </section>

                <div class="container">
                    <!-- Alert Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeInDown"
                            role="alert">
                            <i class="fas fa-check-circle me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX"
                            role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-lg-8">
                            <c:choose>
                                <c:when test="${not empty cart and not empty cart.items}">
                                    <c:forEach var="item" items="${cart.items}" varStatus="status">
                                        <div class="cart-item animate__animated animate__fadeInUp"
                                            style="animation-delay: ${status.index * 0.1}s">
                                            <div class="row align-items-center">
                                                <div class="col-md-2">
                                                    <c:choose>
                                                        <c:when test="${not empty item.productImage}">
                                                            <img src="${item.productImage}" alt="${item.productNameVi}"
                                                                class="product-image">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div
                                                                class="product-image bg-light d-flex align-items-center justify-content-center">
                                                                <i class="fas fa-image text-muted"
                                                                    style="font-size: 2rem;"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="col-md-4">
                                                    <h6 class="mb-1 fw-bold">${item.productNameVi}</h6>
                                                    <c:if test="${not empty item.productNameEn}">
                                                        <small class="text-muted">${item.productNameEn}</small>
                                                    </c:if>
                                                    <div class="mt-2">
                                                        <span class="badge bg-primary">
                                                            <fmt:formatNumber value="${item.productPrice}"
                                                                pattern="#,##0" /> đ
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <form method="post" action="<c:url value='/user/cart/update'/>"
                                                        class="d-inline">
                                                        <input type="hidden" name="itemId" value="${item.id}">
                                                        <div class="input-group">
                                                            <button type="button"
                                                                class="btn btn-outline-secondary btn-sm"
                                                                onclick="changeQuantity(${item.id}, ${item.quantity - 1})">
                                                                <i class="fas fa-minus"></i>
                                                            </button>
                                                            <input type="number" class="form-control quantity-input"
                                                                id="quantity-${item.id}" name="quantity"
                                                                value="${item.quantity}" min="1" max="99">
                                                            <button type="button"
                                                                class="btn btn-outline-secondary btn-sm"
                                                                onclick="changeQuantity(${item.id}, ${item.quantity + 1})">
                                                                <i class="fas fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="fw-bold text-primary">
                                                        <fmt:formatNumber value="${item.subtotal}" pattern="#,##0" /> đ
                                                    </div>
                                                </div>
                                                <div class="col-md-1">
                                                    <form method="post" action="<c:url value='/user/cart/remove'/>"
                                                        class="d-inline"
                                                        onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                        <input type="hidden" name="itemId" value="${item.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <!-- Clear Cart Button -->
                                    <div class="text-center mb-4">
                                        <form method="post" action="<c:url value='/user/cart/clear'/>" class="d-inline"
                                            onsubmit="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                            <button type="submit" class="btn btn-outline-danger">
                                                <i class="fas fa-trash-alt me-2"></i>Xóa toàn bộ giỏ hàng
                                            </button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-cart animate__animated animate__fadeInUp">
                                        <i class="fas fa-shopping-cart"></i>
                                        <h3>Giỏ hàng trống</h3>
                                        <p class="text-muted">Bạn chưa thêm sản phẩm nào vào giỏ hàng</p>
                                        <a href="<c:url value='/user/products'/>" class="btn btn-continue-shopping">
                                            <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Cart Summary -->
                        <c:if test="${not empty cart and not empty cart.items}">
                            <div class="col-lg-4">
                                <div class="cart-summary animate__animated animate__fadeInRight">
                                    <h4 class="mb-4">
                                        <i class="fas fa-receipt me-2"></i>Tóm tắt đơn hàng
                                    </h4>

                                    <div class="d-flex justify-content-between mb-3">
                                        <span>Tổng số sản phẩm:</span>
                                        <span class="fw-bold">${cart.totalItems}</span>
                                    </div>

                                    <div class="cart-total">
                                        <small class="d-block">Tổng tiền</small>
                                        <fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0" /> đ
                                    </div>

                                    <div class="d-grid gap-2">
                                        <a href="<c:url value='/user/checkout'/>" class="btn btn-checkout">
                                            <i class="fas fa-credit-card me-2"></i>Thanh toán
                                        </a>
                                        <a href="<c:url value='/user/products'/>" class="btn btn-continue-shopping">
                                            <i class="fas fa-arrow-left me-2"></i>Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/common/floating-widgets.jsp" />
                <jsp:include page="/WEB-INF/common/footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function changeQuantity(itemId, newQuantity) {
                        if (newQuantity < 1) return;

                        const quantityInput = document.getElementById('quantity-' + itemId);
                        quantityInput.value = newQuantity;

                        // Auto submit form
                        const form = quantityInput.closest('form');
                        form.submit();
                    }

                    // Add loading animation to forms
                    document.addEventListener('DOMContentLoaded', function () {
                        const forms = document.querySelectorAll('form');
                        forms.forEach(form => {
                            form.addEventListener('submit', function () {
                                const submitBtn = form.querySelector('button[type="submit"]');
                                if (submitBtn) {
                                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                                    submitBtn.disabled = true;
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>