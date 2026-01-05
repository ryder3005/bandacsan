<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="vi">
<head>
        <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title><sitemesh:write property='title'/></title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/site.css'/>"/>
    <sitemesh:write property='head'/>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
        }
        main {
            flex: 1 0 auto;
        }
        footer {
            flex-shrink: 0;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="bg-light py-3 mb-4 border-bottom">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h5>Thông tin sinh viên</h5>
            <p class="mb-0"> MSSV: 21144449</p>
        </div>
        <div>
            <nav>
                <a href="<c:url value='/'/>" class="btn btn-outline-primary">Trang chủ</a>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-secondary">Admin</a>
            </nav>
        </div>
    </div>
</header>

<!-- Main content -->
<main class="container mb-5">
    <sitemesh:write property='body'/>
</main>

<!-- Footer -->
<footer class="bg-dark text-white py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h6 class="mb-3 text-white">Liên hệ</h6>
                <p class="mb-2 text-white-50"><i class="bi bi-envelope text-primary"></i> Email: 23110101@student.hcmute.edu.vn</p>
                <p class="mb-2 text-white-50"><i class="bi bi-telephone text-success"></i> Hotline: 0899956690</p>
            </div>
            <div class="col-md-6 text-end">
                <p class="mb-0 text-white-50">
                    &copy; <%= java.time.Year.now() %> Website Quảng bá và Kinh doanh Đặc sản Quê hương. Tất cả quyền được bảo lưu.
                </p>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/resources/js/main.js'/>"></script>
</body>
</html>