<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

        <!-- Floating Widgets Container -->
        <div class="floating-widgets">
            <!-- Cart Widget - For USER, ADMIN, and VENDOR -->
            <c:if test="${not empty sessionScope.user}">
                <div class="floating-widget cart-widget" id="cartWidget">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'VENDOR'}">
                            <a href="<c:url value='/vendor/cart'/>" class="widget-button" title="Giỏ hàng">
                                <i class="bi bi-cart3"></i>
                                <span class="widget-badge" id="cartBadge">0</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/user/cart'/>" class="widget-button" title="Giỏ hàng">
                                <i class="bi bi-cart3"></i>
                                <span class="widget-badge" id="cartBadge">0</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Chat Widget - For both USER and VENDOR -->
            <c:if test="${not empty sessionScope.user}">
                <div class="floating-widget chat-widget" id="chatWidget">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'VENDOR'}">
                            <a href="<c:url value='/vendor/chat'/>" class="widget-button" title="Tin nhắn">
                                <i class="bi bi-chat-dots"></i>
                                <span class="widget-badge" id="chatBadge" style="display: none;">0</span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/user/chat'/>" class="widget-button" title="Tin nhắn">
                                <i class="bi bi-chat-dots"></i>
                                <span class="widget-badge" id="chatBadge" style="display: none;">0</span>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <style>
            .floating-widgets {
                position: fixed;
                bottom: 30px;
                right: 30px;
                z-index: 1000;
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .floating-widget {
                position: relative;
            }

            .widget-button {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease;
                font-size: 24px;
                position: relative;
            }

            .cart-widget .widget-button {
                background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            }

            .widget-button:hover {
                transform: translateY(-5px) scale(1.1);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
                color: white;
            }

            .widget-badge {
                position: absolute;
                top: -5px;
                right: -5px;
                background: #dc3545;
                color: white;
                border-radius: 50%;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 12px;
                font-weight: bold;
                border: 2px solid white;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                }

                50% {
                    transform: scale(1.1);
                }
            }

            /* Responsive */
            @media (max-width: 768px) {
                .floating-widgets {
                    bottom: 20px;
                    right: 20px;
                }

                .widget-button {
                    width: 50px;
                    height: 50px;
                    font-size: 20px;
                }

                .widget-badge {
                    width: 20px;
                    height: 20px;
                    font-size: 10px;
                }
            }
        </style>

        <script>
            // Update cart badge count
            async function updateCartBadge() {
                try {
                    const response = await fetch('<c:url value="/user/cart"/>');
                    if (response.ok) {
                        const text = await response.text();
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(text, 'text/html');

                        // Try to find cart item count from the page
                        const cartItems = doc.querySelectorAll('.cart-item');
                        const count = cartItems.length;

                        const badge = document.getElementById('cartBadge');
                        if (badge) {
                            badge.textContent = count;
                            badge.style.display = count > 0 ? 'flex' : 'none';
                        }
                    }
                } catch (error) {
                    console.error('Error updating cart badge:', error);
                }
            }

            // Update chat badge count
            async function updateChatBadge() {
                try {
                    const response = await fetch('<c:url value="/user/chat"/>');
                    if (response.ok) {
                        const text = await response.text();
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(text, 'text/html');

                        // Count unread messages
                        const unreadBadges = doc.querySelectorAll('.unread-count');
                        let totalUnread = 0;
                        unreadBadges.forEach(badge => {
                            const count = parseInt(badge.textContent) || 0;
                            totalUnread += count;
                        });

                        const chatBadge = document.getElementById('chatBadge');
                        if (chatBadge) {
                            chatBadge.textContent = totalUnread;
                            chatBadge.style.display = totalUnread > 0 ? 'flex' : 'none';
                        }
                    }
                } catch (error) {
                    console.error('Error updating chat badge:', error);
                }
            }

            // Update cart badge for vendor
            async function updateCartBadgeVendor() {
                try {
                    const response = await fetch('<c:url value="/vendor/cart"/>');
                    if (response.ok) {
                        const text = await response.text();
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(text, 'text/html');

                        const cartItems = doc.querySelectorAll('.cart-item');
                        const count = cartItems.length;

                        const badge = document.getElementById('cartBadge');
                        if (badge) {
                            badge.textContent = count;
                            badge.style.display = count > 0 ? 'flex' : 'none';
                        }
                    }
                } catch (error) {
                    console.error('Error updating cart badge:', error);
                }
            }

            // Update badges on page load
            document.addEventListener('DOMContentLoaded', function () {
                <c:if test="${not empty sessionScope.user}">
                    // Update cart badge for all users (including VENDOR)
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'VENDOR'}">
                            updateCartBadgeVendor();
                            setInterval(updateCartBadgeVendor, 30000);
                        </c:when>
                        <c:otherwise>
                            updateCartBadge();
                            setInterval(updateCartBadge, 30000);
                        </c:otherwise>
                    </c:choose>

                    // Update chat badge for all logged-in users
                    updateChatBadge();
                    setInterval(updateChatBadge, 30000);
                </c:if>
            });

            // Expose function globally for cart updates
            window.updateCartBadge = updateCartBadge;
        </script>