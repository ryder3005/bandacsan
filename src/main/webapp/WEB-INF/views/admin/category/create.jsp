<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="container-fluid py-4">
  <div class="row justify-content-center">
    <div class="col-lg-8">
      <div class="card">
        <div class="card-header bg-primary text-white">
          <h3 class="mb-0">
            <i class="fas fa-plus-circle"></i> Thêm mới Danh mục
          </h3>
        </div>
        <div class="card-body">
          <form:form method="post"
                     action="${pageContext.request.contextPath}/admin/categories/save"
                     modelAttribute="category">

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
              <small class="form-text text-muted">
                Nhập đường dẫn URL của hình ảnh
              </small>
            </div>

            <div class="mb-3">
              <label for="user" class="form-label">
                Người tạo <span class="text-danger">*</span>
              </label>
              <form:select path="user.username" class="form-select" id="user" required="true">
                <option value="">-- Chọn người dùng --</option>
                <c:forEach var="u" items="${users}">
                  <option value="${u.username}">${u.username} - ${u.fullname}</option>
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
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Lưu
              </button>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>