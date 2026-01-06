<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá của tôi - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        .reviews-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .review-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .review-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 20px;
        }

        .stars {
            color: #ffd700;
            font-size: 1.2rem;
        }

        .star {
            color: #ddd;
        }

        .star.active {
            color: #ffd700;
        }

        .review-content {
            padding: 20px;
        }

        .review-text {
            font-size: 1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 15px;
        }

        .review-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            color: #666;
        }

        .product-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .product-link:hover {
            text-decoration: underline;
        }

        .empty-reviews {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            margin: 40px 0;
        }

        .empty-reviews i {
            font-size: 5rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
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

<!-- Reviews Header -->
<section class="reviews-header">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="animate__animated animate__fadeInDown">
                    <i class="fas fa-star me-3"></i>Đánh giá của tôi
                </h1>
                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                    Xem tất cả đánh giá và nhận xét của bạn về các sản phẩm
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

    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stats-card animate__animated animate__fadeInUp">
                <div class="stat-number">${reviews != null ? reviews.size() : 0}</div>
                <div class="stat-label">Tổng đánh giá</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card animate__animated animate__fadeInUp animate__delay-1s">
                <div class="stat-number">
                    <c:set var="totalStars" value="0"/>
                    <c:set var="count" value="0"/>
                    <c:forEach var="review" items="${reviews}">
                        <c:set var="totalStars" value="${totalStars + review.stars}"/>
                        <c:set var="count" value="${count + 1}"/>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${count > 0}">
                            <fmt:formatNumber value="${totalStars / count}" pattern="0.0"/>
                        </c:when>
                        <c:otherwise>0.0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Điểm trung bình</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card animate__animated animate__fadeInUp animate__delay-2s">
                <div class="stat-number">
                    <c:set var="fiveStarCount" value="0"/>
                    <c:forEach var="review" items="${reviews}">
                        <c:if test="${review.stars == 5}">
                            <c:set var="fiveStarCount" value="${fiveStarCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${fiveStarCount}
                </div>
                <div class="stat-label">Đánh giá 5 sao</div>
            </div>
        </div>
    </div>

    <!-- Reviews List -->
    <c:choose>
        <c:when test="${not empty reviews}">
            <div class="row">
                <div class="col-12">
                    <h4 class="mb-3"><i class="fas fa-list me-2"></i>Các đánh giá của bạn</h4>
                </div>
            </div>
            <c:forEach var="review" items="${reviews}" varStatus="status">
                <div class="review-card animate__animated animate__fadeInUp" style="animation-delay: ${status.index * 0.1}s">
                    <div class="review-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-1">${review.productName}</h5>
                                <div class="stars">
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= review.stars}">
                                                <i class="fas fa-star"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <span class="ms-2">${review.stars}/5</span>
                                </div>
                            </div>
                            <div class="text-end">
                                <small>
                                    <c:choose>
                                        <c:when test="${not empty review.createdAt}">
                                            ${fn:substring(review.createdAt.toString(), 0, 10)}
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                    </div>

                    <div class="review-content">
                        <c:if test="${not empty review.commentVi}">
                            <p class="review-text">${review.commentVi}</p>
                        </c:if>
                        <c:if test="${not empty review.commentEn and review.commentEn != review.commentVi}">
                            <p class="review-text text-muted">${review.commentEn}</p>
                        </c:if>

                        <div class="review-meta">
                            <span>
                                <a href="<c:url value='/user/products/${review.productId}'/>" class="product-link">
                                    <i class="fas fa-external-link-alt me-1"></i>Xem sản phẩm
                                </a>
                            </span>
                            <span>
                                <i class="fas fa-clock me-1"></i>
                                <c:choose>
                                    <c:when test="${not empty review.createdAt}">
                                        ${fn:substring(review.createdAt.toString(), 11, 16)} ${fn:substring(review.createdAt.toString(), 0, 10)}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-reviews animate__animated animate__fadeInUp">
                <i class="fas fa-star-half-alt"></i>
                <h3>Bạn chưa có đánh giá nào</h3>
                <p class="text-muted">Hãy mua hàng và để lại đánh giá cho sản phẩm bạn đã sử dụng</p>
                <a href="<c:url value='/user/products'/>" class="btn btn-primary btn-lg">
                    <i class="fas fa-shopping-cart me-2"></i>Mua hàng ngay
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
