<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <sitemesh:write property="head"/>
</head>
<body>

<header class="bg-light border-bottom py-3 mb-4">
    <div class="container d-flex justify-content-between">
        <div>
            <h5></h5>
        </div>

        <nav class="d-flex gap-2 align-items-center">

            <a href="<c:url value='/'/>" class="btn btn-outline-primary">Trang chủ</a>
            <a href="<c:url value='/videos'/>" class="btn btn-outline-primary">Sản phẩm</a>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="<c:url value='/logout'/>" class="btn btn-outline-danger">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login'/>" class="btn btn-outline-success">Đăng nhập</a>
                </c:otherwise>
            </c:choose>

            <!-- Chỉ Admin mới thấy -->
            <c:if test="${sessionScope.user != null && sessionScope.user.admin == true}">
                <a href="<c:url value='/admin/home'/>" class="btn btn-outline-secondary">
                    Trang quản trị
                </a>
            </c:if>

        </nav>
    </div>
</header>

<main class="container mb-5">
    <sitemesh:write property="body"/>
</main>

<footer class="bg-dark text-white py-3">
    <div class="container">
        &copy; <%= java.time.Year.now() %> - Họ tên: Cao Thọ Phú Thịnh - MSSV: 21144449 - Mã đề: 03
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
