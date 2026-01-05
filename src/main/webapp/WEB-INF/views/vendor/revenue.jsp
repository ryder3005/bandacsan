<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê Doanh thu - Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />
<div class="container-fluid mt-4">
    <h1 class="mb-4"><i class="bi bi-cash-coin"></i> Thống kê Doanh thu</h1>
    
    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cash-stack"></i> Tổng doanh thu</h5>
                    <h3 class="mb-0"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/> VNĐ</h3>
                    <small>Tổng doanh thu tất cả thời gian</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-calendar-month"></i> Doanh thu tháng này</h5>
                    <h3 class="mb-0"><fmt:formatNumber value="${monthlyRevenue != null ? monthlyRevenue : 0}" pattern="#,##0"/> VNĐ</h3>
                    <small>Doanh thu trong tháng hiện tại</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-calendar-week"></i> Doanh thu tuần này</h5>
                    <h3 class="mb-0"><fmt:formatNumber value="${weeklyRevenue != null ? weeklyRevenue : 0}" pattern="#,##0"/> VNĐ</h3>
                    <small>Doanh thu trong tuần hiện tại</small>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-cart-check"></i> Tổng đơn hàng</h5>
                    <h3 class="mb-0">${totalDeliveredOrders}</h3>
                    <small>Tổng số đơn hàng đã giao</small>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-bar-chart"></i> Lịch sử doanh thu</h5>
                    <div>
                        <select class="form-select form-select-sm" style="width: auto; display: inline-block;">
                            <option>Tháng này</option>
                            <option>Tháng trước</option>
                            <option>3 tháng gần nhất</option>
                            <option>Tất cả</option>
                        </select>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Bảng lịch sử -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="table-light">
                            <tr>
                                <th width="10%">ID</th>
                                <th width="20%">Ngày</th>
                                <th width="20%">Số đơn hàng</th>
                                <th width="25%">Doanh thu</th>
                                <th width="25%">Ghi chú</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${totalRevenue > 0}">
                                    <tr>
                                        <td>1</td>
                                        <td><%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) %></td>
                                        <td>${totalDeliveredOrders}</td>
                                        <td><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/> VNĐ</td>
                                        <td>Tổng doanh thu từ các đơn hàng đã giao</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                                            <h4 class="mt-3 text-muted">Chưa có dữ liệu</h4>
                                            <p class="text-muted">Chưa có dữ liệu doanh thu.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Biểu đồ doanh thu -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bi bi-graph-up"></i> Biểu đồ doanh thu</h5>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-sm btn-outline-primary active" id="btnMonthly" onclick="showMonthlyChart()">
                            <i class="bi bi-calendar-month"></i> Theo tháng
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-primary" id="btnWeekly" onclick="showWeeklyChart()">
                            <i class="bi bi-calendar-week"></i> Theo tuần
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div style="position: relative; height: 400px;">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Dữ liệu từ server - sử dụng JSON từ backend
    let monthlyData = {
        labels: [],
        values: []
    };
    let weeklyData = {
        labels: [],
        values: []
    };

    <c:if test="${not empty monthlyRevenueDataJson}">
    try {
        const monthlyJson = ${monthlyRevenueDataJson};
        monthlyData.labels = Object.keys(monthlyJson);
        monthlyData.values = Object.values(monthlyJson);
    } catch (e) {
        console.error('Error parsing monthly revenue data:', e);
    }
    </c:if>

    <c:if test="${not empty weeklyRevenueDataJson}">
    try {
        const weeklyJson = ${weeklyRevenueDataJson};
        weeklyData.labels = Object.keys(weeklyJson);
        weeklyData.values = Object.values(weeklyJson);
    } catch (e) {
        console.error('Error parsing weekly revenue data:', e);
    }
    </c:if>

    console.log('Monthly Data:', monthlyData);
    console.log('Weekly Data:', weeklyData);

    let revenueChart = null;

    function initChart(data, type) {
        const ctx = document.getElementById('revenueChart');
        
        if (revenueChart) {
            revenueChart.destroy();
        }

        if (!data || !data.labels || data.labels.length === 0) {
            console.error('No data available for chart');
            return;
        }

        revenueChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: data.values,
                    borderColor: 'rgb(102, 126, 234)',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: 'rgb(102, 126, 234)',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    pointHoverRadius: 7
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return 'Doanh thu: ' + new Intl.NumberFormat('vi-VN').format(context.parsed.y) + ' VNĐ';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return new Intl.NumberFormat('vi-VN', {maximumFractionDigits: 0}).format(value);
                            }
                        }
                    }
                }
            }
        });
    }

    function showMonthlyChart() {
        document.getElementById('btnMonthly').classList.add('active');
        document.getElementById('btnWeekly').classList.remove('active');
        initChart(monthlyData, 'monthly');
    }

    function showWeeklyChart() {
        document.getElementById('btnWeekly').classList.add('active');
        document.getElementById('btnMonthly').classList.remove('active');
        initChart(weeklyData, 'weekly');
    }

    // Khởi tạo biểu đồ với dữ liệu theo tháng
    document.addEventListener('DOMContentLoaded', function() {
        // Đợi một chút để đảm bảo Chart.js đã load
        setTimeout(function() {
            if (monthlyData && monthlyData.labels && monthlyData.labels.length > 0) {
                showMonthlyChart();
            } else if (weeklyData && weeklyData.labels && weeklyData.labels.length > 0) {
                showWeeklyChart();
            } else {
                // Vẫn hiển thị biểu đồ với dữ liệu trống
                showMonthlyChart();
            }
        }, 100);
    });
</script>
</body>
</html>
