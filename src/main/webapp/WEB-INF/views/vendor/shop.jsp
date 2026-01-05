<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Shop - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<jsp:include page="/WEB-INF/common/toast-handler.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-building"></i> Quản lý Shop</h1>
    
    <!-- Alert Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-building"></i> Thông tin Shop</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty vendor}">
                        <form method="post" action="<c:url value='/vendor/shop/update'/>">
                            <div class="mb-3">
                                <label for="storeName" class="form-label">Tên cửa hàng <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="storeName" name="storeName" 
                                       value="${vendor.storeName}" required />
                            </div>
                            
                            <div class="mb-3">
                                <label for="descriptionVi" class="form-label">Mô tả (Tiếng Việt)</label>
                                <textarea class="form-control" id="descriptionVi" name="descriptionVi" rows="4">${vendor.descriptionVi}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="descriptionEn" class="form-label">Mô tả (Tiếng Anh)</label>
                                <textarea class="form-control" id="descriptionEn" name="descriptionEn" rows="4">${vendor.descriptionEn}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="address" name="address" 
                                       value="${vendor.address}" required />
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="phone" name="phone" 
                                       value="${vendor.phone}" required />
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-save"></i> Lưu thay đổi
                                </button>
                                <a href="<c:url value='/vendor/dashboard'/>" class="btn btn-secondary">
                                    <i class="bi bi-x-circle"></i> Hủy
                                </a>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${empty vendor}">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle"></i> Chưa có thông tin shop. Vui lòng liên hệ admin để được tạo shop.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> Thông tin tài khoản</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty vendor}">
                        <p><strong>Username:</strong> ${vendor.username}</p>
                        <p><strong>Email:</strong> ${vendor.userEmail}</p>
                        <p><strong>Vai trò:</strong> <span class="badge bg-info">VENDOR</span></p>
                    </c:if>
                    <c:if test="${empty vendor}">
                        <p class="text-muted">Chưa có thông tin</p>
                    </c:if>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-lightning"></i> Thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <a href="<c:url value='/vendor/products'/>" class="btn btn-outline-primary w-100 mb-2">
                        <i class="bi bi-box-seam"></i> Quản lý sản phẩm
                    </a>
                    <a href="<c:url value='/vendor/orders'/>" class="btn btn-outline-success w-100 mb-2">
                        <i class="bi bi-cart-check"></i> Xem đơn hàng
                    </a>
                    <a href="<c:url value='/vendor/revenue'/>" class="btn btn-outline-info w-100">
                        <i class="bi bi-cash-coin"></i> Xem doanh thu
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
