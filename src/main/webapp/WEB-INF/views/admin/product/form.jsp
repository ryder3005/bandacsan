<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm/Sửa sản phẩm - Admin</title>
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

    <form id="productForm" enctype="multipart/form-data">
        <c:if test="${not empty product}">
            <input type="hidden" name="id" value="${product.id}" />
        </c:if>
        <input type="hidden" id="productId" value="${product.id}" />
        
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
                    <label for="vendorId" class="form-label">Nhà bán hàng <span class="text-danger">*</span></label>
                    <select class="form-select" id="vendorId" name="vendorId" required>
                        <option value="">-- Chọn nhà bán hàng --</option>
                        <c:forEach var="vendor" items="${vendors}">
                            <option value="${vendor.id}" ${product.vendorId == vendor.id ? 'selected' : ''}>
                                ${vendor.storeName} - ${vendor.username}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="categoryIds" class="form-label">Danh mục <span class="text-danger">*</span></label>
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
                
                <div class="mb-3">
                    <label for="files" class="form-label">Hình ảnh</label>
                    <input type="file" class="form-control" id="files" name="files" multiple accept="image/*" />
                    <c:if test="${not empty product.imageUrls}">
                        <small class="form-text text-muted">Hình ảnh hiện tại:</small>
                        <div class="mt-2">
                            <c:forEach var="imgUrl" items="${product.imageUrls}">
                                <img src="${imgUrl}" alt="Product" class="img-thumbnail me-2" style="max-width: 100px; max-height: 100px;" />
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-save"></i> Lưu
            </button>
            <a href="<c:url value='/admin/products'/>" class="btn btn-secondary">
                <i class="bi bi-x-circle"></i> Hủy
            </a>
        </div>
    </form>
</div>
<script>
    document.getElementById('productForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.disabled = true;

        const productId = "${product.id}";

        // 1. Lấy dữ liệu từ Form
// Trong sự kiện submit form
        const productData = {
            nameVi: document.getElementById('nameVi').value,
            nameEn: document.getElementById('nameEn').value,
            descriptionVi: document.getElementById('descriptionVi').value,
            descriptionEn: document.getElementById('descriptionEn').value,
            price: parseFloat(document.getElementById('price').value),
            stock: parseInt(document.getElementById('stock').value),
            categoryIds: Array.from(document.getElementById('categoryIds').selectedOptions).map(opt => parseInt(opt.value)),

            // BỔ SUNG TRƯỜNG NÀY:
            // Nếu bạn có input <select id="vendorId"> trong form:
            vendorId: parseInt(document.getElementById('vendorId').value)

            // Hoặc nếu fix cứng ID (nếu chưa có giao diện chọn vendor):
            // vendorId: 1
        };

        // 2. Tạo FormData (Bắt buộc để gửi file)
        const formData = new FormData();

        // Thêm JSON data dưới dạng Blob
        formData.append('product', new Blob([JSON.stringify(productData)], {
            type: 'application/json'
        }));

        // 3. Thêm file hình ảnh từ input
        const fileInput = document.getElementById('files');
        if (fileInput.files.length > 0) {
            for (let i = 0; i < fileInput.files.length; i++) {
                formData.append('files', fileInput.files[i]);
            }
        }

        try {
            let url = '<c:url value="/admin/api/products"/>';
            let method = 'POST';

            if (productId && productId !== "") {
                url += '/' + productId;
                method = 'PUT'; // API Update
            }

            const response = await fetch(url, {
                method: method,
                // KHÔNG set Header Content-Type, trình duyệt sẽ tự set Multipart/Form-Data với Boundary
                body: formData,
                headers: {
                    // Nếu có dùng Spring Security:
                    'X-CSRF-TOKEN': document.querySelector('input[name="_csrf"]')?.value
                }
            });

            if (response.ok) {
                showToast('Lưu sản phẩm thành công!', 'success');
                setTimeout(() => window.location.href = '<c:url value="/admin/products"/>', 1000);
            } else {
                const error = await response.text();
                showToast('Lỗi: ' + error, 'danger');
            }
        } catch (error) {
            showToast('Lỗi kết nối máy chủ', 'danger');
        } finally {
            submitBtn.disabled = false;
        }
    });
</script>
<jsp:include page="/WEB-INF/common/footer.jsp" />
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
