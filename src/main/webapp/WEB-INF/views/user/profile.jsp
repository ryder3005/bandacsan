<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-person-circle"></i> Thông tin cá nhân</h1>
    
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-info-circle"></i> Thông tin tài khoản</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty user}">
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="bi bi-check-circle"></i> ${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-triangle"></i> ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Thông tin hiện tại -->
                            <div class="mb-4">
                                <table class="table table-bordered">
                                    <tr>
                                        <th style="width: 200px;">Username</th>
                                        <td><strong><c:out value="${user.username}"/></strong></td>
                                    </tr>
                                    <tr>
                                        <th>Email</th>
                                        <td><c:out value="${user.email}"/></td>
                                    </tr>
                                    <tr>
                                        <th>Vai trò</th>
                                        <td>
                                            <span class="badge bg-primary">
                                                <c:choose>
                                                    <c:when test="${user.role == 'ADMIN'}">Quản trị viên</c:when>
                                                    <c:when test="${user.role == 'VENDOR'}">Nhà bán hàng</c:when>
                                                    <c:otherwise>Khách hàng</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Form chỉnh sửa -->
                            <div class="mt-4">
                                <h5 class="mb-3"><i class="bi bi-pencil-square"></i> Chỉnh sửa thông tin</h5>
                                <form method="post" action="<c:url value='/profile/update'/>" id="profileForm">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <input type="hidden" name="username" value="${user.username}">
                                    <input type="hidden" name="role" value="${user.role}">
                                    <input type="hidden" name="redirectUrl" id="redirectUrl" value="">
                                    
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               value="<c:out value='${user.email}'/>" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Mật khẩu mới</label>
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Để trống nếu không muốn đổi mật khẩu" 
                                               minlength="6">
                                        <small class="form-text text-muted">Chỉ nhập nếu muốn đổi mật khẩu (tối thiểu 6 ký tự)</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                               placeholder="Xác nhận mật khẩu mới">
                                    </div>
                                    
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-save"></i> Lưu thay đổi
                                        </button>
                                        <a href="javascript:history.back()" class="btn btn-secondary">
                                            <i class="bi bi-x-circle"></i> Hủy
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning">
                                <i class="bi bi-exclamation-triangle"></i> Bạn chưa đăng nhập hoặc thông tin không có sẵn.
                                <a href="<c:url value='/login'/>" class="alert-link">Đăng nhập ngay</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="bi bi-lightning"></i> Thao tác nhanh</h5>
                </div>
                <div class="card-body">
                    <a href="<c:url value='/user/home'/>" class="btn btn-outline-primary w-100 mb-2">
                        <i class="bi bi-house"></i> Về trang chủ
                    </a>
                    <a href="<c:url value='/user/products'/>" class="btn btn-outline-success w-100 mb-2">
                        <i class="bi bi-box-seam"></i> Xem sản phẩm
                    </a>
                    <a href="<c:url value='/user/categories'/>" class="btn btn-outline-info w-100">
                        <i class="bi bi-tags"></i> Xem danh mục
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Set redirect URL when form loads
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('profileForm');
        if (form) {
            // Lưu URL hiện tại trước khi submit (không phải trang profile)
            const currentUrl = window.location.href;
            if (!currentUrl.includes('/profile')) {
                document.getElementById('redirectUrl').value = currentUrl;
            } else {
                // Nếu đang ở trang profile, lấy referer
                const referer = document.referrer;
                if (referer && !referer.includes('/profile')) {
                    document.getElementById('redirectUrl').value = referer;
                }
            }
        }
        
        // Show toast messages from flash attributes
        <c:if test="${not empty successMessage}">
            if (typeof showToast === 'function') {
                showToast('${successMessage}', 'success');
            }
        </c:if>
        <c:if test="${not empty errorMessage}">
            if (typeof showToast === 'function') {
                showToast('${errorMessage}', 'danger');
            }
        </c:if>
    });
    
    // Validate password confirmation
    document.querySelector('#profileForm')?.addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (password && password !== confirmPassword) {
            e.preventDefault();
            if (typeof showToast === 'function') {
                showToast('Mật khẩu xác nhận không khớp!', 'danger');
            } else {
                alert('Mật khẩu xác nhận không khớp!');
            }
            return false;
        }
        
        if (password && password.length < 6) {
            e.preventDefault();
            if (typeof showToast === 'function') {
                showToast('Mật khẩu phải có ít nhất 6 ký tự!', 'danger');
            } else {
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
            }
            return false;
        }
    });
</script>
</body>
</html>
