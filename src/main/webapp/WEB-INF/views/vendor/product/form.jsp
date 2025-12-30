<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa sản phẩm - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<div class="container mt-4">
    <h2>
        <i class="bi bi-box-seam"></i>
        <c:choose>
            <c:when test="${not empty product}">Chỉnh sửa sản phẩm</c:when>
            <c:otherwise>Thêm sản phẩm mới</c:otherwise>
        </c:choose>
    </h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <form method="post" action="<c:url value='/vendor/products/save' />" id="productForm">
        <c:if test="${not empty product}">
            <input type="hidden" name="id" value="${product.id}" />
        </c:if>

        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="nameVi" class="form-label">Tên (Tiếng Việt) <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="nameVi" name="nameVi"
                           value="${product.nameVi}" required />
                </div>

                <div class="mb-3">
                    <label for="nameEn" class="form-label">Tên (Tiếng Anh)</label>
                    <input type="text" class="form-control" id="nameEn" name="nameEn"
                           value="${product.nameEn}" />
                </div>

                <div class="mb-3">
                    <label for="descriptionVi" class="form-label">Mô tả (Tiếng Việt) <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="descriptionVi" name="descriptionVi" rows="3" required>${product.descriptionVi}</textarea>
                </div>

                <div class="mb-3">
                    <label for="descriptionEn" class="form-label">Mô tả (Tiếng Anh)</label>
                    <textarea class="form-control" id="descriptionEn" name="descriptionEn" rows="3">${product.descriptionEn}</textarea>
                </div>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="price" class="form-label">Giá <span class="text-danger">*</span></label>
                    <input type="number" step="0.01" class="form-control" id="price" name="price"
                           value="${product.price}" required min="0" />
                </div>

                <div class="mb-3">
                    <label for="stock" class="form-label">Tồn kho <span class="text-danger">*</span></label>
                    <input type="number" class="form-control" id="stock" name="stock"
                           value="${product.stock}" required min="0" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Danh mục <span class="text-danger">*</span></label>
                    <select class="form-select" id="categoryIds" name="categoryIds" multiple required>
                        <c:forEach var="category" items="${categories}">
                            <c:set var="selected" value="false" />
                            <c:if test="${not empty selectedCategoryIds}">
                                <c:forEach var="catId" items="${selectedCategoryIds}">
                                    <c:if test="${catId == category.id}">
                                        <c:set var="selected" value="true" />
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <option value="${category.id}" ${selected ? 'selected' : ''}>${category.nameVi}</option>
                        </c:forEach>
                    </select>
                    <small class="form-text text-muted">Giữ Ctrl (Cmd trên Mac) để chọn nhiều danh mục</small>
                </div>

                <c:if test="${not empty vendorName}">
                    <div class="mb-3">
                        <label class="form-label">Nhà bán hàng</label>
                        <input type="text" class="form-control" value="${vendorName}" readonly />
                        <input type="hidden" name="vendorId" value="${vendorId}" />
                    </div>
                </c:if>
            </div>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-warning">
                <i class="bi bi-save"></i> Lưu
            </button>
            <a href="<c:url value='/vendor/products'/>" class="btn btn-secondary">
                <i class="bi bi-x-circle"></i> Hủy
            </a>
        </div>
    </form>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
