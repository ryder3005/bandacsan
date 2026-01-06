<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        <c:choose>
            <c:when test="${isMyBlogs}">Bài viết của tôi</c:when>
            <c:otherwise>Blog Đặc sản Việt Nam</c:otherwise>
        </c:choose>
    </title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        /* Hero Section */
        .hero-section {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 60px 40px;
            color: white;
            text-align: center;
            margin-top: 30px;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: float 20s infinite linear;
        }

        @keyframes float {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        /* Blog Cards */
        .blog-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        .blog-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.5s;
        }

        .blog-card:hover::before {
            left: 100%;
        }

        .blog-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .blog-card .card-img-top {
            height: 200px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .blog-card:hover .card-img-top {
            transform: scale(1.1);
        }

        /* Hover Overlay */
        .hover-overlay {
            background: rgba(0,0,0,0.7);
            transition: opacity 0.3s ease;
        }

        .blog-card:hover .hover-overlay {
            opacity: 1 !important;
        }

        /* Button */
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #764ba2 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        /* Pulse */
        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        /* Search Container */
        .search-container {
            border-radius: 15px;
            border: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-section {
                padding: 40px 20px;
                margin-top: 20px;
            }
            .hero-section .display-4 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp"/>

<!-- Breadcrumb Navigation -->
<div class="container-fluid bg-light py-3 border-bottom">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="<c:url value='/'/>" class="text-decoration-none">
                        <i class="bi bi-house-door"></i> Trang chủ
                    </a>
                </li>
                <li class="breadcrumb-item">
                    <a href="<c:url value='/vendor/dashboard'/>" class="text-decoration-none">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-journal-text"></i> Blog
                </li>
            </ol>
        </nav>
    </div>
</div>

<div class="container page-transition">

    <!-- Hero Section -->
    <div class="hero-section mb-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 mx-auto">
                    <div class="d-flex justify-content-center mb-3">
                        <a href="<c:url value='/vendor/dashboard'/>" class="btn btn-outline-light btn-sm mb-3">
                            <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                        </a>
                    </div>
                    <i class="bi bi-journal-text display-4 mb-3 animate__animated animate__bounceIn"></i>
                    <h1 class="display-4 fw-bold mb-3 animate__animated animate__fadeInUp">
                        <c:choose>
                            <c:when test="${isMyBlogs}">Bài viết của tôi</c:when>
                            <c:otherwise>Blog Đặc sản Việt Nam</c:otherwise>
                        </c:choose>
                    </h1>
                    <p class="lead mb-4 animate__animated animate__fadeInUp animate__delay-1s">
                        Khám phá những câu chuyện đậm đà hương vị quê hương và văn hóa ẩm thực ba miền Bắc - Trung - Nam Việt Nam
                    </p>
                    <c:if test="${not empty sessionScope.user}">
                        <div class="d-flex justify-content-center gap-3 animate__animated animate__fadeInUp animate__delay-2s">
                            <a href="<c:url value='/vendor/blogs/create'/>" class="btn btn-light btn-lg pulse">
                                <i class="bi bi-plus-circle"></i> Viết bài mới
                            </a>
                            <c:if test="${!isMyBlogs}">
                                <a href="<c:url value='/vendor/blogs/my-blogs'/>" class="btn btn-outline-light btn-lg">
                                    <i class="bi bi-person"></i> Bài viết của tôi
                                </a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="card mb-4 search-container shadow-sm animate__animated animate__fadeInUp">
        <div class="card-body">
            <form method="GET" action="<c:url value='/vendor/blogs'/>" class="row g-3">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text bg-primary text-white">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" name="search" class="form-control"
                               placeholder="Tìm kiếm bài viết theo tiêu đề hoặc nội dung..."
                               value="${searchKeyword}">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary flex-fill">
                            <i class="bi bi-search"></i> Tìm kiếm
                        </button>
                        <c:if test="${not empty searchKeyword}">
                            <a href="<c:url value='/vendor/blogs'/>" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Blog List -->
    <c:choose>
        <c:when test="${empty blogs}">
            <div class="card text-center py-5 animate__animated animate__fadeInUp">
                <div class="card-body">
                    <i class="bi bi-journal-x display-1 text-muted mb-4"></i>
                    <h4 class="text-muted mb-3">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                Không tìm thấy bài viết nào phù hợp với "<strong>${searchKeyword}</strong>"
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${isMyBlogs}">Bạn chưa có bài viết nào</c:when>
                                    <c:otherwise>Chưa có bài viết nào</c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </h4>
                    <p class="text-muted mb-4">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">Hãy thử tìm với từ khóa khác</c:when>
                            <c:otherwise>Hãy là người đầu tiên chia sẻ kiến thức về đặc sản Việt Nam</c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${not empty sessionScope.user and empty searchKeyword}">
                        <a href="<c:url value='/vendor/blogs/create'/>" class="btn btn-primary btn-lg">
                            <i class="bi bi-plus-circle me-2"></i>
                            <c:choose>
                                <c:when test="${isMyBlogs}">Viết bài viết đầu tiên</c:when>
                                <c:otherwise>Tạo bài viết mới</c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="blog" items="${blogs}" varStatus="status">
                    <div class="col-lg-6 col-xl-4 mb-4">
                        <div class="card h-100 blog-card animate__animated animate__fadeInUp"
                             style="animation-delay: ${status.index * 0.1}s;">
                            <c:if test="${not empty blog.imageUrl}">
                                <div class="position-relative overflow-hidden">
                                    <img src="${blog.imageUrl}" class="card-img-top" alt="${blog.titleVi}">
                                    <div class="card-img-overlay d-flex align-items-center justify-content-center opacity-0 hover-overlay">
                                        <a href="<c:url value='/vendor/blogs/${blog.id}'/>" class="btn btn-primary btn-lg">
                                            <i class="bi bi-eye me-2"></i>Xem bài viết
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title fw-bold">
                                    <a href="<c:url value='/vendor/blogs/${blog.id}'/>" class="text-decoration-none text-dark stretched-link">
                                            ${blog.titleVi}
                                    </a>
                                </h5>
                                <p class="card-text text-muted small mb-3">${blog.summaryVi}</p>

                                <div class="mt-auto">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-person-circle text-primary me-1"></i>
                                            <small class="text-muted">${blog.authorName}</small>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-calendar text-secondary me-1"></i>
                                            <small class="text-muted">
                                                    ${blog.createdAt.dayOfMonth}/${blog.createdAt.monthValue}/${blog.createdAt.year}
                                            </small>
                                        </div>
                                    </div>

                                    <c:if test="${not empty blog.products}">
                                        <div class="mb-3">
                                            <span class="badge bg-primary-subtle text-primary">
                                                <i class="bi bi-tag me-1"></i>
                                                ${blog.products.size()} sản phẩm liên quan
                                            </span>
                                        </div>
                                    </c:if>

                                    <div class="d-flex gap-2">
                                        <c:if test="${sessionScope.user.id == blog.authorId}">
                                            <a href="<c:url value='/vendor/blogs/edit/${blog.id}'/>" class="btn btn-outline-secondary btn-sm flex-fill">
                                                <i class="bi bi-pencil me-1"></i>Sửa
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm"
                                                    onclick="deleteBlog(${blog.id}, '${blog.titleVi}')">
                                                <i class="bi bi-trash me-1"></i>Xóa
                                            </button>
                                        </c:if>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Delete blog confirmation
    function deleteBlog(blogId, title) {
        if (confirm(`Bạn có chắc muốn xóa bài viết "${title}"?`)) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = `<c:url value="/vendor/blogs/delete/"/>${blogId}`;

            // CSRF token (nếu project dùng Spring Security)
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = '${_csrf.parameterName}';
            csrfInput.value = '${_csrf.token}';
            form.appendChild(csrfInput);

            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>