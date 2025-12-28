<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Admin - <sitemesh:write property='title'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <sitemesh:write property='head'/>
</head>
<body>

<header class="bg-dark text-white py-3 mb-4">
    <div class="container d-flex justify-content-between">
        <h4>Khu vực Quản trị (Admin)</h4>

        <nav class="d-flex gap-3 align-items-center">
            <a href="<c:url value='/'/>" class="btn btn-outline-light btn-sm">Trang chủ</a>
            <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-light btn-sm">Danh mục</a>
            <a href="<c:url value='/admin/videos'/>" class="btn btn-outline-light btn-sm">Video</a>
            <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Đăng xuất</a>
        </nav>
    </div>
</header>

<main class="container mb-5">
    <sitemesh:write property='body'/>
</main>

<footer class="bg-dark text-white py-3">
    <div class="container">
        &copy; <%= java.time.Year.now() %> - Họ tên: Cao Thọ Phú Thịnh - MSSV: 21144449 - Mã đề: 03
    </div>
</footer>

</body>
</html>
