<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Đặc sản Việt Nam - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
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
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-journal-text"></i> Blog
                </li>
            </ol>
        </nav>
    </div>
</div>

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
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
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
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            background: #fff;
        }

        .blog-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.08), transparent);
            transition: left 0.6s;
        }

        .blog-card:hover::before {
            left: 100%;
        }

        .blog-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
        }

        .blog-card .card-img-top {
            height: 220px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .blog-card:hover .card-img-top {
            transform: scale(1.08);
        }

        /* Hover Overlay */
        .hover-overlay {
            background: rgba(0,0,0,0.85);
            transition: opacity 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .blog-card:hover .hover-overlay {
            opacity: 1 !important;
        }

        /* Typography */
        .blog-card .card-title {
            font-size: 1.15rem;
            line-height: 1.4;
            margin-bottom: 0.75rem;
            font-weight: 700;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .blog-card .card-text {
            font-size: 0.92rem;
            line-height: 1.55;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 50px;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.5);
        }

        /* Badge */
        .stats-badge {
            font-size: 0.8rem;
            padding: 6px 12px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }

        /* Search */
        .search-container {
            border-radius: 20px;
            border: none;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            background: #fff;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-section {
                padding: 50px 25px;
                margin-top: 20px;
                border-radius: 15px;
            }
            .hero-section .display-4 {
                font-size: 1.9rem;
            }
            .blog-card .card-img-top {
                height: 180px;
            }
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid px-lg-4 py-4 min-vh-100">

    <!-- Hero Section -->
    <div class="hero-section mb-5 animate__animated animate__fadeInDown">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-10 mx-auto">
                    <div class="d-flex justify-content-center mb-4">
                        <a href="<c:url value='/'/>" class="btn btn-outline-light btn-sm">
                            <i class="bi bi-arrow-left"></i> Quay lại Trang chủ
                        </a>
                    </div>
                    <i class="bi bi-journal-text display-3 mb-4 animate__animated animate__bounceIn"></i>
                    <h1 class="display-4 fw-bold mb-4 animate__animated animate__fadeInUp">
                        🌟 Blog Đặc sản Việt Nam
                    </h1>
                    <p class="lead mb-5 lh-lg animate__animated animate__fadeInUp animate__delay-1s">
                        Khám phá những câu chuyện đậm đà hương vị quê hương và văn hóa ẩm thực ba miền Bắc - Trung - Nam Việt Nam
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="card mb-5 search-container shadow-lg animate__animated animate__fadeInUp">
        <div class="card-body p-4">
            <form method="GET" action="<c:url value='/user/blogs'/>" class="row g-3 align-items-end">
                <div class="col-lg-9 col-md-8">
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-gradient text-white border-0" style="min-width: 55px;">
                            <i class="bi bi-search fs-5"></i>
                        </span>
                        <input type="text" name="search" class="form-control form-control-lg border-0 shadow-none ps-0"
                               placeholder="🔍 Tìm kiếm bài viết theo tiêu đề, đặc sản, địa danh hoặc tác giả..."
                               value="${searchKeyword}" autocomplete="off">
                    </div>
                </div>
                <div class="col-lg-3 col-md-4">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary btn-lg flex-fill">
                            <i class="bi bi-search me-1"></i>Tìm ngay
                        </button>
                        <c:if test="${not empty searchKeyword}">
                            <a href="<c:url value='/user/blogs'/>" class="btn btn-outline-secondary btn-lg" title="Xóa tìm kiếm">
                                <i class="bi bi-x-lg"></i>
                            </a>
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm animate__animated animate__slideInRight mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm animate__animated animate__slideInRight mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
        </div>
    </c:if>

    <!-- Blog List -->
    <div id="blogs-section">
        <c:choose>
            <c:when test="${empty blogs}">
                <div class="text-center py-5 my-5 animate__animated animate__fadeInUp">
                    <div class="card border-0 bg-transparent shadow-none">
                        <div class="card-body p-5">
                            <i class="bi bi-journal-x display-1 text-muted mb-4 opacity-75"></i>
                            <h3 class="h2 fw-semibold text-muted mb-3">
                                <c:choose>
                                    <c:when test="${not empty searchKeyword}">
                                        <i class="bi bi-search me-2"></i>Không tìm thấy bài viết nào
                                    </c:when>
                                    <c:otherwise>📚 Chưa có bài viết nào</c:otherwise>
                                </c:choose>
                            </h3>
                            <c:if test="${not empty searchKeyword}">
                                <p class="lead text-muted mb-4">
                                    Không có kết quả cho "<strong class="text-primary">${searchKeyword}</strong>"
                                </p>
                                <p class="text-muted">Hãy thử từ khóa khác như tên đặc sản, tỉnh thành...</p>
                            </c:if>
                            <c:if test="${empty searchKeyword}">
                                <p class="lead text-muted mb-4 lh-lg">
                                    Blog đang được xây dựng. Hãy quay lại sau để khám phá những câu chuyện thú vị về đặc sản Việt Nam!
                                </p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4 mb-5">
                    <c:forEach var="blog" items="${blogs}" varStatus="status">
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
                            <article class="card h-100 blog-card animate__animated animate__fadeInUp"
                                     style="animation-delay: ${status.index * 0.1}s;">

                                <!-- Image -->
                                <c:if test="${not empty blog.imageUrl}">
                                    <div class="position-relative overflow-hidden">
                                        <img src="${blog.imageUrl}" class="card-img-top"
                                             alt="${blog.titleVi}" loading="lazy">
                                        <div class="card-img-overlay d-flex align-items-center justify-content-center opacity-0 hover-overlay">
                                            <a href="<c:url value='/user/blogs/${blog.id}'/>" class="btn btn-primary btn-lg px-4">
                                                <i class="bi bi-eye-fill me-2"></i>Đọc ngay
                                            </a>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Content -->
                                <div class="card-body d-flex flex-column p-4">
                                    <h2 class="card-title h5 mb-3">
                                        <a href="<c:url value='/user/blogs/${blog.id}'/>"
                                           class="text-decoration-none text-dark stretched-link">
                                                ${blog.titleVi}
                                        </a>
                                    </h2>

                                    <p class="card-text text-muted flex-grow-1 mb-3">${blog.summaryVi}</p>

                                    <!-- Meta -->
                                    <div class="d-flex justify-content-between align-items-end mb-3 text-small">
                                        <div class="d-flex align-items-center gap-2">
                                            <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center"
                                                 style="width: 32px; height: 32px; font-size: 0.8rem; font-weight: 600;">
                                                    ${not empty blog.authorName ? blog.authorName.substring(0,1).toUpperCase() : '👤'}
                                            </div>
                                            <div>
                                                <div class="fw-semibold text-dark small">${blog.authorName}</div>
                                                <div class="text-muted" style="font-size: 0.75rem;">
                                                    <i class="bi bi-calendar3 me-1"></i>
                                                        ${blog.createdAt.dayOfMonth}/${blog.createdAt.monthValue}/${blog.createdAt.year}
                                                </div>
                                            </div>
                                        </div>

                                        <c:if test="${not empty blog.products and blog.products.size() > 0}">
                                            <span class="stats-badge bg-primary-subtle text-primary border border-primary-subtle">
                                                🛒 ${blog.products.size()} sản phẩm
                                            </span>
                                        </c:if>
                                    </div>

                                    <!-- CTA -->
                                    <div class="mt-auto">
                                        <a href="<c:url value='/user/blogs/${blog.id}'/>" class="btn btn-outline-primary btn-sm w-100">
                                            <i class="bi bi-arrow-right me-2"></i>Đọc chi tiết
                                        </a>
                                    </div>
                                </div>
                            </article>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Delete blog confirmation
function deleteBlog(blogId, title) {
    if (confirm(`Bạn có chắc muốn xóa bài viết "${title}"?`)) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `<c:url value="/user/blogs/delete/"/>${blogId}`;

        // Add CSRF token if needed
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
