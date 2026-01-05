<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Cập nhật Shop - Vendor</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        </head>

        <body>
            <jsp:include page="/WEB-INF/common/header.jsp" />
            <div class="container-fluid mt-4">
                <div class="row">
                    <div class="col-md-2">
                        <!-- Sidebar placeholder if needed, or just layout spacer -->
                    </div>
                    <div class="col-md-8">
                        <h1 class="mb-4"><i class="bi bi-pencil-square"></i> Cập nhật thông tin Shop</h1>

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger">
                                ${param.error}
                            </div>
                        </c:if>

                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">Thông tin Shop</h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="<c:url value='/vendor/shop/update'/>">
                                    <div class="mb-3">
                                        <label for="storeName" class="form-label">Tên cửa hàng <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="storeName" name="storeName"
                                            value="${vendor.storeName}" required />
                                    </div>

                                    <div class="mb-3">
                                        <label for="descriptionVi" class="form-label">Mô tả (Tiếng Việt)</label>
                                        <textarea class="form-control" id="descriptionVi" name="descriptionVi"
                                            rows="4">${vendor.descriptionVi}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="descriptionEn" class="form-label">Mô tả (Tiếng Anh)</label>
                                        <textarea class="form-control" id="descriptionEn" name="descriptionEn"
                                            rows="4">${vendor.descriptionEn}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="address" class="form-label">Địa chỉ <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="address" name="address"
                                            value="${vendor.address}" required />
                                    </div>

                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Số điện thoại <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="phone" name="phone"
                                            value="${vendor.phone}" required />
                                    </div>

                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-save"></i> Lưu thay đổi
                                        </button>
                                        <a href="<c:url value='/vendor/shop'/>" class="btn btn-secondary">
                                            <i class="bi bi-x-circle"></i> Hủy
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="/WEB-INF/common/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>