<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container mt-4">
<!-- Hero Section -->
<div class="hero-section mb-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; padding: 60px 40px; color: white; text-align: center;">
    <div class="container">
        <h1 class="display-4 fw-bold mb-3">
            <i class="bi bi-shop"></i> Đặc sản quê hương
        </h1>
        <p class="lead mb-4">Khám phá những món đặc sản ngon nhất từ khắp mọi miền đất nước</p>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a class="btn btn-light btn-lg px-4" href="<c:url value='/user/products'/>" role="button">
                <i class="bi bi-box-seam"></i> Xem sản phẩm
            </a>
            <a class="btn btn-outline-light btn-lg px-4" href="<c:url value='/user/categories'/>" role="button">
                <i class="bi bi-tags"></i> Xem danh mục
            </a>
        </div>
    </div>
</div>

<!-- Features Section -->
<div class="row mb-5">
    <div class="col-md-4 mb-4">
        <div class="card h-100 border-0 shadow-sm">
            <div class="card-body text-center p-4">
                <div class="feature-icon mb-3" style="font-size: 3rem; color: #667eea;">
                    <i class="bi bi-truck"></i>
                </div>
                <h5 class="card-title fw-bold">Giao hàng nhanh</h5>
                <p class="card-text text-muted">Giao hàng tận nơi trong thời gian ngắn nhất, đảm bảo tươi ngon</p>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card h-100 border-0 shadow-sm">
            <div class="card-body text-center p-4">
                <div class="feature-icon mb-3" style="font-size: 3rem; color: #198754;">
                    <i class="bi bi-shield-check"></i>
                </div>
                <h5 class="card-title fw-bold">Chất lượng đảm bảo</h5>
                <p class="card-text text-muted">Sản phẩm được chọn lọc kỹ lưỡng, đảm bảo chất lượng và an toàn</p>
            </div>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card h-100 border-0 shadow-sm">
            <div class="card-body text-center p-4">
                <div class="feature-icon mb-3" style="font-size: 3rem; color: #dc3545;">
                    <i class="bi bi-heart-fill"></i>
                </div>
                <h5 class="card-title fw-bold">Đậm đà hương vị</h5>
                <p class="card-text text-muted">Giữ nguyên hương vị truyền thống, đậm đà bản sắc quê hương</p>
            </div>
        </div>
    </div>
</div>

<!-- Categories Section -->
<c:if test="${not empty categories}">
    <div class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold"><i class="bi bi-tags"></i> Danh mục sản phẩm</h2>
            <a href="<c:url value='/user/categories'/>" class="btn btn-outline-primary">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>
        <div class="row">
            <c:forEach var="category" items="${categories}" begin="0" end="5">
                <div class="col-md-4 col-lg-2 mb-3">
                    <a href="<c:url value='/user/categories'/>" class="text-decoration-none">
                        <div class="card category-card border-0 shadow-sm h-100" style="transition: transform 0.3s, box-shadow 0.3s; cursor: pointer;">
                            <div class="card-body text-center p-4">
                                <div class="category-icon mb-2" style="font-size: 2.5rem; color: #667eea;">
                                    <i class="bi bi-tag-fill"></i>
                                </div>
                                <h6 class="card-title mb-0 text-dark fw-bold">
                                    ${category.nameVi != null ? category.nameVi : 'Danh mục'}
                                </h6>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<!-- Latest Products Section -->
<c:if test="${not empty latestProducts}">
    <div class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold"><i class="bi bi-star-fill"></i> Sản phẩm mới nhất</h2>
            <a href="<c:url value='/user/products'/>" class="btn btn-outline-primary">
                Xem tất cả <i class="bi bi-arrow-right"></i>
            </a>
        </div>
        <div class="row">
            <c:forEach var="product" items="${latestProducts}">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="card product-card border-0 shadow-sm h-100" style="transition: transform 0.3s, box-shadow 0.3s; overflow: hidden;">
                        <!-- Product Image -->
                        <div style="height: 200px; overflow: hidden; background: #f8f9fa; position: relative;">
                            <c:choose>
                                <c:when test="${not empty product.imageUrls && fn:length(product.imageUrls) > 0}">
                                    <c:forEach var="imgUrl" items="${product.imageUrls}" begin="0" end="0">
                                        <img src="${imgUrl}" 
                                             class="card-img-top" 
                                             alt="${product.nameVi != null ? product.nameVi : (product.nameEn != null ? product.nameEn : 'Product')}"
                                             style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s;"
                                             onerror="this.onerror=null; this.parentElement.innerHTML='<div class=&quot;d-flex align-items-center justify-content-center h-100&quot;><i class=&quot;bi bi-image&quot; style=&quot;font-size: 3rem; color: #ccc;&quot;></i></div>';">
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex align-items-center justify-content-center h-100">
                                        <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Product Info -->
                        <div class="card-body d-flex flex-column">
                            <h6 class="card-title fw-bold mb-2" style="min-height: 48px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                ${product.nameVi != null ? product.nameVi : product.nameEn}
                            </h6>
                            
                            <c:if test="${not empty product.categories}">
                                <div class="mb-2">
                                    <c:forEach var="cat" items="${product.categories}" begin="0" end="1">
                                        <span class="badge bg-secondary me-1">${cat}</span>
                                    </c:forEach>
                                </div>
                            </c:if>
                            
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-2">
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
                                    <c:if test="${product.stock != null && product.stock > 0}">
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle"></i> Còn hàng
                                        </span>
                                    </c:if>
                                </div>
                                <a href="#" class="btn btn-primary w-100">
                                    <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>

<!-- Empty State -->
<c:if test="${empty latestProducts && empty categories}">
    <div class="text-center py-5">
        <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
        <h4 class="mt-3 text-muted">Chưa có sản phẩm nào</h4>
        <p class="text-muted">Vui lòng quay lại sau</p>
    </div>
</c:if>

<style>
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15) !important;
    }
    .product-card:hover .card-img-top {
        transform: scale(1.1);
    }
    .category-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.12) !important;
    }
    .hero-section {
        background-size: cover;
        background-position: center;
    }
</style>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
