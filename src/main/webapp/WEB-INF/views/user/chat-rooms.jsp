<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin nhắn - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        .chat-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .chat-room-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            overflow: hidden;
        }

        .chat-room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .chat-room-card.unread {
            border-left: 5px solid #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
        }

        .chat-room-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-right: 15px;
        }

        .chat-room-info {
            flex-grow: 1;
        }

        .chat-room-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
            color: #2c3e50;
        }

        .chat-room-last-message {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 5px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .chat-room-time {
            color: #999;
            font-size: 0.8rem;
        }

        .unread-badge {
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .empty-chat {
            text-align: center;
            padding: 80px 20px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 20px;
            margin: 40px 0;
        }

        .empty-chat i {
            font-size: 5rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .start-chat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            margin-bottom: 30px;
        }

        .start-chat-card h4 {
            margin-bottom: 20px;
            font-weight: 700;
        }

        .btn-start-chat {
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            border-radius: 50px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-start-chat:hover {
            background: white;
            color: #667eea;
            transform: translateY(-2px);
        }

        .chat-stats {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/common/header.jsp" />

<!-- Chat Header -->
<section class="chat-header">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="animate__animated animate__fadeInDown">
                    <i class="fas fa-comments me-3"></i>Tin nhắn
                </h1>
                <p class="animate__animated animate__fadeInUp animate__delay-1s">
                    Kết nối với nhà bán hàng và khách hàng
                </p>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show animate__animated animate__shakeX" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Chat Stats -->
    <div class="chat-stats animate__animated animate__fadeInUp">
        <div class="row text-center">
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number">${chatRooms != null ? chatRooms.size() : 0}</div>
                    <div class="stat-label">Cuộc trò chuyện</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number">
                        <c:set var="totalUnread" value="0"/>
                        <c:forEach var="room" items="${chatRooms}">
                            <c:set var="totalUnread" value="${totalUnread + room.unreadCount}"/>
                        </c:forEach>
                        ${totalUnread}
                    </div>
                    <div class="stat-label">Tin nhắn chưa đọc</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-item">
                    <div class="stat-number">
                        <c:set var="activeRooms" value="0"/>
                        <c:forEach var="room" items="${chatRooms}">
                            <c:if test="${not empty room.lastMessage}">
                                <c:set var="activeRooms" value="${activeRooms + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${activeRooms}
                    </div>
                    <div class="stat-label">Cuộc trò chuyện hoạt động</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Start New Chat -->
    <div class="start-chat-card animate__animated animate__fadeInUp animate__delay-1s">
        <h4><i class="fas fa-plus-circle me-2"></i>Bắt đầu cuộc trò chuyện mới</h4>
        <p class="mb-4">Liên hệ với nhà bán hàng để hỏi về sản phẩm hoặc đặt hàng</p>
        <a href="<c:url value='/user/products'/>" class="btn btn-start-chat">
            <i class="fas fa-store me-2"></i>Xem cửa hàng
        </a>
    </div>

    <!-- Chat Rooms -->
    <c:choose>
        <c:when test="${not empty chatRooms}">
            <div class="row">
                <div class="col-12">
                    <h4 class="mb-3"><i class="fas fa-list me-2"></i>Các cuộc trò chuyện</h4>
                </div>
            </div>
            <c:forEach var="room" items="${chatRooms}" varStatus="status">
                <div class="chat-room-card ${room.unreadCount > 0 ? 'unread' : ''} animate__animated animate__fadeInUp"
                     style="animation-delay: ${status.index * 0.1}s"
                     onclick="window.location.href='<c:url value="/user/chat/room/${room.id}"/>'">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <div class="chat-room-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="chat-room-info">
                                <div class="chat-room-name">
                                    ${room.vendorName}
                                </div>
                                <div class="chat-room-last-message">
                                    <c:choose>
                                        <c:when test="${not empty room.lastMessage}">
                                            ${room.lastMessage}
                                        </c:when>
                                        <c:otherwise>
                                            <em>Chưa có tin nhắn</em>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="chat-room-time">
                                    ${room.lastMessageTime}
                                </div>
                            </div>
                            <c:if test="${room.unreadCount > 0}">
                                <div class="unread-badge">
                                    ${room.unreadCount}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-chat animate__animated animate__fadeInUp">
                <i class="fas fa-comments"></i>
                <h3>Bạn chưa có cuộc trò chuyện nào</h3>
                <p class="text-muted">Hãy bắt đầu trò chuyện với nhà bán hàng khi mua hàng</p>
                <a href="<c:url value='/user/products'/>" class="btn btn-primary btn-lg">
                    <i class="fas fa-shopping-cart me-2"></i>Xem sản phẩm
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add click animation to chat room cards
    document.querySelectorAll('.chat-room-card').forEach(card => {
        card.addEventListener('click', function() {
            this.style.transform = 'scale(0.95)';
            setTimeout(() => {
                this.style.transform = '';
            }, 150);
        });
    });
</script>
</body>
</html>
