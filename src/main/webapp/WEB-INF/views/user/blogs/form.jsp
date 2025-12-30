<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Hero Section -->
<div class="hero-section mb-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 20px; padding: 60px 40px; color: white; text-align: center; margin-top: 30px;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 mx-auto">
                <i class="bi bi-pencil-square display-4 mb-3 animate__animated animate__bounceIn"></i>
                <h1 class="display-4 fw-bold mb-3 animate__animated animate__fadeInUp">
                    ${isEdit ? 'Chỉnh sửa bài viết' : 'Tạo bài viết mới'}
                </h1>
                <p class="lead mb-4 animate__animated animate__fadeInUp animate__delay-1s">
                    ${isEdit ? 'Cập nhật nội dung bài viết của bạn' : 'Chia sẻ kiến thức và câu chuyện về đặc sản Việt Nam'}
                </p>
                <nav aria-label="breadcrumb" class="animate__animated animate__fadeInUp animate__delay-2s">
                    <ol class="breadcrumb justify-content-center bg-white bg-opacity-20 p-2 rounded-pill">
                        <li class="breadcrumb-item">
                            <a href="<c:url value='/user/blogs'/>" class="text-white text-decoration-none">Blog</a>
                        </li>
                        <li class="breadcrumb-item active text-white-50">
                            ${isEdit ? 'Chỉnh sửa' : 'Tạo mới'}
                        </li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="container page-transition">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card shadow-lg animate__animated animate__fadeInUp">
                <div class="card-header bg-gradient-primary text-white">
                    <h4 class="mb-0">
                        <i class="bi bi-pencil-square-fill me-2"></i>
                        ${isEdit ? 'Chỉnh sửa bài viết' : 'Tạo bài viết mới'}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form:form method="post" action="${pageContext.request.contextPath}/user/blogs/save"
                              modelAttribute="blog" enctype="multipart/form-data">

                        <!-- Hidden ID for updates -->
                        <c:if test="${isEdit}">
                            <form:hidden path="id"/>
                        </c:if>

                        <!-- Vietnamese Title -->
                        <div class="mb-4">
                            <label for="titleVi" class="form-label fw-bold">
                                <i class="bi bi-type-h1 text-primary me-2"></i>
                                Tiêu đề tiếng Việt <span class="text-danger">*</span>
                            </label>
                            <form:input path="titleVi" type="text" class="form-control form-control-lg"
                                       placeholder="Nhập tiêu đề hấp dẫn bằng tiếng Việt..." required="true"/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                Tiêu đề nên ngắn gọn, hấp dẫn và chứa từ khóa chính
                            </div>
                            <form:errors path="titleVi" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- English Title -->
                        <div class="mb-4">
                            <label for="titleEn" class="form-label fw-bold">
                                <i class="bi bi-translate text-success me-2"></i>
                                Tiêu đề tiếng Anh
                            </label>
                            <form:input path="titleEn" type="text" class="form-control"
                                       placeholder="Enter title in English..."/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                Phiên bản tiếng Anh của tiêu đề (tùy chọn)
                            </div>
                            <form:errors path="titleEn" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- Vietnamese Summary -->
                        <div class="mb-4">
                            <label for="summaryVi" class="form-label fw-bold">
                                <i class="bi bi-card-text text-warning me-2"></i>
                                Tóm tắt tiếng Việt
                            </label>
                            <form:textarea path="summaryVi" class="form-control" rows="3"
                                          placeholder="Viết một đoạn tóm tắt hấp dẫn về nội dung bài viết..."/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                Tóm tắt sẽ hiển thị ở trang chủ và kết quả tìm kiếm (tối đa 200 ký tự)
                            </div>
                            <form:errors path="summaryVi" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- English Summary -->
                        <div class="mb-4">
                            <label for="summaryEn" class="form-label fw-bold">
                                <i class="bi bi-card-text text-info me-2"></i>
                                Tóm tắt tiếng Anh
                            </label>
                            <form:textarea path="summaryEn" class="form-control" rows="3"
                                          placeholder="Write an engaging summary in English..."/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                English version of the summary (optional)
                            </div>
                            <form:errors path="summaryEn" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- Vietnamese Content -->
                        <div class="mb-4">
                            <label for="contentVi" class="form-label fw-bold">
                                <i class="bi bi-file-earmark-text text-danger me-2"></i>
                                Nội dung tiếng Việt <span class="text-danger">*</span>
                            </label>
                            <form:textarea path="contentVi" class="form-control content-editor" rows="20"
                                          placeholder="Viết nội dung bài viết chi tiết bằng tiếng Việt. Bạn có thể sử dụng HTML để định dạng văn bản." required="true"/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                Hỗ trợ HTML cơ bản: &lt;h1&gt;-&lt;h6&gt;, &lt;p&gt;, &lt;strong&gt;, &lt;em&gt;, &lt;ul&gt;, &lt;ol&gt;, &lt;blockquote&gt;, &lt;img&gt;
                            </div>
                            <form:errors path="contentVi" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- English Content -->
                        <div class="mb-4">
                            <label for="contentEn" class="form-label fw-bold">
                                <i class="bi bi-file-earmark-text text-secondary me-2"></i>
                                Nội dung tiếng Anh
                            </label>
                            <form:textarea path="contentEn" class="form-control content-editor" rows="15"
                                          placeholder="Write detailed content in English. HTML formatting is supported."/>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                English version of the full content (optional)
                            </div>
                            <form:errors path="contentEn" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- Image URL -->
                        <div class="mb-4">
                            <label for="imageUrl" class="form-label fw-bold">
                                <i class="bi bi-image text-success me-2"></i>
                                Hình ảnh đại diện
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-link-45deg"></i>
                                </span>
                                <form:input path="imageUrl" type="url" class="form-control"
                                           placeholder="https://example.com/image.jpg"/>
                            </div>
                            <div class="form-text">
                                <i class="bi bi-info-circle text-muted me-1"></i>
                                URL của hình ảnh đại diện (khuyến nghị: 1200x600px, tối đa 2MB)
                            </div>
                            <form:errors path="imageUrl" cssClass="text-danger fw-bold"/>
                        </div>

                        <!-- Related Products (Optional) -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">
                                <i class="bi bi-tag-fill text-warning me-2"></i>
                                Sản phẩm liên quan (tùy chọn)
                            </label>
                            <div class="card bg-light">
                                <div class="card-body">
                                    <div class="d-flex align-items-start mb-3">
                                        <i class="bi bi-info-circle-fill text-info me-2 mt-1"></i>
                                        <div>
                                            <p class="mb-1 fw-bold">Liên kết sản phẩm với bài viết</p>
                                            <p class="text-muted small mb-0">
                                                Chọn các sản phẩm liên quan để tăng tương tác và chuyển đổi khách hàng thành đơn hàng.
                                            </p>
                                        </div>
                                    </div>
                                    <div id="productSelection" class="mb-3">
                                        <div class="text-center text-muted py-3">
                                            <i class="bi bi-plus-circle display-4 mb-2"></i>
                                            <p>Chưa có sản phẩm nào được chọn</p>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            onclick="loadProducts()" id="addProductBtn">
                                        <i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="d-flex gap-3 mt-5 pt-4 border-top">
                            <button type="submit" class="btn btn-primary btn-lg flex-fill">
                                <i class="bi bi-check-circle-fill me-2"></i>
                                ${isEdit ? 'Cập nhật bài viết' : 'Xuất bản bài viết'}
                            </button>
                            <a href="<c:url value='/user/blogs'/>" class="btn btn-outline-secondary btn-lg">
                                <i class="bi bi-x-circle me-2"></i>Hủy bỏ
                            </a>
                            <c:if test="${isEdit}">
                                <button type="button" class="btn btn-outline-danger btn-lg"
                                        onclick="previewBlog()">
                                    <i class="bi bi-eye me-2"></i>Xem trước
                                </button>
                            </c:if>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Product Selection Modal -->
<div class="modal fade" id="productModal" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header bg-gradient-primary text-white">
                <h5 class="modal-title">
                    <i class="bi bi-tag-fill me-2"></i>Chọn sản phẩm liên quan
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div class="mb-4">
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" id="productSearch" class="form-control form-control-lg"
                               placeholder="Tìm kiếm sản phẩm theo tên...">
                        <span class="input-group-text bg-light text-muted" id="searchCount">
                            Đang tải...
                        </span>
                    </div>
                </div>
                <div id="productList" class="row g-3" style="max-height: 500px; overflow-y: auto;">
                    <div class="col-12 text-center py-5">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Đang tải...</span>
                        </div>
                        <p class="mt-2 text-muted">Đang tải danh sách sản phẩm...</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <small class="text-muted" id="selectedCount">Chưa chọn sản phẩm nào</small>
                    <div>
                        <button type="button" class="btn btn-outline-secondary me-2" data-bs-dismiss="modal">
                            <i class="bi bi-x-circle me-1"></i>Đóng
                        </button>
                        <button type="button" class="btn btn-primary" onclick="addSelectedProducts()" id="addBtn">
                            <i class="bi bi-plus-circle me-1"></i>Thêm vào bài viết
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Hero Section */
.hero-section {
    position: relative;
    overflow: hidden;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
    background-size: 50px 50px;
    animation: float 20s infinite linear;
}

@keyframes float {
    0% { transform: translate(-50%, -50%) rotate(0deg); }
    100% { transform: translate(-50%, -50%) rotate(360deg); }
}

/* Form Styling */
.form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    transform: scale(1.02);
    transition: all 0.3s ease;
}

.form-control-lg:focus {
    transform: scale(1.01);
}

.form-label {
    margin-bottom: 0.75rem;
    font-size: 1rem;
}

.form-text {
    font-size: 0.875rem;
    margin-top: 0.5rem;
}

/* Content Editor */
.content-editor {
    font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
    line-height: 1.6;
    resize: vertical;
    min-height: 300px;
}

.content-editor:focus {
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    border-color: #667eea;
}

/* Card Styling */
.card {
    border: none;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 30px rgba(0,0,0,0.12);
}

.card-header {
    border-radius: 15px 15px 0 0 !important;
    border: none;
    padding: 1.5rem;
}

.bg-gradient-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

/* Product Selection */
.product-item {
    background: white;
    border: 2px solid rgba(102, 126, 234, 0.1);
    border-radius: 10px;
    padding: 1rem;
    margin-bottom: 0.75rem;
    transition: all 0.3s ease;
    position: relative;
}

.product-item:hover {
    border-color: #667eea;
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
}

.product-item.selected {
    border-color: #667eea;
    background: rgba(102, 126, 234, 0.05);
}

.product-item .form-check-input:checked {
    background-color: #667eea;
    border-color: #667eea;
}

/* Selected Products */
.selected-product {
    background: linear-gradient(135deg, #f8f9ff 0%, #e8f2ff 100%);
    border: 1px solid #667eea;
    border-radius: 8px;
    padding: 0.75rem;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    animation: slideInRight 0.3s ease;
}

.selected-product .product-info {
    flex: 1;
}

.selected-product .product-name {
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 0.25rem;
}

.selected-product .product-price {
    color: #667eea;
    font-weight: 500;
    font-size: 0.875rem;
}

@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Modal Styling */
.modal-content {
    border-radius: 15px;
    border: none;
    box-shadow: 0 10px 40px rgba(0,0,0,0.2);
}

.modal-header {
    border-radius: 15px 15px 0 0 !important;
}

/* Button Styling */
.btn {
    border-radius: 8px;
    font-weight: 500;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.btn-primary:hover {
    background: linear-gradient(135deg, #5a67d8 0%, #764ba2 100%);
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.btn-outline-primary:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
}

/* Responsive */
@media (max-width: 768px) {
    .hero-section {
        padding: 40px 20px;
        margin-top: 20px;
    }

    .hero-section .display-4 {
        font-size: 2rem;
    }

    .content-editor {
        min-height: 250px;
    }

    .modal-dialog {
        margin: 0.5rem;
    }
}

/* Loading States */
.loading {
    opacity: 0.6;
    pointer-events: none;
}

.spinner-border {
    width: 1rem;
    height: 1rem;
}

/* Error States */
.text-danger {
    font-size: 0.875rem;
    margin-top: 0.5rem;
}

/* Success States */
.text-success {
    font-size: 0.875rem;
}

/* Info Text */
.form-text {
    color: #6c757d !important;
}

/* Input Group */
.input-group-text {
    background: rgba(102, 126, 234, 0.1);
    border-color: #667eea;
    color: #667eea;
}

/* Badge */
.badge {
    font-size: 0.75rem;
    padding: 0.375rem 0.75rem;
}
</style>

<script>
let selectedProducts = [];
let allProducts = [];

function loadProducts() {
    const addBtn = document.getElementById('addProductBtn');
    addBtn.innerHTML = '<i class="bi bi-hourglass-split me-1"></i>Đang tải...';
    addBtn.disabled = true;

    fetch('<c:url value="/user/products/search"/>?limit=100')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            allProducts = data;
            showProductModal(data);
            updateSearchCount(data.length);
        })
        .catch(error => {
            console.error('Error loading products:', error);
            showError('Không thể tải danh sách sản phẩm. Vui lòng thử lại.');
        })
        .finally(() => {
            addBtn.innerHTML = '<i class="bi bi-plus-circle me-1"></i>Thêm sản phẩm';
            addBtn.disabled = false;
        });
}

function showProductModal(products) {
    const modal = new bootstrap.Modal(document.getElementById('productModal'));
    const productList = document.getElementById('productList');

    productList.innerHTML = products.map(product => `
        <div class="col-md-6 col-lg-4">
            <div class="product-item" onclick="toggleProductSelection(${product.id}, this)">
                <div class="form-check mb-2">
                    <input class="form-check-input" type="checkbox" value="${product.id}" id="product${product.id}">
                    <label class="form-check-label w-100" for="product${product.id}">
                        <div class="d-flex align-items-start">
                            <div class="flex-shrink-0 me-2">
                                ${product.imageUrls && product.imageUrls.length > 0
                                    ? `<img src="${product.imageUrls[0]}" alt="${product.nameVi}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">`
                                    : `<div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;"><i class="bi bi-image text-muted"></i></div>`
                                }
                            </div>
                            <div class="flex-grow-1">
                                <div class="fw-bold text-truncate" title="${product.nameVi}">${product.nameVi}</div>
                                <div class="text-primary fw-bold">${product.price.toLocaleString()}₫</div>
                                <small class="text-muted">${product.categoryNameVi || 'Chưa phân loại'}</small>
                            </div>
                        </div>
                    </label>
                </div>
            </div>
        </div>
    `).join('');

    modal.show();
}

function toggleProductSelection(productId, element) {
    const checkbox = element.querySelector(`input[type="checkbox"]`);
    checkbox.checked = !checkbox.checked;

    if (checkbox.checked) {
        element.classList.add('selected');
    } else {
        element.classList.remove('selected');
    }

    updateSelectedCount();
}

function updateSelectedCount() {
    const selectedCount = document.querySelectorAll('#productList input[type="checkbox"]:checked').length;
    document.getElementById('selectedCount').textContent =
        `Đã chọn ${selectedCount} sản phẩm${selectedCount !== 1 ? '' : ''}`;
}

function updateSearchCount(total) {
    document.getElementById('searchCount').textContent = `${total} sản phẩm`;
}

function addSelectedProducts() {
    const checkedBoxes = document.querySelectorAll('#productList input[type="checkbox"]:checked');
    const productSelection = document.getElementById('productSelection');

    if (checkedBoxes.length === 0) {
        showError('Vui lòng chọn ít nhất một sản phẩm!');
        return;
    }

    // Clear existing selection display
    const existingDisplay = productSelection.querySelector('.text-center');
    if (existingDisplay) {
        existingDisplay.remove();
    }

    checkedBoxes.forEach(checkbox => {
        const productId = checkbox.value;
        const product = allProducts.find(p => p.id == productId);

        if (product && !selectedProducts.includes(productId)) {
            selectedProducts.push(productId);

            const productElement = document.createElement('div');
            productElement.className = 'selected-product';
            productElement.innerHTML = `
                <div class="product-info">
                    <div class="product-name">${product.nameVi}</div>
                    <div class="product-price">${product.price.toLocaleString()}₫</div>
                </div>
                <button type="button" class="btn btn-sm btn-outline-danger"
                        onclick="removeProduct('${productId}', this)">
                    <i class="bi bi-x"></i>
                </button>
                <input type="hidden" name="productIds" value="${productId}">
            `;

            productSelection.appendChild(productElement);
        }
    });

    bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();
    updateSelectedCount();
}

function removeProduct(productId, element) {
    selectedProducts = selectedProducts.filter(id => id !== productId);
    element.closest('.selected-product').remove();

    // If no products left, show empty message
    const productSelection = document.getElementById('productSelection');
    if (productSelection.children.length === 0) {
        productSelection.innerHTML = `
            <div class="text-center text-muted py-3">
                <i class="bi bi-plus-circle display-4 mb-2"></i>
                <p>Chưa có sản phẩm nào được chọn</p>
            </div>
        `;
    }
}

// Product search
document.getElementById('productSearch')?.addEventListener('input', function() {
    const searchTerm = this.value.toLowerCase().trim();
    const productItems = document.querySelectorAll('#productList .product-item');

    let visibleCount = 0;
    productItems.forEach(item => {
        const productName = item.querySelector('.fw-bold').textContent.toLowerCase();
        const categoryName = item.querySelector('.text-muted').textContent.toLowerCase();

        if (productName.includes(searchTerm) || categoryName.includes(searchTerm)) {
            item.style.display = 'block';
            visibleCount++;
        } else {
            item.style.display = 'none';
        }
    });

    updateSearchCount(visibleCount);
});

function previewBlog() {
    // Basic preview functionality
    const title = document.getElementById('titleVi').value;
    const summary = document.getElementById('summaryVi').value;
    const content = document.getElementById('contentVi').value;

    if (!title || !content) {
        showError('Vui lòng nhập tiêu đề và nội dung trước khi xem trước!');
        return;
    }

    // Open preview in new window
    const previewWindow = window.open('', '_blank');
    previewWindow.document.write(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Preview: ${title}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body class="bg-light">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <h1 class="display-4 mb-3">${title}</h1>
                                ${summary ? `<p class="lead text-muted mb-4">${summary}</p>` : ''}
                                <div>${content.replace(/\n/g, '<br>')}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        </html>
    `);
}

function showError(message) {
    // Create and show error alert
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-danger alert-dismissible fade show position-fixed';
    alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    alertDiv.innerHTML = `
        <i class="bi bi-exclamation-triangle-fill me-2"></i>${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;

    document.body.appendChild(alertDiv);

    // Auto remove after 5 seconds
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 5000);
}

// Form validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');

    form.addEventListener('submit', function(e) {
        const titleVi = document.getElementById('titleVi').value.trim();
        const contentVi = document.getElementById('contentVi').value.trim();

        if (!titleVi) {
            e.preventDefault();
            showError('Vui lòng nhập tiêu đề tiếng Việt!');
            document.getElementById('titleVi').focus();
            return;
        }

        if (!contentVi) {
            e.preventDefault();
            showError('Vui lòng nhập nội dung tiếng Việt!');
            document.getElementById('contentVi').focus();
            return;
        }

        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang xử lý...';
        submitBtn.disabled = true;
    });

    // Auto-save draft (optional enhancement)
    let autoSaveTimer;
    const contentFields = ['titleVi', 'titleEn', 'summaryVi', 'summaryEn', 'contentVi', 'contentEn'];

    contentFields.forEach(fieldId => {
        const field = document.getElementById(fieldId);
        if (field) {
            field.addEventListener('input', function() {
                clearTimeout(autoSaveTimer);
                autoSaveTimer = setTimeout(() => {
                    // Could implement auto-save to localStorage here
                    console.log('Content changed, could auto-save draft');
                }, 1000);
            });
        }
    });
});
</script>
