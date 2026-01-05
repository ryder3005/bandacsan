<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-tags"></i> Quản lý Danh mục</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-12 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-tags"></i> Tổng số danh mục</h5>
                    <h3 class="mb-0">${not empty categories ? fn:length(categories) : 0}</h3>
                    <small>Tổng số danh mục trong hệ thống</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-tags"></i> Danh sách danh mục</h5>
                    <a href="<c:url value='/admin/categories/create'/>" class="btn btn-outline-success">
                        <i class="bi bi-plus-circle"></i> Thêm mới
                    </a>
                </div>
                <div class="card-body">
                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="8%">ID</th>
                                <th width="40%">Tên (Tiếng Việt)</th>
                                <th width="40%">Tên (Tiếng Anh)</th>
                                <th width="12%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty categories}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                            <p class="text-muted">Bắt đầu quản lý hệ thống bằng cách thêm dữ liệu mới.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat" items="${categories}">
                                        <tr>
                                            <td>${cat.id}</td>
                                            <td><strong>${cat.nameVi}</strong></td>
                                            <td>${cat.nameEn != null ? cat.nameEn : '-'}</td>
                                            <td>
                                                <a href="<c:url value='/admin/categories/edit/${cat.id}'/>"
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="confirmDelete(${cat.id}, '${cat.nameVi}')">
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
<form id="deleteForm" method="post" action="<c:url value='/admin/categories/delete'/>">
    <input type="hidden" name="id" id="deleteId">
</form>

<script>
    function confirmDelete(id, name) {
        if (confirm('Bạn có chắc chắn muốn xóa danh mục "' + name + '"?\n\nLưu ý: Thao tác này không thể hoàn tác!')) {
            document.getElementById('deleteId').value = id;
            document.getElementById('deleteForm').submit();
        }
    }
</script>
</div>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>