<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary px-4">
    <a class="navbar-brand fw-bold" href="<c:url value='/'/>">🌾 Đặc Sản</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <!-- Left Menu -->
        <ul class="navbar-nav me-auto">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">🏠 Trang chủ</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/user/products'/>">🛍 Sản phẩm</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/user/categories'/>">📂 Danh mục</a></li>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'ADMIN'}">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/home'/>">⚙ Quản trị</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'VENDOR'}">
                <li class="nav-item"><a class="nav-link" href="<c:url value='/vendor/dashboard'/>">🏬 Shop</a></li>
            </c:if>
        </ul>

        <!-- Right User Info -->
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" id="headerUserDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            👤 ${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="headerUserDropdown">
                            <li><a class="dropdown-item" href="<c:url value='/profile'/>">
                                <i class="bi bi-person"></i> Thông tin cá nhân
                            </a></li>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <li><a class="dropdown-item" href="<c:url value='/admin/home'/>">
                                    <i class="bi bi-shield-check"></i> Quản trị hệ thống
                                </a></li>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'VENDOR'}">
                                <li><a class="dropdown-item" href="<c:url value='/vendor/dashboard'/>">
                                    <i class="bi bi-shop"></i> Quản lý shop
                                </a></li>
                            </c:if>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>">
                                <i class="bi bi-box-arrow-right"></i> 🚪 Đăng xuất
                            </a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item"><a class="btn btn-light" href="<c:url value='/login'/>">🔐 Đăng nhập</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Đảm bảo dropdown menu hoạt động trên tất cả các trang
    document.addEventListener('DOMContentLoaded', function() {
        // Đóng dropdown khi click bên ngoài
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.dropdown')) {
                // Đóng tất cả dropdown đang mở
                document.querySelectorAll('.dropdown-menu.show').forEach(function(menu) {
                    menu.classList.remove('show');
                    var toggle = menu.previousElementSibling;
                    if (toggle) {
                        toggle.setAttribute('aria-expanded', 'false');
                    }
                });
            }
        });

        // Ngăn dropdown đóng khi click bên trong menu
        document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
            menu.addEventListener('click', function(event) {
                event.stopPropagation();
            });
        });

        // Đảm bảo dropdown toggle hoạt động
        document.querySelectorAll('.dropdown-toggle').forEach(function(toggle) {
            toggle.addEventListener('click', function(event) {
                event.preventDefault();
                event.stopPropagation();

                var menu = this.nextElementSibling;
                if (menu && menu.classList.contains('dropdown-menu')) {
                    // Đóng dropdown khác trước
                    document.querySelectorAll('.dropdown-menu.show').forEach(function(otherMenu) {
                        if (otherMenu !== menu) {
                            otherMenu.classList.remove('show');
                            var otherToggle = otherMenu.previousElementSibling;
                            if (otherToggle) {
                                otherToggle.setAttribute('aria-expanded', 'false');
                            }
                        }
                    });

                    // Toggle menu hiện tại
                    var isExpanded = this.getAttribute('aria-expanded') === 'true';
                    if (isExpanded) {
                        menu.classList.remove('show');
                        this.setAttribute('aria-expanded', 'false');
                    } else {
                        menu.classList.add('show');
                        this.setAttribute('aria-expanded', 'true');
                    }
                }
            });
        });
    });
</script>

