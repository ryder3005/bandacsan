<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<section class="checkout-header">
    <%-- [cite: 29] --%>
    <div class="container text-center">
        <h1>Thanh toán đơn hàng</h1>
    </div>
</section>

<div class="container">
    <c:if test="${not empty error}">
        <%-- [cite: 30] --%>
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row">
        <div class="col-lg-8">
            <%-- Form nhập liệu [cite: 31-50] --%>
            <form id="checkoutForm" class="checkout-form">
                <div class="form-section">
                    <h3 class="section-title">Thông tin giao hàng</h3>
                    <div class="mb-3">
                        <label class="form-label">Địa chỉ *</label>
                        <textarea class="form-control" id="shippingAddress" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số điện thoại *</label>
                        <input type="tel" class="form-control" id="phone" required>
                    </div>
                </div>

                <div class="form-section">
                    <h3 class="section-title">Phương thức thanh toán</h3>
                    <div class="payment-option selected" data-method="COD">
                        <input type="radio" name="paymentMethod" value="COD" id="paymentCOD" checked>
                        <label for="paymentCOD" style="cursor: pointer; margin-left: 10px; margin-bottom: 0;">COD - Thanh toán khi nhận hàng</label>
                    </div>
                    <div class="payment-option" data-method="MOMO">
                        <input type="radio" name="paymentMethod" value="MOMO" id="paymentMOMO">
                        <label for="paymentMOMO" style="cursor: pointer; margin-left: 10px; margin-bottom: 0;">MoMo - Thanh toán online</label>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-lg-4">
            <div class="order-summary">
                <h4>Tóm tắt đơn hàng</h4>
                <div class="mb-4">
                    <%-- Tìm và thay thế đoạn hiển thị danh sách sản phẩm (Dòng ~52 trong file của bạn) --%>
                    <c:forEach var="item" items="${cart.items}" >
                        <div class="product-item d-flex align-items-center mb-3 pb-3 border-bottom">
                            <div class="product-info-wrapper d-flex align-items-center flex-grow-1">
                                <c:choose>
                                    <%-- SỬA: Thay item.imageUrls bằng item.productImage --%>
                                    <c:when test="${not empty item.productImage}">
                                        <img src="<c:url value='/files/${item.productImage}'/>"
                                             alt="${item.productNameVi}"
                                             class="product-image"
                                             style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-image bg-light d-flex align-items-center justify-content-center"
                                             style="width: 60px; height: 60px; border-radius: 8px;">
                                            <i class="fas fa-image text-muted"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="ms-3">
                                    <h6 class="mb-0 text-truncate" style="max-width: 200px;">${item.productNameVi}</h6>
                                        <%-- SỬA: Đảm bảo dùng đúng productPrice --%>
                                    <small class="text-muted">
                                        Số lượng: ${item.quantity} × <fmt:formatNumber value="${item.productPrice}" pattern="#,##0"/>đ
                                    </small>
                                </div>
                            </div>
                            <div class="text-end">
                                    <%-- SỬA: Dùng subtotal từ DTO --%>
                                <span class="fw-bold text-primary">
                <fmt:formatNumber value="${item.subtotal}" pattern="#,##0"/>đ
            </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="summary-item"><span>Tổng tiền:</span> <span><fmt:formatNumber value="${cart.totalPrice}" pattern="#,##0"/> đ</span></div>
                <button type="button" onclick="handleCheckout()" class="btn btn-checkout w-100 mt-3">Đặt hàng ngay</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý click vào payment option
    document.addEventListener('DOMContentLoaded', function() {
        const paymentOptions = document.querySelectorAll('.payment-option');
        
        paymentOptions.forEach(function(option) {
            option.addEventListener('click', function() {
                // Xóa class selected khỏi tất cả options
                paymentOptions.forEach(function(opt) {
                    opt.classList.remove('selected');
                });
                
                // Thêm class selected cho option được click
                this.classList.add('selected');
                
                // Chọn radio button tương ứng
                const radio = this.querySelector('input[type="radio"]');
                if (radio) {
                    radio.checked = true;
                }
            });
        });
    });

    async function handleCheckout() {
        const shippingAddress = document.getElementById('shippingAddress').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

        if (!shippingAddress || !phone) {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return;
        }

        const checkoutData = { shippingAddress, phone, paymentMethod };

        try {
            const response = await fetch('<c:url value="/user/checkout"/>', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(checkoutData)
            });

            if (response.ok) {
                const data = await response.json();
                if (data.payUrl) window.location.href = data.payUrl;
                else window.location.href = '<c:url value="/user/orders"/>';
            } else {
                alert('Lỗi khi đặt hàng');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }
</script>
</body>
</html>
