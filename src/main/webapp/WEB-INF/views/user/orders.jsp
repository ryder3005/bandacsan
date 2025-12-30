<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        /* Star Rating in Modal */
        .rating-stars {
            display: flex;
            gap: 5px;
            margin-bottom: 10px;
        }

        .rating-stars .star {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .rating-stars .star.active {
            color: #ffd700;
            transform: scale(1.1);
        }

        .rating-stars .star:hover {
            color: #ffd700;
            transform: scale(1.1);
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
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show animate__animated animate__fadeInDown" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Filter Tabs -->
    <div class="filter-tabs animate__animated animate__fadeInUp">
        <div class="d-flex justify-content-center">
            <button class="filter-tab active" onclick="filterOrders('all')">Tất cả</button>
            <button class="filter-tab" onclick="filterOrders('PENDING')">Chờ xử lý</button>
            <button class="filter-tab" onclick="filterOrders('PROCESSING')">Đang xử lý</button>
            <button class="filter-tab" onclick="filterOrders('SHIPPING')">Đang giao</button>
            <button class="filter-tab" onclick="filterOrders('DELIVERED')">Đã giao</button>
        </div>
    </div>

    <!-- Orders List -->
    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}" varStatus="status">
                <div class="order-card animate__animated animate__fadeInUp" style="animation-delay: ${status.index * 0.1}s" data-status="${order.status}">
                    <div class="order-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-1">Đơn hàng #${order.id}</h5>
                                <small>Ngày đặt: <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                            </div>
                            <div class="text-end">
                                <span class="order-status status-${order.status.name().toLowerCase()}">${order.status.name()}</span>
                                <div class="mt-2 d-flex gap-2">
                                    <a href="<c:url value='/user/orders/${order.id}'/>" class="btn btn-view-detail btn-sm">
                                        <i class="fas fa-eye me-1"></i>Xem chi tiết
                                    </a>
                                    <c:if test="${order.status == 'DELIVERED'}">
                                        <button class="btn btn-warning btn-sm" onclick="openReviewModal(${order.id})">
                                            <i class="fas fa-star me-1"></i>Đánh giá
                                        </button>
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
                                            <img src="${item.productImage}" alt="${item.productNameVi}" class="product-image me-3">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-image bg-light d-flex align-items-center justify-content-center me-3">
                                                <i class="fas fa-image text-muted"></i>
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

                        <c:if test="${order.items.size() > 2}">
                            <div class="order-item text-center">
                                <small class="text-muted">và ${order.items.size() - 2} sản phẩm khác...</small>
                            </div>
                        </c:if>
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

<!-- Review Modal -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">
                    <i class="fas fa-star text-warning me-2"></i>Đánh giá sản phẩm
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="reviewForm" method="post" action="<c:url value='/user/reviews/create'/>">
                <div class="modal-body">
                    <input type="hidden" id="reviewOrderId" name="orderId">

                    <div class="mb-3">
                        <label class="form-label">Chọn sản phẩm để đánh giá:</label>
                        <select class="form-select" id="reviewProductId" name="productId" required>
                            <option value="">-- Chọn sản phẩm --</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Đánh giá (1-5 sao):</label>
                        <div class="rating-stars">
                            <i class="fas fa-star star" data-rating="1"></i>
                            <i class="fas fa-star star" data-rating="2"></i>
                            <i class="fas fa-star star" data-rating="3"></i>
                            <i class="fas fa-star star" data-rating="4"></i>
                            <i class="fas fa-star star" data-rating="5"></i>
                            <input type="hidden" id="reviewStars" name="stars" value="0" required>
                        </div>
                        <small class="text-muted">Click vào sao để đánh giá</small>
                    </div>

                    <div class="mb-3">
                        <label for="reviewCommentVi" class="form-label">Nhận xét (Tiếng Việt):</label>
                        <textarea class="form-control" id="reviewCommentVi" name="commentVi" rows="3"
                                placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="reviewCommentEn" class="form-label">Review (English - tùy chọn):</label>
                        <textarea class="form-control" id="reviewCommentEn" name="commentEn" rows="2"
                                placeholder="Share your experience in English..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Hủy
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-1"></i>Gửi đánh giá
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let currentOrderId = null;

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

    function openReviewModal(orderId) {
        currentOrderId = orderId;
        document.getElementById('reviewOrderId').value = orderId;

        // Load products from this order
        fetch('<c:url value="/user/orders/"/>' + orderId + '/products')
            .then(response => response.json())
            .then(products => {
                const select = document.getElementById('reviewProductId');
                select.innerHTML = '<option value="">-- Chọn sản phẩm --</option>';

                products.forEach(product => {
                    const option = document.createElement('option');
                    option.value = product.id;
                    option.textContent = product.nameVi;
                    select.appendChild(option);
                });

                // Show modal
                const modal = new bootstrap.Modal(document.getElementById('reviewModal'));
                modal.show();
            })
            .catch(error => {
                console.error('Error loading products:', error);
                alert('Không thể tải danh sách sản phẩm');
            });
    }

    // Star rating functionality
    document.querySelectorAll('.star').forEach(star => {
        star.addEventListener('click', function() {
            const rating = this.getAttribute('data-rating');
            document.getElementById('reviewStars').value = rating;

            // Update star display
            document.querySelectorAll('.star').forEach(s => {
                if (s.getAttribute('data-rating') <= rating) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
        });
    });

    // Add loading effect to links
    document.querySelectorAll('a[href*="/user/orders/"]').forEach(link => {
        link.addEventListener('click', function() {
            const btn = this;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang tải...';
            btn.disabled = true;
        });
    });

    // Handle review form submission
    document.getElementById('reviewForm').addEventListener('submit', function(e) {
        const stars = document.getElementById('reviewStars').value;
        if (stars === '0') {
            e.preventDefault();
            alert('Vui lòng chọn số sao đánh giá!');
            return;
        }

        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang gửi...';
        submitBtn.disabled = true;
    });
</script>
</body>
</html>
