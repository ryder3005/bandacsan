<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<jsp:include page="/WEB-INF/common/toast-handler.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-box-seam"></i> Quản lý Sản phẩm</h1>
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-12 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-box-seam"></i> Tổng số sản phẩm</h5>
                    <h3 class="mb-0">${not empty products ? fn:length(products) : 0}</h3>
                    <small>Tổng số sản phẩm của bạn</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-box-seam"></i> Danh sách sản phẩm</h5>
                    <a href="<c:url value='/vendor/products/create'/>" class="btn btn-outline-warning">
                        <i class="bi bi-plus-circle"></i> Thêm mới
                    </a>
                </div>
                <div class="card-body">
                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="10%">Hình ảnh</th>
                                <th width="25%">Tên sản phẩm</th>
                                <th width="12%">Giá</th>
                                <th width="8%">Tồn kho</th>
                                <th width="15%">Danh mục</th>
                                <th width="25%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty products}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                            <p class="text-muted">Bắt đầu quản lý sản phẩm bằng cách thêm sản phẩm mới.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="p" items="${products}">
                                        <tr>
                                            <td>${p.id}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty p.imageUrls && fn:length(p.imageUrls) > 0}">
                                                        <img src="<c:url value='/files/${p.imageUrls[0]}' />" 
                                                             alt="${p.nameVi}" 
                                                             class="img-thumbnail" 
                                                             style="width: 80px; height: 80px; object-fit: cover; cursor: pointer;"
                                                             onclick="showImageModal('<c:url value="/files/${p.imageUrls[0]}" />', '${p.nameVi}')" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="bg-light d-flex align-items-center justify-content-center" 
                                                             style="width: 80px; height: 80px;">
                                                            <i class="bi bi-image text-muted" style="font-size: 2rem;"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><strong>${p.nameVi}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.price != null}">
                                                        ${p.price} VNĐ
                                                    </c:when>
                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${p.stock != null && p.stock > 0}">
                                                        ${p.stock}
                                                    </c:when>
                                                    <c:otherwise>0</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty p.categories}">
                                                        <c:forEach var="cat" items="${p.categories}" varStatus="status">
                                                            ${cat}<c:if test="${!status.last}">, </c:if>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="<c:url value='/vendor/products/edit/${p.id}'/>"
                                                   class="btn btn-sm btn-outline-warning">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </a>
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        onclick="confirmDelete(${p.id}, '${p.nameVi}')">
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

<jsp:include page="/WEB-INF/common/footer.jsp" />

<!-- Form xóa ẩn -->
<form id="deleteForm" method="post" action="">
    <input type="hidden" name="_method" value="delete" />
</form>

<!-- Modal hiển thị hình ảnh lớn -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">Hình ảnh sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="" class="img-fluid" style="max-height: 70vh;" />
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, name) {
        if (confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + name + '"?\n\nLưu ý: Thao tác này không thể hoàn tác!')) {
            const form = document.getElementById('deleteForm');
            form.action = '<c:url value="/vendor/products/delete/"/>' + id;
            form.submit();
        }
    }
    
    function showImageModal(imageSrc, productName) {
        const modal = new bootstrap.Modal(document.getElementById('imageModal'));
        document.getElementById('modalImage').src = imageSrc;
        document.getElementById('modalImage').alt = productName;
        document.getElementById('imageModalLabel').textContent = productName;
        modal.show();
    }
</script>
</body>
</html>
