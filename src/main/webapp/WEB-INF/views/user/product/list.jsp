<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tất cả Sản phẩm - Đặc sản quê hương</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
            </head>

            <body>
                <jsp:include page="/WEB-INF/common/header.jsp" />
                <div class="container-fluid mt-4">
                    <h1 class="mb-4">
                        <i class="bi bi-box-seam"></i>
                        <c:choose>
                            <c:when test="${not empty selectedCategory}">
                                Sản phẩm: ${selectedCategory.nameVi}
                            </c:when>
                            <c:otherwise>
                                Tất cả Sản phẩm
                            </c:otherwise>
                        </c:choose>
                    </h1>

                    <!-- Filter by Category -->
                    <c:if test="${not empty categories}">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h6 class="mb-3"><i class="bi bi-funnel"></i> Lọc theo danh mục:</h6>
                                <div class="d-flex flex-wrap gap-2">
                                    <a href="<c:url value='/user/products'/>"
                                        class="btn ${empty selectedCategory ? 'btn-primary' : 'btn-outline-primary'}">
                                        Tất cả
                                    </a>
                                    <c:forEach var="category" items="${categories}">
                                        <a href="<c:url value='/user/products?categoryId=${category.id}'/>"
                                            class="btn ${selectedCategory != null && selectedCategory.id == category.id ? 'btn-primary' : 'btn-outline-primary'}">
                                            ${category.nameVi}
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Stats Card -->
                    <div class="row mb-4">
                        <div class="col-md-12 mb-3">
                            <div class="card text-white bg-primary">
                                <div class="card-body">
                                    <h5 class="card-title"><i class="bi bi-box-seam"></i> Tổng số sản phẩm</h5>
                                    <h3 class="mb-0">${not empty products ? fn:length(products) : 0}</h3>
                                    <small>
                                        <c:choose>
                                            <c:when test="${not empty selectedCategory}">
                                                Sản phẩm trong danh mục "${selectedCategory.nameVi}"
                                            </c:when>
                                            <c:otherwise>
                                                Tổng số sản phẩm trong hệ thống
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <div class="card mb-4">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0"><i class="bi bi-box-seam"></i> Danh sách sản phẩm</h5>
                                    <div>
                                        <a href="<c:url value='/user/home'/>" class="btn btn-outline-primary">
                                            <i class="bi bi-house"></i> Về trang chủ
                                        </a>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <!-- Bảng danh sách -->
                                    <c:choose>
                                        <c:when test="${empty products}">
                                            <div class="text-center text-muted py-5">
                                                <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                                <h4 class="mt-3 text-muted">Chưa có sản phẩm</h4>
                                                <p class="text-muted">Chưa có sản phẩm nào trong hệ thống.</p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row">
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-md-6 col-lg-3 mb-4">
                                                        <div class="card product-card border-0 shadow-sm h-100"
                                                            style="transition: transform 0.3s, box-shadow 0.3s; overflow: hidden;">
                                                            <!-- Product Image -->
                                                            <div
                                                                style="height: 200px; overflow: hidden; background: #f8f9fa; position: relative;">
                                                                <c:choose>
                                                                    <c:when test="${not empty product.productImage}">
                                                                        <img src="<c:url value='/files/${product.productImage}'/>"
                                                                            class="card-img-top" alt="${product.nameVi}"
                                                                            style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div
                                                                            class="d-flex align-items-center justify-content-center h-100">
                                                                            <i class="bi bi-image"
                                                                                style="font-size: 3rem; color: #ccc;"></i>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <!-- Product Info -->
                                                            <div class="card-body d-flex flex-column">
                                                                <h6 class="card-title fw-bold mb-2"
                                                                    style="min-height: 48px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                                                    ${product.nameVi != null ? product.nameVi :
                                                                    product.nameEn}
                                                                </h6>

                                                                <c:if test="${not empty product.categories}">
                                                                    <div class="mb-2">
                                                                        <c:forEach var="cat"
                                                                            items="${product.categories}" begin="0"
                                                                            end="1">
                                                                            <span
                                                                                class="badge bg-secondary me-1">${cat}</span>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>

                                                                <div class="mt-auto">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mb-2">
                                                                        <span class="text-danger fw-bold fs-5">
                                                                            <c:choose>
                                                                                <c:when test="${product.price != null}">
                                                                                    ${product.price} đ
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    Liên hệ
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </span>
                                                                        <c:if
                                                                            test="${product.stock != null && product.stock > 0}">
                                                                            <span class="badge bg-success">
                                                                                <i class="bi bi-check-circle"></i> Còn
                                                                                hàng
                                                                            </span>
                                                                        </c:if>
                                                                    </div>
                                                                    <div class="d-flex gap-2">
                                                                        <%-- Nút thêm vào giỏ hàng dùng AJAX --%>
                                                                            <button type="button"
                                                                                onclick="addToCart(${product.id})"
                                                                                class="btn btn-primary flex-fill">
                                                                                <i class="bi bi-cart-plus"></i> Thêm vào
                                                                                giỏ
                                                                            </button>

                                                                            <a href="<c:url value='/user/chat/start/${product.vendorId}'/>"
                                                                                class="btn btn-outline-success"
                                                                                style="width: 50px;"
                                                                                title="Chat với người bán">
                                                                                <i class="fas fa-comments"></i>
                                                                            </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <style>
                    .product-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15) !important;
                    }

                    .product-card:hover .card-img-top {
                        transform: scale(1.1);
                    }
                </style>

                <jsp:include page="/WEB-INF/common/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    async function addToCart(productId) {
                        // Lấy CSRF token nếu bạn dùng Spring Security
                        const csrfToken = document.querySelector('input[name="_csrf"]')?.value;

                        try {
                            const response = await fetch('<c:url value="/user/cart/add"/>', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    ...(csrfToken && { 'X-CSRF-TOKEN': csrfToken })
                                },
                                body: JSON.stringify({
                                    productId: productId,
                                    quantity: 1
                                })
                            });

                            if (response.ok) {
                                // Hiển thị thông báo thành công (có thể thay bằng Toast của Bootstrap)
                                alert('Đã thêm sản phẩm vào giỏ hàng!');

                                // Cập nhật số lượng trên icon giỏ hàng
                                if (typeof updateCartBadge === 'function') {
                                    updateCartBadge();
                                }
                            } else if (response.status === 401) {
                                alert('Vui lòng đăng nhập để thực hiện chức năng này!');
                                window.location.href = '<c:url value="/login"/>';
                            } else {
                                const text = await response.text();
                                alert('Có lỗi xảy ra: ' + text);
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            alert('Không thể kết nối tới máy chủ.');
                        }
                    }
                </script>
                <jsp:include page="/WEB-INF/common/floating-widgets.jsp" />
            </body>

            </html>