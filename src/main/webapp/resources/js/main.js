// document.querySelectorAll('.add-to-cart-btn').forEach(button => {
//     button.addEventListener('click', function() {
//         const product = {
//             id: this.dataset.id,
//             name: this.dataset.name,
//             price: this.dataset.price,
//             image: this.dataset.image,
//             quantity: 1
//         };
//
//         // Kiểm tra trạng thái đăng nhập (giả sử có biến global từ session)
//         const isLoggedIn = ${sessionScope.user != null ? 'true' : 'false'};
//
//         if (isLoggedIn) {
//             addToCartServer(product);
//         } else {
//             addToCartLocal(product);
//         }
//     });
// });
//
// // Xử lý cho người dùng chưa đăng nhập (LocalStorage)
// function addToCartLocal(product) {
//     let cart = JSON.parse(localStorage.getItem('cart')) || [];
//     const index = cart.findIndex(item => item.id === product.id);
//
//     if (index > -1) {
//         cart[index].quantity += 1;
//     } else {
//         cart.push(product);
//     }
//
//     localStorage.setItem('cart', JSON.stringify(cart));
//     alert('Đã thêm vào giỏ hàng (Local)!');
//     updateCartBadge(); // Hàm cập nhật số lượng trên header
// }
//
// // Xử lý cho người dùng đã đăng nhập (AJAX tới Controller)
// function addToCartServer(product) {
//     fetch('<c:url value="/user/cart/add"/>', {
//         method: 'POST',
//         headers: { 'Content-Type': 'application/json' },
//         body: JSON.stringify({
//             productId: product.id,
//             quantity: 1
//         })
//     })
//         .then(res => res.json())
//         .then(data => {
//             alert('Đã thêm vào giỏ hàng hệ thống!');
//             // Cập nhật số lượng từ response của server
//         })
//         .catch(err => console.error('Lỗi:', err));
// }

// Order Status Widget Functions
function loadOrderStatusWidget() {
    const widgetContainer = document.getElementById('order-status-widget-container');
    if (!widgetContainer) {
        console.log('Widget container not found');
        return;
    }

    console.log('Loading order status widget...');
    // Show loading
    widgetContainer.innerHTML = '<div class="text-center text-muted small">Đang tải...</div>';

    // Determine endpoint based on user role from global variable
    const userRole = window.userRole || '';
    const endpoint = userRole === 'VENDOR' ? '/vendor/my-orders/status/summary' : '/user/orders/status/summary';

    // Fetch order status data
    fetch(endpoint)
        .then(response => {
            console.log('Response status:', response.status);
            if (!response.ok) {
                throw new Error('Network response was not ok: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('Order data received:', data);
            if (data.error) {
                widgetContainer.innerHTML = '<div class="error">Không thể tải dữ liệu: ' + data.error + '</div>';
                return;
            }
            renderOrderStatusWidget(data);
        })
        .catch(error => {
            console.error('Error loading order status:', error);
            widgetContainer.innerHTML = '<div class="error">Lỗi kết nối: ' + error.message + '</div>';
        });
}

function renderOrderStatusWidget(data) {
    const widgetContainer = document.getElementById('order-status-widget-container');
    const badge = document.getElementById('order-status-badge');
    
    const statusConfig = [
        { key: 'pending', label: 'Chờ xử lý', icon: '⏳' },
        { key: 'processing', label: 'Đang xử lý', icon: '⚙️' },
        { key: 'shipping', label: 'Đang giao', icon: '🚚' },
        { key: 'delivered', label: 'Đã giao', icon: '✅' },
        { key: 'cancelled', label: 'Đã hủy', icon: '❌' }
    ];

    // Update badge
    if (badge) {
        const total = data.total || 0;
        badge.textContent = total;
        badge.style.display = total > 0 ? 'inline-block' : 'none';
    }

    let html = '';
    statusConfig.forEach(status => {
        const count = data[status.key] || 0;
        html += `
            <div class="status-item">
                <span class="status-label">
                    <span class="status-icon">${status.icon}</span>
                    <span>${status.label}</span>
                </span>
                <span class="status-count">${count}</span>
            </div>
        `;
    });

    html += `
        <div class="total-orders">
            Tổng: ${data.total || 0} đơn hàng
        </div>
    `;

    widgetContainer.innerHTML = html;
}

function refreshOrderStatus() {
    loadOrderStatusWidget();
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM Content Loaded');
    // Load order status widget if user is logged in
    const widgetContainer = document.getElementById('order-status-widget-container');
    console.log('Widget container found:', !!widgetContainer);
    if (widgetContainer) {
        loadOrderStatusWidget();
        
        // Auto refresh every 2 minutes
        setInterval(loadOrderStatusWidget, 120000);
    }
});