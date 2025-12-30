<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
    <p class="text-muted mb-4">Chào mừng, <c:out value="${sessionScope.user != null ? sessionScope.user.username : 'Admin'}"/>! Đây là trang quản trị hệ thống.</p>

    <!-- Quick Stats -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-people"></i> Người dùng</h5>
                    <h3 class="mb-0">${not empty users ? fn:length(users) : 0}</h3>
                    <small>Tổng số người dùng</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-tags"></i> Danh mục</h5>
                    <h3 class="mb-0">${not empty categories ? fn:length(categories) : 0}</h3>
                    <small>Tổng số danh mục</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-box-seam"></i> Sản phẩm</h5>
                    <h3 class="mb-0">-</h3>
                    <small>Chưa có dữ liệu</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-shop"></i> Nhà bán</h5>
                    <h3 class="mb-0">-</h3>
                    <small>Chưa có dữ liệu</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0"><i class="bi bi-lightning"></i> Thao tác nhanh</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/users'/>" class="btn btn-outline-primary w-100">
                        <i class="bi bi-people"></i><br>
                        Quản lý người dùng
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-outline-success w-100">
                        <i class="bi bi-tags"></i><br>
                        Quản lý danh mục
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/products'/>" class="btn btn-outline-warning w-100">
                        <i class="bi bi-box-seam"></i><br>
                        Quản lý sản phẩm
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="<c:url value='/admin/vendors'/>" class="btn btn-outline-info w-100">
                        <i class="bi bi-shop"></i><br>
                        Quản lý nhà bán
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Categories List (nếu có) -->
    <c:if test="${not empty categories}">
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="bi bi-tags"></i> Danh mục sản phẩm</span>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-success btn-sm">
                    <i class="bi bi-plus-circle"></i> Xem tất cả
                </a>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên (Tiếng Việt)</th>
                            <th>Tên (Tiếng Anh)</th>
                            <th>Số sản phẩm</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cat" items="${categories}" begin="0" end="4">
                            <tr>
                                <td>${cat.id}</td>
                                <td>${cat.nameVi != null ? cat.nameVi : '-'}</td>
                                <td>${cat.nameEn != null ? cat.nameEn : '-'}</td>
                                <td>-</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Empty State -->
    <c:if test="${empty categories && empty users}">
        <div class="card">
            <div class="card-body text-center py-5">
                <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                <p class="text-muted">Bắt đầu quản lý hệ thống bằng cách thêm dữ liệu mới.</p>
            </div>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
