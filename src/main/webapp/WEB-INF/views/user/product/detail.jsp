<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${product.nameVi} - Chi tiết sản phẩm</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <style>
                    /* Animation cho thêm vào giỏ hàng */
                    @keyframes flyToCart {
                        0% {
                            transform: scale(1) translate(0, 0);
                            opacity: 1;
                        }

                        50% {
                            transform: scale(0.5) translate(var(--fly-x), var(--fly-y));
                            opacity: 0.8;
                        }

                        100% {
                            transform: scale(0.3) translate(var(--fly-x), var(--fly-y));
                            opacity: 0;
                        }
                    }

                    @keyframes bounce {

                        0%,
                        100% {
                            transform: scale(1);
                        }

                        50% {
                            transform: scale(1.2);
                        }
                    }

                    @keyframes pulse {

                        0%,
                        100% {
                            transform: scale(1);
                            box-shadow: 0 0 0 0 rgba(40, 167, 69, 0.7);
                        }

                        50% {
                            transform: scale(1.05);
                            box-shadow: 0 0 0 10px rgba(40, 167, 69, 0);
                        }
                    }

                    .cart-icon-flying {
                        position: fixed;
                        z-index: 9999;
                        font-size: 2rem;
                        color: #28a745;
                        pointer-events: none;
                        animation: flyToCart 0.8s ease-in-out forwards;
                    }

                    .btn.adding {
                        pointer-events: none;
                        opacity: 0.7;
                    }

                    .btn.success {
                        animation: pulse 0.5s ease-in-out;
                    }

                    .cart-icon-animate {
                        animation: bounce 0.5s ease-in-out;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/common/header.jsp" />

                <div class="container my-4">
                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<c:url value='/user/home'/>">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="<c:url value='/user/products'/>">Sản phẩm</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${product.nameVi}</li>
                        </ol>
                    </nav>

                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <div class="ratio ratio-4x3 mb-3">
                                        <c:choose>
                                            <c:when test="${not empty product.imageUrls}">
                                                <img src="<c:url value='/files/${product.imageUrls[0]}'/>"
                                                    class="img-fluid rounded" alt="${product.nameVi}"
                                                    style="object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div
                                                    class="d-flex align-items-center justify-content-center bg-light rounded">
                                                    <i class="bi bi-image text-muted" style="font-size: 3rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <c:if test="${not empty product.imageUrls && product.imageUrls.size() > 1}">
                                        <div class="d-flex gap-2 flex-wrap">
                                            <c:forEach var="img" items="${product.imageUrls}" begin="0">
                                                <img src="<c:url value='/files/${img}'/>" class="rounded border"
                                                    style="width: 80px; height: 80px; object-fit: cover;" alt="thumb">
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <h3 class="fw-bold mb-2">${product.nameVi}</h3>
                                    <c:if test="${not empty product.nameEn}">
                                        <p class="text-muted fst-italic mb-2">${product.nameEn}</p>
                                    </c:if>

                                    <div class="d-flex align-items-center gap-3 mb-3">
                                        <span class="fs-4 text-danger fw-bold">
                                            <c:choose>
                                                <c:when test="${product.price != null}">
                                                    <fmt:formatNumber value="${product.price}" pattern="#,##0" /> ₫
                                                </c:when>
                                                <c:otherwise>Liên hệ</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <c:if test="${product.stock != null}">
                                            <span class="badge ${product.stock > 0 ? 'bg-success' : 'bg-secondary'}">
                                                <i class="bi bi-box-seam"></i>
                                                ${product.stock > 0 ? 'Còn hàng' : 'Hết hàng'}
                                            </span>
                                        </c:if>
                                    </div>

                                    <c:if test="${not empty product.categories}">
                                        <div class="mb-3">
                                            <c:forEach var="cat" items="${product.categories}">
                                                <span class="badge bg-light text-primary border me-1">${cat}</span>
                                            </c:forEach>
                                        </div>
                                    </c:if>

                                    <p class="mb-3" style="white-space: pre-line;">${product.descriptionVi}</p>
                                    <c:if test="${not empty product.descriptionEn}">
                                        <p class="text-muted fst-italic" style="white-space: pre-line;">
                                            ${product.descriptionEn}</p>
                                    </c:if>

                                    <div class="d-flex align-items-center gap-3 mb-4">
                                        <div class="input-group" style="width: 140px;">
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="decreaseQuantity()">
                                                <i class="bi bi-dash"></i>
                                            </button>
                                            <input type="number" class="form-control text-center" id="quantity"
                                                value="1" min="1" max="${product.stock != null ? product.stock : 1}">
                                            <button class="btn btn-outline-secondary" type="button"
                                                onclick="increaseQuantity()">
                                                <i class="bi bi-plus"></i>
                                            </button>
                                        </div>
                                        <button class="btn btn-primary btn-lg flex-fill add-to-cart-btn"
                                            onclick="addToCart(${product.id})">
                                            <i class="bi bi-cart-plus me-2"></i> Thêm vào giỏ
                                        </button>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <a href="<c:url value='/user/chat/start/${product.vendorId}'/>"
                                            class="btn btn-outline-success">
                                            <i class="bi bi-chat-dots"></i> Chat với người bán
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-lg-8">
                            <div class="card shadow-sm mb-4">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="mb-0"><i class="bi bi-journal-text me-2"></i>Blog liên quan</h5>
                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty blogs}">
                                            <p class="text-muted mb-0">Chưa có blog nào liên kết với sản phẩm này.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="list-group">
                                                <c:forEach var="blog" items="${blogs}">
                                                    <a class="list-group-item list-group-item-action d-flex gap-3 align-items-start"
                                                        href="<c:url value='/user/blogs/${blog.id}'/>">
                                                        <div>
                                                            <h6 class="mb-1 fw-bold">${blog.titleVi}</h6>
                                                            <p class="mb-1 text-muted">${blog.summaryVi}</p>
                                                            <small class="text-secondary">
                                                                <i class="bi bi-person"></i> ${blog.authorName}
                                                                &nbsp;•&nbsp;
                                                                <i class="bi bi-calendar"></i>
                                                                ${blog.createdAt.dayOfMonth}/${blog.createdAt.monthValue}/${blog.createdAt.year}
                                                            </small>
                                                        </div>
                                                    </a>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="card shadow-sm">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0"><i class="bi bi-shop me-2"></i>Thông tin người bán</h6>
                                </div>
                                <div class="card-body">
                                    <p class="mb-1 fw-bold">${product.vendorName}</p>
                                    <p class="text-muted mb-0">Mã người bán: ${product.vendorId}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/common/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>

                    function decreaseQuantity() {
                        const input = document.getElementById('quantity');
                        if (parseInt(input.value) > 1) {
                            input.value = parseInt(input.value) - 1;
                        }
                    }

                    function increaseQuantity() {
                        const input = document.getElementById('quantity');
                        const max = parseInt(input.getAttribute('max')) || 999;
                        if (parseInt(input.value) < max) {
                            input.value = parseInt(input.value) + 1;
                        }
                    }

                    async function addToCart(productId) {
                        const button = event.target.closest('button');
                        if (!button) return;

                        const quantityInput = document.getElementById('quantity');
                        const quantity = quantityInput ? parseInt(quantityInput.value) : 1;

                        // Disable button và thêm class adding
                        button.classList.add('adding');
                        const originalText = button.innerHTML;
                        button.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang thêm...';

                        // Lấy vị trí của nút và icon giỏ hàng
                        const buttonRect = button.getBoundingClientRect();
                        const cartIcon = document.querySelector('.cart-icon, .bi-cart, [class*="cart"]');
                        let cartRect = { left: window.innerWidth - 100, top: 20 };

                        if (cartIcon) {
                            cartRect = cartIcon.getBoundingClientRect();
                        }

                        // Tính toán vị trí bay
                        const flyX = cartRect.left - buttonRect.left;
                        const flyY = cartRect.top - buttonRect.top;

                        // Tạo icon bay
                        const flyingIcon = document.createElement('i');
                        flyingIcon.className = 'bi bi-cart-plus cart-icon-flying';
                        flyingIcon.style.left = buttonRect.left + buttonRect.width / 2 + 'px';
                        flyingIcon.style.top = buttonRect.top + buttonRect.height / 2 + 'px';
                        flyingIcon.style.setProperty('--fly-x', flyX + 'px');
                        flyingIcon.style.setProperty('--fly-y', flyY + 'px');
                        document.body.appendChild(flyingIcon);

                        const cartData = {
                            productId: parseInt(productId),
                            quantity: quantity
                        };

                        const csrfToken = document.querySelector('input[name="_csrf"]')?.value;
                        var headers = {
                            'Content-Type': 'application/json'
                        };
                        if (csrfToken) {
                            headers['X-CSRF-TOKEN'] = csrfToken;
                        }

                        // Determine cart endpoint based on user role
                        const userRole = '<c:out value="${sessionScope.user != null ? sessionScope.user.role : ''}" />';
                        const cartEndpoint = userRole === 'VENDOR' ? '<c:url value="/vendor/cart/add" />' : '<c:url value="/user/cart/add" />';

                        try {
                            const response = await fetch(cartEndpoint, {
                                method: 'POST',
                                headers: headers,
                                body: JSON.stringify(cartData)
                            });

                            if (response.ok) {
                                // Xóa icon bay sau animation
                                setTimeout(() => {
                                    flyingIcon.remove();
                                }, 800);

                                // Hiệu ứng thành công trên nút
                                button.classList.remove('adding');
                                button.classList.add('success');
                                button.innerHTML = '<i class="bi bi-check-circle"></i> Đã thêm!';
                                button.classList.add('btn-success');

                                // Hiệu ứng bounce trên icon giỏ hàng
                                if (cartIcon) {
                                    cartIcon.classList.add('cart-icon-animate');
                                    setTimeout(() => {
                                        cartIcon.classList.remove('cart-icon-animate');
                                    }, 500);
                                }

                                // Khôi phục nút sau 1.5s
                                setTimeout(() => {
                                    button.innerHTML = originalText;
                                    button.classList.remove('btn-success');
                                    button.classList.remove('success');
                                }, 1500);

                                // Cập nhật badge giỏ hàng nếu có
                                if (typeof updateCartBadge === 'function') {
                                    updateCartBadge();
                                }
                            } else if (response.status === 401) {
                                flyingIcon.remove();
                                button.classList.remove('adding');
                                button.innerHTML = originalText;
                                alert('Vui lòng đăng nhập để thực hiện chức năng này!');
                                setTimeout(() => {
                                    window.location.href = '<c:url value="/login"/>';
                                }, 1000);
                            } else {
                                flyingIcon.remove();
                                button.classList.remove('adding');
                                const errorText = await response.text();
                                alert('Lỗi: ' + errorText);
                                button.innerHTML = originalText;
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            flyingIcon.remove();
                            button.classList.remove('adding');
                            alert('Có lỗi xảy ra khi thêm vào giỏ hàng');
                            button.innerHTML = originalText;
                        }
                    }
                </script>
            </body>

            </html>