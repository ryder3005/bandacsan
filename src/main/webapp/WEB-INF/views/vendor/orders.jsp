<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<jsp:include page="/WEB-INF/common/toast-handler.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-cart-check"></i> Quản lý Đơn hàng</h1>
    
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
    
    <!-- Stats Card -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cart"></i> Tổng đơn hàng</h5>
                    <h3 class="mb-0">${totalOrders}</h3>
                    <small>Tổng số đơn hàng</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-check-circle"></i> Đã giao</h5>
                    <h3 class="mb-0">${deliveredCount}</h3>
                    <small>Đơn hàng đã giao</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-clock"></i> Chờ xử lý</h5>
                    <h3 class="mb-0">${pendingCount}</h3>
                    <small>Đơn hàng chờ xử lý</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <a href="<c:url value='/vendor/revenue'/>" class="text-decoration-none">
                <div class="card text-white bg-info" style="cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                    <div class="card-body">
                        <h5 class="card-title"><i class="bi bi-cash-coin"></i> Tổng doanh thu</h5>
                        <h3 class="mb-0"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/> VNĐ</h3>
                        <small>Nhấn để xem chi tiết</small>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Filter Tabs -->
    <div class="filter-tabs mb-4" style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
        <div class="d-flex justify-content-center">
            <button class="filter-tab active" onclick="filterOrders('all')">Tất cả</button>
            <button class="filter-tab" onclick="filterOrders('PENDING')">Chờ xử lý</button>
            <button class="filter-tab" onclick="filterOrders('SHIPPING')">Đang giao</button>
            <button class="filter-tab" onclick="filterOrders('DELIVERED')">Đã giao</button>
            <button class="filter-tab" onclick="filterOrders('CANCELLED')">Đã hủy</button>
        </div>
    </div>

    <style>
        .filter-tabs {
            margin-bottom: 20px;
        }
        .filter-tab {
            padding: 10px 20px;
            margin: 0 5px;
            border: 2px solid #e0e0e0;
            background: white;
            color: #666;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .filter-tab:hover {
            border-color: #667eea;
            color: #667eea;
        }
        .filter-tab.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: #667eea;
            color: white;
        }
    </style>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-cart-check"></i> Danh sách đơn hàng</h5>
                </div>
                <div class="card-body">
                    <!-- Bảng danh sách -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="5%">ID</th>
                                <th width="20%">Khách hàng</th>
                                <th width="15%">Tổng tiền</th>
                                <th width="15%">Trạng thái</th>
                                <th width="20%">Ngày đặt</th>
                                <th width="25%">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody id="ordersTableBody">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có đơn hàng</h4>
                                            <p class="text-muted">Chưa có đơn hàng nào trong hệ thống.</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="order" items="${orders}">
                                        <tr data-status="${order.status}">
                                            <td>${order.id}</td>
                                            <td><strong>${order.userName}</strong></td>
                                            <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="badge bg-warning">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'PROCESSING'}">
                                                        <span class="badge bg-info">Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                        <span class="badge bg-primary">Đang giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">
                                                        <span class="badge bg-success">Đã giao</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">
                                                        <span class="badge bg-danger">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty order.createdAt}">
                                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-2">
                                                    <a href="<c:url value='/vendor/orders/${order.id}'/>" class="btn btn-sm btn-outline-primary">
                                                        <i class="bi bi-eye"></i> Xem chi tiết
                                                    </a>
                                                    <c:if test="${order.status == 'PENDING'}">
                                                        <form method="post" action="<c:url value='/vendor/orders/${order.id}/confirm'/>" style="display: inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng này? Đơn hàng sẽ chuyển sang trạng thái đang giao.');">
                                                            <button type="submit" class="btn btn-sm btn-success">
                                                                <i class="bi bi-check-circle"></i> Xác nhận đơn hàng
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
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

    <script>
        function filterOrders(status) {
            // Update active tab
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            event.target.classList.add('active');

            // Filter rows
            const rows = document.querySelectorAll('#ordersTableBody tr[data-status]');
            rows.forEach(row => {
                if (status === 'all' || row.getAttribute('data-status') === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            // Check if no rows visible
            const visibleRows = Array.from(rows).filter(row => row.style.display !== 'none');
            const emptyRow = document.querySelector('#ordersTableBody tr:not([data-status])');
            if (visibleRows.length === 0 && emptyRow) {
                emptyRow.style.display = '';
            } else if (emptyRow) {
                emptyRow.style.display = 'none';
            }
        }
    </script>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
