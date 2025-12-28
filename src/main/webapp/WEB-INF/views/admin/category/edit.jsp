<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container-fluid py-4">
  <div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="card">
        <div class="card-header bg-warning text-dark">
          <h3 class="mb-0">
            <i class="fas fa-edit"></i> Chỉnh sửa Danh mục
          </h3>
        </div>
        <div class="card-body">
          <form:form method="post"
                     action="${pageContext.request.contextPath}/admin/categories/save"
                     modelAttribute="category">

            <form:hidden path="id"/>

            <div class="mb-3">
              <label class="form-label">ID</label>
              <input type="text" class="form-control-plaintext"
                     readonly value="${category.id}">
            </div>

            <div class="mb-3">
              <label for="categoryName" class="form-label">
                Tên danh mục <span class="text-danger">*</span>
              </label>
              <form:input path="categoryName"
                          class="form-control"
                          id="categoryName"
                          placeholder="Nhập tên danh mục"
                          required="true"/>
            </div>

            <div class="mb-3">
              <label for="categorycode" class="form-label">
                Mã danh mục <span class="text-danger">*</span>
              </label>
              <form:input path="categorycode"
                          class="form-control"
                          id="categorycode"
                          placeholder="Nhập mã danh mục"
                          required="true"/>
              <small class="form-text text-muted">
                Mã danh mục không chứa khoảng trắng, ký tự đặc biệt
              </small>
            </div>

            <div class="mb-3">
              <label for="images" class="form-label">URL Hình ảnh</label>
              <form:input path="images"
                          class="form-control"
                          id="images"
                          placeholder="https://example.com/image.jpg"/>

              <!-- Preview hình ảnh nếu có -->
              <c:if test="${not empty category.images}">
                <div class="mt-2">
                  <img src="${category.images}"
                       class="img-thumbnail"
                       style="max-width: 200px;"
                       alt="Preview">
                </div>
              </c:if>
            </div>

            <div class="mb-3">
              <label for="user" class="form-label">
                Người tạo <span class="text-danger">*</span>
              </label>
              <form:select path="user.username" class="form-select" id="user" required="true">
                <option value="">-- Chọn người dùng --</option>
                <c:forEach var="u" items="${users}">
                  <option value="${u.username}"
                    ${category.user.username == u.username ? 'selected' : ''}>
                      ${u.username} - ${u.fullname}
                  </option>
                </c:forEach>
              </form:select>
            </div>

            <div class="mb-3">
              <div class="form-check form-switch">
                <form:checkbox path="status"
                               class="form-check-input"
                               id="status"/>
                <label class="form-check-label" for="status">
                  Trạng thái hoạt động
                </label>
              </div>
            </div>

            <hr>

            <div class="d-flex justify-content-between">
              <a href="${pageContext.request.contextPath}/admin/categories"
                 class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay lại
              </a>
              <div>
                <button type="button" class="btn btn-danger me-2"
                        onclick="confirmDelete(${category.id})">
                  <i class="fas fa-trash"></i> Xóa
                </button>
                <button type="submit" class="btn btn-warning">
                  <i class="fas fa-save"></i> Cập nhật
                </button>
              </div>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Form xóa ẩn -->
<form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/categories/delete">
  <input type="hidden" name="id" id="deleteId">
</form>

<script>
  function confirmDelete(id) {
    if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
      document.getElementById('deleteId').value = id;
      document.getElementById('deleteForm').submit();
    }
  }
</script>