<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Người dùng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-people"></i> Quản lý Người dùng</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-12 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-people"></i> Tổng số người dùng</h5>
                    <h3 class="mb-0">${not empty users ? fn:length(users) : 0}</h3>
                    <small>Tổng số người dùng trong hệ thống</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-people"></i> Danh sách người dùng</h5>
                    <a href="<c:url value='/admin/users/create'/>" class="btn btn-outline-primary">
                        <i class="bi bi-person-plus"></i> Thêm mới
                    </a>
                </div>
                <div class="card-body">

                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="20%">Username</th>
                                <th width="30%">Email</th>
                                <th width="15%">Vai trò</th>
                                <th width="30%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty users}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                            <p class="text-muted">Bắt đầu quản lý hệ thống bằng cách thêm dữ liệu mới.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td><strong>${user.username}</strong></td>
                                            <td><c:out value="${user.email}"/></td>
                                            <td><c:out value="${user.role}"/></td>
                                            <td>
                                                <a href="<c:url value='/admin/users/edit/${user.username}'/>"
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="confirmDelete('${user.username}')">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Form xóa ẩn -->
<form id="deleteForm" method="post" action="<c:url value='/admin/users/delete'/>">
    <input type="hidden" name="username" id="deleteUsername">
</form>

<script>
    function confirmDelete(username) {
        if (confirm('Bạn có chắc chắn muốn xóa người dùng "' + username + '"?\n\nLưu ý: Thao tác này không thể hoàn tác!')) {
            document.getElementById('deleteUsername').value = username;
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/common/toast-handler.jsp" />
</body>
</html>