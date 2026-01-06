<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        .hero-carousel {
            position: relative;
            overflow: hidden;
            border-radius: 0 0 50px 50px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .hero-slide {
            height: 70vh;
            min-height: 500px;
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: center;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9) 0%, rgba(118, 75, 162, 0.9) 100%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: white;
            text-align: center;
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .hero-title {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.3);
            animation: textGlow 3s ease-in-out infinite alternate;
        }

        .hero-subtitle {
            font-size: 1.4rem;
            margin-bottom: 30px;
            opacity: 0.9;
            font-weight: 300;
        }

        @keyframes textGlow {
            from {
                text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            }

            to {
                text-shadow: 0 0 20px rgba(255, 255, 255, 0.8), 0 0 30px rgba(255, 255, 255, 0.6);
            }
        }

        .hero-btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
            border: none;
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .hero-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(255, 107, 107, 0.4);
        }

        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            height: 100%;
            border: none;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2.5rem;
            transition: all 0.3s ease;
        }

        .feature-card:nth-child(1) .feature-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .feature-card:nth-child(2) .feature-icon {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .feature-card:nth-child(3) .feature-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1);
        }

        .category-card {
            position: relative;
            border-radius: 15px;
            overflow: hidden;
            height: 250px;
            transition: all 0.3s ease;
        }

        .category-card:hover {
            transform: scale(1.05);
        }

        .category-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.3) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            transition: all 0.3s ease;
        }

        .category-card:hover .category-overlay {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.8) 0%, rgba(118, 75, 162, 0.8) 100%);
        }

        .category-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .category-desc {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .product-showcase {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 30px;
            padding: 60px 40px;
            margin: 60px 0;
        }

        .showcase-title {
            font-size: 2.8rem;
            font-weight: 700;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 50px;
        }

        .testimonial-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .testimonial-quote {
            font-size: 1.2rem;
            font-style: italic;
            margin-bottom: 20px;
            color: #555;
        }

        .testimonial-author {
            font-weight: 600;
            color: #667eea;
        }

        .stats-section {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 60px 0;
            margin: 60px 0;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .cta-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
            border-radius: 30px;
            margin: 60px 0;
        }

        .cta-title {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .cta-subtitle {
            font-size: 1.3rem;
            margin-bottom: 40px;
            opacity: 0.9;
        }

        .cta-btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
            border: none;
            padding: 18px 50px;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(255, 107, 107, 0.4);
        }

        .carousel-indicators {
            bottom: 20px;
        }

        .carousel-indicators button {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin: 0 5px;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .showcase-title {
                font-size: 2rem;
            }

            .cta-title {
                font-size: 2rem;
            }
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/common/header.jsp"/>

<!-- Hero Carousel -->
<section class="hero-carousel">
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"
                    aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"
                    aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"
                    aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="hero-slide"
                     style="background-image: url('https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');">
                    <div class="hero-overlay"></div>
                    <div class="container">
                        <div class="hero-content animate__animated animate__fadeInUp">
                            <h1 class="hero-title">Đặc Sản Việt Nam</h1>
                            <p class="hero-subtitle">Khám phá hương vị truyền thống từ 3 miền đất nước
                            </p>
                            <a href="<c:url value='/user/products'/>" class="btn hero-btn">
                                <i class="fas fa-shopping-cart me-2"></i>Khám phá ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="hero-slide"
                     style="background-image: url('https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');">
                    <div class="hero-overlay"></div>
                    <div class="container">
                        <div class="hero-content animate__animated animate__fadeInUp">
                            <h1 class="hero-title">Tươi Ngon Mỗi Ngày</h1>
                            <p class="hero-subtitle">Giao hàng tận nơi với chất lượng được đảm bảo</p>
                            <a href="<c:url value='/user/categories'/>" class="btn hero-btn">
                                <i class="fas fa-tags me-2"></i>Xem danh mục
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="hero-slide"
                     style="background-image: url('https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=1974&q=80');">
                    <div class="hero-overlay"></div>
                    <div class="container">
                        <div class="hero-content animate__animated animate__fadeInUp">
                            <h1 class="hero-title">Truyền Thống & Hiện Đại</h1>
                            <p class="hero-subtitle">Kết hợp tinh hoa ẩm thực Việt với trải nghiệm mua
                                sắm online</p>
                            <a href="<c:url value='/user/blogs'/>" class="btn hero-btn">
                                <i class="fas fa-blog me-2"></i>Đọc tin tức
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>

<div class="container">

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="showcase-title animate__animated animate__fadeInUp">Tại sao chọn chúng
                        tôi?</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card animate__animated animate__fadeInUp">
                        <div class="feature-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <h5 class="card-title fw-bold mb-3">Giao hàng siêu tốc</h5>
                        <p class="card-text text-muted">Giao hàng tận nơi trong 24h, đảm bảo tươi ngon
                            và an toàn</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card animate__animated animate__fadeInUp animate__delay-1s">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5 class="card-title fw-bold mb-3">Chất lượng 100%</h5>
                        <p class="card-text text-muted">Sản phẩm được kiểm định nghiêm ngặt, đảm bảo an
                            toàn vệ sinh</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card animate__animated animate__fadeInUp animate__delay-2s">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5 class="card-title fw-bold mb-3">Hỗ trợ tận tình</h5>
                        <p class="card-text text-muted">Đội ngũ chăm sóc khách hàng chuyên nghiệp, hỗ
                            trợ 24/7</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="showcase-title animate__animated animate__fadeInUp">Khám phá đặc sản</h2>
                    <p class="text-muted animate__animated animate__fadeInUp animate__delay-1s">Đặc sản
                        từ 3 miền Bắc - Trung - Nam Việt Nam</p>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card animate__animated animate__fadeInLeft"
                         style="background-image: url('https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=2070&q=80');">
                        <div class="category-overlay">
                            <div>
                                <h3 class="category-title">Miền Bắc</h3>
                                <p class="category-desc">Phở Hà Nội, Bún Chả, Nem Phùng</p>
                                <a href="<c:url value='/user/categories'/>"
                                   class="btn btn-light btn-lg mt-3">Khám phá</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card animate__animated animate__fadeInUp"
                         style="background-image: url('https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&auto=format&fit=crop&w=1974&q=80');">
                        <div class="category-overlay">
                            <div>
                                <h3 class="category-title">Miền Trung</h3>
                                <p class="category-desc">Mì Quảng, Bánh Bèo, Cao Lầu</p>
                                <a href="<c:url value='/user/categories'/>"
                                   class="btn btn-light btn-lg mt-3">Khám phá</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="category-card animate__animated animate__fadeInRight"
                         style="background-image: url('https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=1974&q=80');">
                        <div class="category-overlay">
                            <div>
                                <h3 class="category-title">Miền Nam</h3>
                                <p class="category-desc">Bánh Mì Sài Gòn, Hủ Tiếu, Bánh Tét</p>
                                <a href="<c:url value='/user/categories'/>"
                                   class="btn btn-light btn-lg mt-3">Khám phá</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="animate__animated animate__fadeInUp">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Sản phẩm đặc sắc</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="animate__animated animate__fadeInUp animate__delay-1s">
                        <div class="stat-number">1000+</div>
                        <div class="stat-label">Khách hàng hài lòng</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="animate__animated animate__fadeInUp animate__delay-2s">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Nhà bán hàng</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="animate__animated animate__fadeInUp animate__delay-3s">
                        <div class="stat-number">24/7</div>
                        <div class="stat-label">Hỗ trợ khách hàng</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="showcase-title animate__animated animate__fadeInUp">Khách hàng nói gì
                    </h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <div class="testimonial-card animate__animated animate__fadeInLeft">
                        <div class="text-center mb-3">
                            <i class="fas fa-quote-left text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <p class="testimonial-quote">"Sản phẩm rất tươi ngon, giao hàng nhanh chóng. Đặc
                            biệt là phở Hà Nội mang đúng hương vị truyền thống!"</p>
                        <div class="text-center">
                            <div class="testimonial-author">- Nguyễn Văn A, Hà Nội</div>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="testimonial-card animate__animated animate__fadeInUp">
                        <div class="text-center mb-3">
                            <i class="fas fa-quote-left text-success" style="font-size: 2rem;"></i>
                        </div>
                        <p class="testimonial-quote">"Website dễ sử dụng, đa dạng sản phẩm. Mình rất
                            thích phần bánh mì Sài Gòn và hủ tiếu Nam Vang."</p>
                        <div class="text-center">
                            <div class="testimonial-author">- Trần Thị B, TP.HCM</div>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="testimonial-card animate__animated animate__fadeInRight">
                        <div class="text-center mb-3">
                            <i class="fas fa-quote-left text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <p class="testimonial-quote">"Dịch vụ chăm sóc khách hàng tuyệt vời. Mọi thắc
                            mắc đều được giải đáp nhanh chóng và tận tình."</p>
                        <div class="text-center">
                            <div class="testimonial-author">- Lê Văn C, Đà Nẵng</div>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title animate__animated animate__bounceIn">Sẵn sàng trải nghiệm?</h2>
                <p class="cta-subtitle animate__animated animate__fadeInUp animate__delay-1s">
                    Đặt hàng ngay hôm nay và nhận ưu đãi đặc biệt cho khách hàng mới!
                </p>
                <a href="<c:url value='/user/products'/>"
                   class="cta-btn animate__animated animate__fadeInUp animate__delay-2s">
                    <i class="fas fa-shopping-bag me-2"></i>Bắt đầu mua sắm
                </a>
            </div>
        </div>
    </section>

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
                        <a href="<c:url value='/user/products?categoryId=${category.id}'/>"
                           class="text-decoration-none">
                            <div class="card category-card border-0 shadow-sm h-100"
                                 style="transition: transform 0.3s, box-shadow 0.3s; cursor: pointer;">
                                <div class="card-body text-center p-4">
                                    <div class="category-icon mb-2"
                                         style="font-size: 2.5rem; color: #667eea;">
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
                        <div class="card product-card border-0 shadow-sm h-100"
                             style="transition: transform 0.3s, box-shadow 0.3s; overflow: hidden;">
                            <!-- Product Image -->
                            <div
                                    style="height: 200px; overflow: hidden; background: #f8f9fa; position: relative;">
                                <c:choose>
                                    <c:when
                                            test="${not empty product.productImage }">
                                        <img src="/files/${product.productImage}" class="card-img-top"
                                             alt="${product.nameVi != null ? product.nameVi : (product.nameEn != null ? product.nameEn : 'Product')}"
                                             style="width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s;"
                                             onerror="this.onerror=null; this.parentElement.innerHTML='<div class=&quot;d-flex align-items-center justify-content-center h-100&quot;><i class=&quot;bi bi-image&quot; style=&quot;font-size: 3rem; color: #ccc;&quot;></i></div>';">

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
                                        ${product.nameVi != null ? product.nameVi : product.nameEn}
                                </h6>

                                <c:if test="${not empty product.categories}">
                                    <div class="mb-2">
                                        <c:forEach var="cat" items="${product.categories}" begin="0"
                                                   end="1">
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
                                    <button class="btn btn-primary w-100 add-to-cart-btn"
                                            data-id="${product.id}"
                                            data-name="${product.nameVi != null ? product.nameVi : product.nameEn}"
                                            data-price="${product.price}"
                                            data-image="${not empty product.productImage ? product.imageUrls[0] : ''}">
                                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                    </button>
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
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15) !important;
        }

        .product-card:hover .card-img-top {
            transform: scale(1.1);
        }

        .category-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12) !important;
        }

        .hero-section {
            background-size: cover;
            background-position: center;
        }

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
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.2);
            }
        }

        @keyframes pulse {
            0%, 100% {
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

        .add-to-cart-btn.adding {
            pointer-events: none;
            opacity: 0.7;
        }

        .add-to-cart-btn.success {
            animation: pulse 0.5s ease-in-out;
        }

        .cart-icon-animate {
            animation: bounce 0.5s ease-in-out;
        }

        .success-checkmark {
            display: inline-block;
            margin-left: 5px;
            animation: bounce 0.5s ease-in-out;
        }
    </style>
</div>
<jsp:include page="/WEB-INF/common/floating-widgets.jsp"/>
<jsp:include page="/WEB-INF/common/footer.jsp"/>
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Kiểm tra trạng thái đăng nhập từ Session
        const isLoggedIn = <c:choose><c:when test="${not empty sessionScope.user}">true</c:when><c:otherwise>false</c:otherwise></c:choose>;

        // Chọn tất cả các nút có class add-to-cart-btn
        const cartButtons = document.querySelectorAll('.add-to-cart-btn');

        cartButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.preventDefault();

                // 1. Kiểm tra đăng nhập
                if (!isLoggedIn) {
                    // Sử dụng Toast để báo lỗi trước khi chuyển hướng (tùy chọn)
                    if (typeof showToast === 'function') {
                        showToast('Vui lòng đăng nhập để mua hàng!', 'warning');
                        setTimeout(() => {
                            const currentPath = window.location.pathname;
                            window.location.href = '<c:url value="/login"/>?redirect=' + currentPath;
                        }, 1000);
                    } else {
                        window.location.href = '<c:url value="/login"/>';
                    }
                    return;
                }

                // 2. Nếu đã đăng nhập, lấy ID sản phẩm và gửi yêu cầu
                const productId = this.getAttribute('data-id');
                addToCart(productId);
            });
        });
    });

    function addToCart(productId) {
        // Tìm nút được click
        const button = document.querySelector(`.add-to-cart-btn[data-id="${productId}"]`);
        if (!button) return;

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
            quantity: 1
        };

        // Lấy CSRF Token nếu dùng Spring Security
        const csrfToken = document.querySelector('input[name="_csrf"]')?.value;

        var headers = {
            'Content-Type': 'application/json'
        };
        if (csrfToken) {
            headers['X-CSRF-TOKEN'] = csrfToken;
        }

        fetch('<c:url value="/user/cart/add"/>', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify(cartData)
        })
            .then(async response => {
                if (response.ok) {
                    // Xóa icon bay sau animation
                    setTimeout(() => {
                        flyingIcon.remove();
                    }, 800);

                    // Hiệu ứng thành công trên nút
                    button.classList.remove('adding');
                    button.classList.add('success');
                    button.innerHTML = '<i class="bi bi-check-circle"></i> Đã thêm!';
                    
                    // Hiệu ứng bounce trên icon giỏ hàng
                    if (cartIcon) {
                        cartIcon.classList.add('cart-icon-animate');
                        setTimeout(() => {
                            cartIcon.classList.remove('cart-icon-animate');
                        }, 500);
                    }

                    // Khôi phục nút sau 1.5s
                    setTimeout(() => {
                        button.classList.remove('success');
                        button.innerHTML = originalText;
                    }, 1500);

                    // Cập nhật badge giỏ hàng nếu có
                    if (typeof updateCartBadge === 'function') {
                        updateCartBadge();
                    }
                } else if (response.status === 401) {
                    flyingIcon.remove();
                    button.classList.remove('adding');
                    button.innerHTML = originalText;
                    if (typeof showToast === 'function') {
                        showToast('Phiên đăng nhập hết hạn!', 'danger');
                    }
                    setTimeout(() => {
                        window.location.href = '<c:url value="/login"/>';
                    }, 1000);
                } else {
                    // THẤT BẠI
                    flyingIcon.remove();
                    button.classList.remove('adding');
                    button.innerHTML = originalText;
                    const errorMsg = await response.text();
                    if (typeof showToast === 'function') {
                        showToast('Lỗi: ' + (errorMsg || 'Không thể thêm vào giỏ'), 'danger');
                    } else {
                        alert("Không thể thêm vào giỏ hàng.");
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                flyingIcon.remove();
                button.classList.remove('adding');
                button.innerHTML = originalText;
                if (typeof showToast === 'function') {
                    showToast('Lỗi kết nối đến máy chủ!', 'danger');
                }
            });
    }
</script>
</body>

</html>