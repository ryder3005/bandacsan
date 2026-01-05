<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chat - Đặc sản quê hương</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
                <style>
                    .chat-container {
                        height: 80vh;
                        background: white;
                        border-radius: 20px;
                        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                        display: flex;
                        flex-direction: column;
                        overflow: hidden;
                    }

                    .chat-header {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 20px 30px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .chat-messages {
                        flex: 1;
                        padding: 20px;
                        overflow-y: auto;
                        background: #f8f9fa;
                    }

                    .message {
                        margin-bottom: 20px;
                        display: flex;
                        align-items: flex-start;
                    }

                    .message.sent {
                        justify-content: flex-end;
                    }

                    .message-avatar {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 1rem;
                        margin-right: 15px;
                    }

                    .message.sent .message-avatar {
                        margin-right: 0;
                        margin-left: 15px;
                        order: 2;
                    }

                    .message-content {
                        max-width: 60%;
                        background: white;
                        padding: 15px 20px;
                        border-radius: 20px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                        position: relative;
                    }

                    .message.sent .message-content {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                    }

                    .message.sent .message-content::after {
                        content: '';
                        position: absolute;
                        right: -10px;
                        top: 20px;
                        width: 0;
                        height: 0;
                        border-left: 10px solid #667eea;
                        border-top: 10px solid transparent;
                        border-bottom: 10px solid transparent;
                    }

                    .message-content::before {
                        content: '';
                        position: absolute;
                        left: -10px;
                        top: 20px;
                        width: 0;
                        height: 0;
                        border-right: 10px solid white;
                        border-top: 10px solid transparent;
                        border-bottom: 10px solid transparent;
                    }

                    .message-text {
                        margin: 0;
                        word-wrap: break-word;
                    }

                    .message-time {
                        font-size: 0.8rem;
                        color: #666;
                        margin-top: 5px;
                        text-align: right;
                    }

                    .message.sent .message-time {
                        color: rgba(255, 255, 255, 0.8);
                    }

                    .chat-input-area {
                        padding: 20px 30px;
                        background: white;
                        border-top: 1px solid #e0e6ed;
                    }

                    .chat-input {
                        display: flex;
                        gap: 15px;
                        align-items: center;
                    }

                    .message-input {
                        flex: 1;
                        border: 2px solid #e0e6ed;
                        border-radius: 50px;
                        padding: 15px 25px;
                        font-size: 16px;
                        transition: all 0.3s ease;
                        resize: none;
                    }

                    .message-input:focus {
                        border-color: #667eea;
                        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                        outline: none;
                    }

                    .btn-send {
                        width: 50px;
                        height: 50px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        border: none;
                        color: white;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 1.2rem;
                        transition: all 0.3s ease;
                    }

                    .btn-send:hover {
                        transform: scale(1.1);
                        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
                    }

                    .back-btn {
                        background: rgba(255, 255, 255, 0.2);
                        border: none;
                        color: white;
                        border-radius: 10px;
                        padding: 8px 15px;
                        margin-right: 15px;
                        transition: all 0.3s ease;
                    }

                    .back-btn:hover {
                        background: rgba(255, 255, 255, 0.3);
                        color: white;
                    }

                    .online-status {
                        width: 12px;
                        height: 12px;
                        background: #28a745;
                        border-radius: 50%;
                        border: 2px solid white;
                        position: absolute;
                        bottom: 0;
                        right: 0;
                    }

                    .typing-indicator {
                        display: none;
                        font-style: italic;
                        color: #666;
                        padding: 10px 20px;
                        font-size: 0.9rem;
                    }

                    .empty-chat {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        height: 100%;
                        text-align: center;
                        color: #666;
                    }

                    .empty-chat i {
                        font-size: 4rem;
                        margin-bottom: 20px;
                        opacity: 0.5;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/common/header.jsp" />

                <div class="container py-4">
                    <div class="chat-container animate__animated animate__fadeInUp">
                        <!-- Chat Header -->
                        <div class="chat-header">
                            <div class="d-flex align-items-center">
                                <a href="<c:url value='/user/chat'/>" class="back-btn">
                                    <i class="fas fa-arrow-left"></i>
                                </a>
                                <div class="position-relative">
                                    <div class="message-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="online-status"></div>
                                </div>
                                <div class="ms-3">
                                    <h5 class="mb-0">${chatRoom.customerName}</h5>
                                    <small class="opacity-75">Đang hoạt động</small>
                                </div>
                            </div>
                        </div>

                        <!-- Chat Messages -->
                        <div class="chat-messages" id="chatMessages">
                            <c:choose>
                                <c:when test="${not empty messages}">
                                    <c:forEach var="message" items="${messages}">
                                        <div class="message ${message.fromCurrentUser ? 'sent' : ''}"
                                            data-message-id="${message.id}">
                                            <c:if test="${!message.fromCurrentUser}">
                                                <div class="message-avatar">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                            </c:if>
                                            <div class="message-content">
                                                <small class="message-sender-name text-muted d-block mb-1"
                                                    style="font-size: 0.75rem;">${message.senderName}</small>
                                                <p class="message-text mb-1">${message.message}</p>
                                                <div class="message-time">
                                                    <fmt:formatDate value="${message.timestampDate}"
                                                        pattern="HH:mm dd/MM" />
                                                </div>
                                            </div>
                                            <c:if test="${message.fromCurrentUser}">
                                                <div class="message-avatar">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-chat">
                                        <i class="fas fa-comments"></i>
                                        <h5>Bắt đầu cuộc trò chuyện</h5>
                                        <p>Gửi tin nhắn đầu tiên để bắt đầu trò chuyện với khách hàng</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="typing-indicator" id="typingIndicator">
                                Khách hàng đang trả lời...
                            </div>
                        </div>

                        <!-- Chat Input -->
                        <div class="chat-input-area">
                            <form id="messageForm" class="chat-input">
                                <textarea class="message-input" id="messageInput" placeholder="Nhập tin nhắn của bạn..."
                                    rows="1" onkeydown="handleKeyPress(event)"></textarea>
                                <button type="submit" class="btn-send" id="sendButton">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/common/footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    let roomId = ${ roomId };
                    let currentUserId = ${ currentUserId };

                    // Auto scroll to bottom
                    function scrollToBottom() {
                        const chatMessages = document.getElementById('chatMessages');
                        chatMessages.scrollTop = chatMessages.scrollHeight;
                    }

                    // Scroll to bottom on page load
                    window.addEventListener('load', scrollToBottom);

                    // Handle form submission
                    document.getElementById('messageForm').addEventListener('submit', function (e) {
                        e.preventDefault();
                        sendMessage();
                    });

                    function handleKeyPress(event) {
                        if (event.key === 'Enter' && !event.shiftKey) {
                            event.preventDefault();
                            sendMessage();
                        }
                    }

                    async function sendMessage() {
                        const input = document.getElementById('messageInput');
                        const message = input.value.trim();

                        if (!message) return;

                        // Disable input and button
                        input.disabled = true;
                        document.getElementById('sendButton').disabled = true;
                        document.getElementById('sendButton').innerHTML = '<i class="fas fa-spinner fa-spin"></i>';

                        try {
                            const response = await fetch('<c:url value="/vendor/chat/send"/>', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: new URLSearchParams({
                                    roomId: roomId,
                                    message: message
                                })
                            });

                            if (response.ok) {
                                const result = await response.json();
                                addMessageToChat(result);
                                input.value = '';
                                scrollToBottom();
                            } else {
                                alert('Không thể gửi tin nhắn. Vui lòng thử lại.');
                            }
                        } catch (error) {
                            console.error('Error sending message:', error);
                            alert('Có lỗi xảy ra. Vui lòng thử lại.');
                        } finally {
                            // Re-enable input and button
                            input.disabled = false;
                            document.getElementById('sendButton').disabled = false;
                            document.getElementById('sendButton').innerHTML = '<i class="fas fa-paper-plane"></i>';
                            input.focus();
                        }
                    }

                    function addMessageToChat(messageData) {
                        const chatMessages = document.getElementById('chatMessages');
                        const emptyChat = chatMessages.querySelector('.empty-chat');

                        // Remove empty chat message if exists
                        if (emptyChat) {
                            emptyChat.remove();
                        }

                        const messageDiv = document.createElement('div');
                        messageDiv.className = 'message ' + (messageData.fromCurrentUser ? 'sent' : '');
                        messageDiv.setAttribute('data-message-id', messageData.id);

                        const avatarDiv = document.createElement('div');
                        avatarDiv.className = 'message-avatar';
                        avatarDiv.innerHTML = '<i class="fas fa-user"></i>';

                        const contentDiv = document.createElement('div');
                        contentDiv.className = 'message-content';

                        const textP = document.createElement('p');
                        textP.className = 'message-text';
                        textP.textContent = messageData.message;

                        const timeDiv = document.createElement('div');
                        timeDiv.className = 'message-time';
                        const senderDiv = document.createElement('div');
                        senderDiv.className = 'message-sender-name text-muted d-block mb-1';
                        senderDiv.style.fontSize = '0.75rem';
                        senderDiv.textContent = messageData.senderName;

                        contentDiv.appendChild(senderDiv);
                        contentDiv.appendChild(textP);
                        contentDiv.appendChild(timeDiv);

                        if (messageData.fromCurrentUser) {
                            messageDiv.appendChild(contentDiv);
                            messageDiv.appendChild(avatarDiv);
                        } else {
                            messageDiv.appendChild(avatarDiv);
                            messageDiv.appendChild(contentDiv);
                        }

                        chatMessages.appendChild(messageDiv);
                    }

                    // Auto resize textarea
                    document.getElementById('messageInput').addEventListener('input', function () {
                        this.style.height = 'auto';
                        this.style.height = Math.min(this.scrollHeight, 100) + 'px';
                    });

                    // Poll for new messages (in a real app, you'd use WebSocket)
                    setInterval(async function () {
                        try {
                            const response = await fetch('<c:url value="/vendor/chat/room/"/>' + roomId + '/messages');
                            if (response.ok) {
                                const newMessages = await response.json();
                                // Add new messages to chat
                                newMessages.forEach(msg => {
                                    // Ensure ID is compared as string to match attribute
                                    if (!document.querySelector('[data-message-id="' + msg.id + '"]')) {
                                        addMessageToChat(msg);
                                    }
                                });
                            }
                        } catch (error) {
                            console.error('Error polling messages:', error);
                        }
                    }, 5000); // Poll every 5 seconds
                </script>
            </body>

            </html>