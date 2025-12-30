<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Hero Section with Blog Title -->
<div class="hero-section mb-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; padding: 80px 40px; color: white; text-align: center; margin-top: 30px; position: relative; overflow: hidden;">
    <div class="hero-pattern"></div>
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 mx-auto">
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb justify-content-center bg-transparent p-0 m-0">
                        <li class="breadcrumb-item">
                            <a href="<c:url value='/user/blogs'/>" class="text-white-50">Blog</a>
                        </li>
                        <li class="breadcrumb-item active text-white">${blog.titleVi}</li>
                    </ol>
                </nav>
                <h1 class="display-4 fw-bold mb-3 animate__animated animate__fadeInUp">${blog.titleVi}</h1>
                <p class="lead mb-4 animate__animated animate__fadeInUp animate__delay-1s">${blog.summaryVi}</p>
                <div class="d-flex justify-content-center align-items-center gap-4 animate__animated animate__fadeInUp animate__delay-2s">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-circle me-2"></i>
                        <span>${blog.authorName}</span>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="bi bi-calendar me-2"></i>
                        <span><fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy"/></span>
                    </div>
                    <c:if test="${blog.updatedAt != null and blog.updatedAt != blog.createdAt}">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-pencil me-2"></i>
                            <span>Cập nhật: <fmt:formatDate value="${blog.updatedAt}" pattern="dd/MM/yyyy"/></span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container page-transition">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__slideInRight" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8">
            <article class="blog-post animate__animated animate__fadeInUp">
                <!-- Blog Image -->
                <c:if test="${not empty blog.imageUrl}">
                    <div class="mb-5">
                        <div class="blog-image-container">
                            <img src="${blog.imageUrl}" class="img-fluid rounded shadow-lg" alt="${blog.titleVi}"
                                 style="width: 100%; max-height: 500px; object-fit: cover;">
                            <div class="image-overlay"></div>
                        </div>
                    </div>
                </c:if>

                <!-- Blog Content -->
                <div class="blog-content mb-5">
                    <div class="content-wrapper p-4 bg-white rounded shadow-sm">
                        ${blog.contentVi}
                    </div>
                </div>
            </article>

            <!-- Related Products -->
            <c:if test="${not empty blog.products}">
                <div class="card mb-4 shadow-sm animate__animated animate__fadeInUp animate__delay-1s">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-tag-fill me-2"></i>
                            Sản phẩm liên quan (${blog.products.size()})
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <c:forEach var="product" items="${blog.products}">
                                <div class="col-12">
                                    <div class="product-item d-flex align-items-center p-3 border rounded hover-lift">
                                        <div class="product-image me-3">
                                            <c:if test="${not empty product.imageUrls && product.imageUrls.size() > 0}">
                                                <img src="${product.imageUrls[0]}" alt="${product.nameVi}"
                                                     class="rounded" style="width: 60px; height: 60px; object-fit: cover;">
                                            </c:if>
                                            <c:if test="${empty product.imageUrls || product.imageUrls.size() == 0}">
                                                <div class="bg-light rounded d-flex align-items-center justify-content-center"
                                                     style="width: 60px; height: 60px;">
                                                    <i class="bi bi-image text-muted"></i>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">
                                                <a href="<c:url value='/user/products/${product.id}'/>" class="text-decoration-none text-dark fw-bold">
                                                    ${product.nameVi}
                                                </a>
                                            </h6>
                                            <div class="d-flex align-items-center gap-2">
                                                <span class="badge bg-primary">${product.categoryNameVi}</span>
                                                <span class="text-success fw-bold">
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                                </span>
                                            </div>
                                        </div>
                                        <a href="<c:url value='/user/products/${product.id}'/>" class="btn btn-primary btn-sm">
                                            <i class="bi bi-eye me-1"></i>Xem
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Author Info -->
            <div class="card mb-4 shadow-sm animate__animated animate__fadeInRight animate__delay-1s">
                <div class="card-header bg-gradient-primary text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-person-circle-fill me-2"></i>
                        Tác giả bài viết
                    </h6>
                </div>
                <div class="card-body text-center">
                    <div class="author-avatar mb-3">
                        <i class="bi bi-person-circle display-4 text-primary"></i>
                    </div>
                    <h6 class="fw-bold mb-2">${blog.authorName}</h6>
                    <p class="text-muted small mb-3">Người viết blog</p>

                    <c:if test="${sessionScope.user.id == blog.authorId}">
                        <div class="d-grid gap-2">
                            <a href="<c:url value='/user/blogs/edit/${blog.id}'/>" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil-square me-1"></i>Chỉnh sửa bài viết
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-sm"
                                    onclick="deleteBlog(${blog.id}, '${blog.titleVi}')">
                                <i class="bi bi-trash me-1"></i>Xóa bài viết
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Blog Stats -->
            <div class="card mb-4 shadow-sm animate__animated animate__fadeInRight animate__delay-2s">
                <div class="card-header bg-success text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-bar-chart-line-fill me-2"></i>
                        Thống kê bài viết
                    </h6>
                </div>
                <div class="card-body">
                    <div class="stats-item d-flex align-items-center mb-3">
                        <i class="bi bi-calendar-event text-primary me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">
                                <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy"/>
                            </div>
                            <small class="text-muted">Ngày đăng</small>
                        </div>
                    </div>
                    <div class="stats-item d-flex align-items-center mb-3">
                        <i class="bi bi-eye text-success me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">Chưa có</div>
                            <small class="text-muted">Lượt xem</small>
                        </div>
                    </div>
                    <div class="stats-item d-flex align-items-center">
                        <i class="bi bi-tag text-warning me-3 fs-5"></i>
                        <div>
                            <div class="fw-bold">${blog.products.size()}</div>
                            <small class="text-muted">Sản phẩm liên quan</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <div class="card shadow-sm animate__animated animate__fadeInRight animate__delay-3s">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0">
                        <i class="bi bi-compass-fill me-2"></i>
                        Điều hướng
                    </h6>
                </div>
                <div class="card-body d-grid gap-2">
                    <a href="<c:url value='/user/blogs'/>" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại Blog
                    </a>
                    <c:if test="${not empty sessionScope.user}">
                        <a href="<c:url value='/user/blogs/create'/>" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i>Viết bài mới
                        </a>
                        <a href="<c:url value='/user/blogs/my-blogs'/>" class="btn btn-outline-secondary">
                            <i class="bi bi-person me-2"></i>Bài viết của tôi
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Hero Section */
.hero-section {
    position: relative;
    overflow: hidden;
}

.hero-pattern {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
    background-size: 30px 30px;
    animation: float 15s infinite linear;
}

@keyframes float {
    0% { transform: translate(-50%, -50%) rotate(0deg); }
    100% { transform: translate(-50%, -50%) rotate(360deg); }
}

/* Blog Image */
.blog-image-container {
    position: relative;
    border-radius: 15px;
    overflow: hidden;
}

.image-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(45deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
    opacity: 0;
    transition: opacity 0.3s ease;
}

.blog-image-container:hover .image-overlay {
    opacity: 1;
}

/* Blog Content */
.blog-content {
    line-height: 1.8;
    font-size: 1.1rem;
    color: #2c3e50;
}

.content-wrapper {
    border-radius: 15px;
    border: none;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.blog-content img {
    max-width: 100%;
    height: auto;
    border-radius: 12px;
    margin: 2rem 0;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease;
}

.blog-content img:hover {
    transform: scale(1.02);
}

.blog-content p {
    margin-bottom: 1.5rem;
    font-size: 1.05rem;
}

.blog-content h1,
.blog-content h2,
.blog-content h3,
.blog-content h4,
.blog-content h5,
.blog-content h6 {
    color: #2c3e50;
    margin-top: 2.5rem;
    margin-bottom: 1.25rem;
    font-weight: 700;
    line-height: 1.3;
}

.blog-content h1 { font-size: 2rem; border-bottom: 3px solid #667eea; padding-bottom: 0.5rem; }
.blog-content h2 { font-size: 1.75rem; border-bottom: 2px solid #667eea; padding-bottom: 0.375rem; }
.blog-content h3 { font-size: 1.5rem; color: #667eea; }
.blog-content h4 { font-size: 1.25rem; color: #764ba2; }
.blog-content h5 { font-size: 1.1rem; color: #5a67d8; }
.blog-content h6 { font-size: 1rem; color: #6b46c1; }

.blog-content blockquote {
    border-left: 4px solid #667eea;
    padding-left: 1.5rem;
    margin: 2rem 0;
    font-style: italic;
    color: #555;
    background: rgba(102, 126, 234, 0.05);
    padding: 1.5rem;
    border-radius: 0 8px 8px 0;
    position: relative;
}

.blog-content blockquote::before {
    content: '"';
    font-size: 4rem;
    color: #667eea;
    position: absolute;
    top: -10px;
    left: 10px;
    opacity: 0.3;
}

.blog-content ul, .blog-content ol {
    padding-left: 2rem;
    margin-bottom: 1.5rem;
}

.blog-content li {
    margin-bottom: 0.5rem;
}

.blog-content code {
    background: rgba(102, 126, 234, 0.1);
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    font-family: 'Monaco', 'Menlo', monospace;
    font-size: 0.9em;
}

.blog-content pre {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    border-left: 4px solid #667eea;
    overflow-x: auto;
    margin: 1.5rem 0;
}

.blog-content table {
    width: 100%;
    border-collapse: collapse;
    margin: 1.5rem 0;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
}

.blog-content th,
.blog-content td {
    padding: 0.75rem;
    text-align: left;
    border-bottom: 1px solid #dee2e6;
}

.blog-content th {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    font-weight: 600;
}

.blog-content tr:nth-child(even) {
    background: rgba(102, 126, 234, 0.02);
}

/* Sidebar Cards */
.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: transform 0.3s ease;
}

.card:hover {
    transform: translateY(-2px);
}

.card-header {
    border-radius: 15px 15px 0 0 !important;
    border: none;
    font-weight: 600;
}

.bg-gradient-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Author Avatar */
.author-avatar {
    position: relative;
}

.author-avatar::after {
    content: '';
    position: absolute;
    bottom: -5px;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 2px;
}

/* Stats Items */
.stats-item {
    padding: 0.75rem 0;
    border-bottom: 1px solid rgba(0,0,0,0.05);
}

.stats-item:last-child {
    border-bottom: none;
}

/* Product Items */
.product-item {
    transition: all 0.3s ease;
    border: 1px solid rgba(0,0,0,0.08) !important;
}

.product-item:hover {
    transform: translateX(5px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    border-color: #667eea !important;
}

.hover-lift {
    transition: all 0.3s ease;
}

.hover-lift:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
}

/* Responsive */
@media (max-width: 768px) {
    .hero-section {
        padding: 60px 20px;
        margin-top: 20px;
    }

    .hero-section .display-4 {
        font-size: 2rem;
    }

    .blog-content h1 { font-size: 1.75rem; }
    .blog-content h2 { font-size: 1.5rem; }
    .blog-content h3 { font-size: 1.25rem; }
}

/* Animations */
@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(100%);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.animate__slideInRight {
    animation: slideInRight 0.5s ease-out;
}
</style>

<script>
// Delete blog confirmation
function deleteBlog(blogId, title) {
    if (confirm(`Bạn có chắc muốn xóa bài viết "${title}"?\n\nHành động này không thể hoàn tác.`)) {
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

// Smooth scroll for anchor links
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth scrolling to all anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Add fade-in animation to content sections
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all content sections
    document.querySelectorAll('.blog-content h1, .blog-content h2, .blog-content h3, .blog-content blockquote').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});
</script>
