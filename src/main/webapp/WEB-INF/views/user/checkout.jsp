<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        .checkout-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .checkout-form {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }

        .form-section {
            border-bottom: 2px solid #f8f9fa;
            padding-bottom: 30px;
            margin-bottom: 30px;
        }

        .form-section:last-child {
            border-bottom: none;
            padding-bottom: 0;
            margin-bottom: 0;
        }

        .section-title {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 20px;
            position: relative;
            padding-left: 25px;
        }

        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 5px;
            width: 20px;
            height: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
        }

        .order-summary {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border-radius: 20px;
            padding: 30px;
            position: sticky;
            top: 20px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        .summary-item:last-child {
            border-bottom: none;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 15px;
            background: rgba(255,255,255,0.1);
            border-radius: 10px;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 15px;
        }

        .payment-option {
            border: 2px solid #e0e6ed;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-option:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }

        .payment-option.selected {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.1);
        }

        .payment-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.2rem;
        }

        .btn-checkout {
            background: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
            border: none;
            border-radius: 50px;
            padding: 18px 40px;
            font-size: 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .btn-checkout:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(255, 107, 107, 0.4);
            color: white;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<!-- Checkout Header -->
<section class="checkout-header">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="animate__animated animate__fadeInDown">
                    <i class="fas fa-credit-card me-3"></i>Thanh toán đơn hàng
                </h1>
                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                    Hoàn tất đơn hàng của bạn chỉ với vài bước đơn giản
                </p>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Checkout Form -->
        <div class="col-lg-8">
            <form method="post" action="<c:url value='/user/checkout'/>" class="checkout-form animate__animated animate__fadeInLeft">
                <!-- Shipping Information -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-truck me-2"></i>Thông tin giao hàng
                    </h3>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="shippingAddress" class="form-label">Địa chỉ giao hàng *</label>
                            <textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3"
                                    placeholder="Nhập địa chỉ giao hàng chi tiết" required></textarea>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label">Số điện thoại *</label>
                            <input type="tel" class="form-control" id="phone" name="phone"
                                 placeholder="Nhập số điện thoại" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="notes" class="form-label">Ghi chú (tùy chọn)</label>
                        <textarea class="form-control" id="notes" name="notes" rows="2"
                                placeholder="Nhập ghi chú cho đơn hàng"></textarea>
                    </div>
                </div>

                <!-- Payment Method -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-credit-card me-2"></i>Phương thức thanh toán
                    </h3>
                    <div class="payment-options">
                        <div class="payment-option selected" data-method="COD">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon bg-success text-white">
                                    <i class="fas fa-hand-holding-usd"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Thanh toán khi nhận hàng (COD)</h6>
                                    <p class="text-muted small mb-0">Thanh toán bằng tiền mặt khi nhận hàng</p>
                                </div>
                            </div>
                            <input type="radio" name="paymentMethod" value="COD" checked style="display: none;">
                        </div>

                        <div class="payment-option" data-method="MOMO">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon bg-warning text-white">
                                    <i class="fas fa-mobile-alt"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Ví điện tử MoMo</h6>
                                    <p class="text-muted small mb-0">Thanh toán nhanh qua ứng dụng MoMo</p>
                                </div>
                            </div>
                            <input type="radio" name="paymentMethod" value="MOMO" style="display: none;">
                        </div>

                        <div class="payment-option" data-method="STRIPE">
                            <div class="d-flex align-items-center">
                                <div class="payment-icon bg-info text-white">
                                    <i class="fab fa-cc-visa"></i>
                                </div>
                                <div>
                                    <h6 class="mb-1">Thẻ tín dụng/ghi nợ</h6>
                                    <p class="text-muted small mb-0">Thanh toán an toàn qua Stripe</p>
                                </div>
                            </div>
                            <input type="radio" name="paymentMethod" value="STRIPE" style="display: none;">
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="order-summary animate__animated animate__fadeInRight">
                <h4 class="mb-4">
                    <i class="fas fa-shopping-cart me-2"></i>Tóm tắt đơn hàng
                </h4>

                <!-- Products -->
                <div class="mb-4">
                    <c:forEach var="item" items="${cart.items}">
                        <div class="product-item">
                            <c:choose>
                                <c:when test="${not empty item.productImage}">
                                    <img src="${item.productImage}" alt="${item.productNameVi}" class="product-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-image bg-light d-flex align-items-center justify-content-center">
                                        <i class="fas fa-image text-muted"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">${item.productNameVi}</h6>
                                <small class="text-white-50">SL: ${item.quantity} × <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/> đ</small>
                                <div class="fw-bold"><fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/> đ</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Summary -->
                <div class="summary-item">
                    <span>Tổng số sản phẩm:</span>
                    <span>${cart.totalItems}</span>
                </div>
                <div class="summary-item">
                    <span>Phí vận chuyển:</span>
                    <span>Miễn phí</span>
                </div>
                <div class="summary-item">
                    <span>Tổng tiền:</span>
                    <span><fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0"/> đ</span>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" form="checkoutForm" class="btn btn-checkout">
                        <i class="fas fa-shopping-bag me-2"></i>Đặt hàng ngay
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set form id for checkout button
    document.querySelector('.checkout-form').id = 'checkoutForm';

    // Payment method selection
    document.querySelectorAll('.payment-option').forEach(function(option) {
        option.addEventListener('click', function() {
            // Remove selected class from all options
            document.querySelectorAll('.payment-option').forEach(function(opt) {
                opt.classList.remove('selected');
                opt.querySelector('input[type="radio"]').checked = false;
            });

            // Add selected class to clicked option
            this.classList.add('selected');
            this.querySelector('input[type="radio"]').checked = true;
        });
    });

    // Form validation
    document.getElementById('checkoutForm').addEventListener('submit', function(e) {
        const shippingAddress = document.getElementById('shippingAddress').value.trim();
        const phone = document.getElementById('phone').value.trim();

        if (!shippingAddress) {
            e.preventDefault();
            alert('Vui lòng nhập địa chỉ giao hàng!');
            document.getElementById('shippingAddress').focus();
            return;
        }

        if (!phone) {
            e.preventDefault();
            alert('Vui lòng nhập số điện thoại!');
            document.getElementById('phone').focus();
            return;
        }

        // Show loading
        const submitBtn = document.querySelector('.btn-checkout');
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
        submitBtn.disabled = true;
    });
</script>
</body>
</html>
