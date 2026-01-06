<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Đặc sản quê hương</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
        }

        .reset-password-container {
            max-width: 500px;
            width: 100%;
            padding: 20px;
            position: relative;
            z-index: 1;
        }

        .reset-password-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0,0,0,0.2);
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.2);
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .reset-password-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 50px 30px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .reset-password-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .reset-password-header h2 {
            margin: 0;
            font-weight: 700;
            font-size: 32px;
            position: relative;
            z-index: 2;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .reset-password-header p {
            margin: 15px 0 0 0;
            opacity: 0.9;
            font-size: 16px;
            position: relative;
            z-index: 2;
        }

        .reset-password-body {
            padding: 40px 30px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            border-radius: 12px;
            border: 2px solid #e0e6ed;
            padding: 15px 20px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .input-group {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #667eea;
            cursor: pointer;
            font-size: 18px;
            z-index: 10;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 15px;
            font-weight: 600;
            font-size: 16px;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
            color: white;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .alert-danger {
            border-radius: 12px;
            border: none;
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
            color: #721c24;
            padding: 15px 20px;
            animation: shake 0.5s ease-in-out;
            box-shadow: 0 5px 15px rgba(255, 154, 158, 0.3);
        }

        .alert-success {
            border-radius: 12px;
            border: none;
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            padding: 15px 20px;
            box-shadow: 0 5px 15px rgba(212, 237, 218, 0.3);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px solid #e0e6ed;
            position: relative;
        }

        .back-link::before {
            content: 'or';
            position: absolute;
            top: -12px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255,255,255,0.9);
            padding: 0 15px;
            color: #666;
            font-size: 14px;
            font-weight: 500;
        }

        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .back-link a:hover {
            color: #764ba2;
            text-decoration: none;
        }

        .back-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: width 0.3s ease;
        }

        .back-link a:hover::after {
            width: 100%;
        }

        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255,255,255,0.3);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .particle:nth-child(1) {
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .particle:nth-child(2) {
            top: 20%;
            right: 10%;
            animation-delay: 2s;
        }

        .particle:nth-child(3) {
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        .particle:nth-child(4) {
            bottom: 10%;
            right: 20%;
            animation-delay: 1s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.3; }
            50% { transform: translateY(-20px) rotate(180deg); opacity: 0.8; }
        }

        @media (max-width: 768px) {
            .reset-password-header {
                padding: 40px 20px 30px;
            }

            .reset-password-header h2 {
                font-size: 28px;
            }

            .reset-password-body {
                padding: 30px 20px;
            }

            body {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Particles -->
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>

    <div class="reset-password-container">
        <div class="reset-password-card">
            <div class="reset-password-header">
                <h2><i class="bi bi-shield-lock"></i> Đặt lại mật khẩu</h2>
                <p>Nhập mật khẩu mới cho tài khoản của bạn</p>
            </div>
            <div class="reset-password-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${message}
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        <i class="bi bi-check-circle"></i> ${successMessage}
                    </div>
                </c:if>

                <form id="resetPasswordForm" method="post">
                    <input type="hidden" name="token" id="token" value="${param.token}"/>
                    
                    <div class="mb-4">
                        <label class="form-label">
                            <i class="bi bi-key"></i> Token xác thực
                        </label>
                        <input class="form-control" type="text" id="tokenInput" 
                               placeholder="Nhập token từ email" required/>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">
                            <i class="bi bi-lock"></i> Mật khẩu mới
                        </label>
                        <div class="input-group">
                            <input class="form-control" type="password" name="newPassword" id="newPassword" required 
                                   placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" minlength="6"/>
                            <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                                <i class="bi bi-eye" id="eyeNewPassword"></i>
                            </button>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">
                            <i class="bi bi-lock-fill"></i> Xác nhận mật khẩu
                        </label>
                        <div class="input-group">
                            <input class="form-control" type="password" id="confirmPassword" required 
                                   placeholder="Nhập lại mật khẩu mới" minlength="6"/>
                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                <i class="bi bi-eye" id="eyeConfirmPassword"></i>
                            </button>
                        </div>
                        <div id="passwordMatch" class="mt-2" style="display: none;"></div>
                    </div>

                    <button type="submit" class="btn btn-submit" id="submitBtn">
                        <i class="bi bi-check-circle"></i> Đặt lại mật khẩu
                    </button>
                </form>

                <div class="back-link">
                    <span>Nhớ mật khẩu? </span>
                    <a href="<c:url value='/login'/>">
                        <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Get token from URL parameter if available
        const urlParams = new URLSearchParams(window.location.search);
        const tokenFromUrl = urlParams.get('token');
        if (tokenFromUrl) {
            document.getElementById('tokenInput').value = tokenFromUrl;
            document.getElementById('token').value = tokenFromUrl;
        }

        // Password match validation
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const passwordMatch = document.getElementById('passwordMatch');

        function validatePasswordMatch() {
            if (confirmPassword.value && newPassword.value) {
                if (newPassword.value === confirmPassword.value) {
                    passwordMatch.style.display = 'block';
                    passwordMatch.className = 'mt-2 text-success';
                    passwordMatch.innerHTML = '<i class="bi bi-check-circle"></i> Mật khẩu khớp';
                } else {
                    passwordMatch.style.display = 'block';
                    passwordMatch.className = 'mt-2 text-danger';
                    passwordMatch.innerHTML = '<i class="bi bi-x-circle"></i> Mật khẩu không khớp';
                }
            } else {
                passwordMatch.style.display = 'none';
            }
        }

        newPassword.addEventListener('input', validatePasswordMatch);
        confirmPassword.addEventListener('input', validatePasswordMatch);

        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const eyeIcon = document.getElementById('eye' + inputId.charAt(0).toUpperCase() + inputId.slice(1));
            
            if (input.type === 'password') {
                input.type = 'text';
                eyeIcon.classList.remove('bi-eye');
                eyeIcon.classList.add('bi-eye-slash');
            } else {
                input.type = 'password';
                eyeIcon.classList.remove('bi-eye-slash');
                eyeIcon.classList.add('bi-eye');
            }
        }

        document.getElementById('resetPasswordForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const submitBtn = document.getElementById('submitBtn');
            const token = document.getElementById('tokenInput').value;
            const newPasswordValue = document.getElementById('newPassword').value;
            const confirmPasswordValue = document.getElementById('confirmPassword').value;
            
            // Validate password match
            if (newPasswordValue !== confirmPasswordValue) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger';
                alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle"></i> Mật khẩu không khớp';
                document.querySelector('.reset-password-body').insertBefore(alertDiv, document.getElementById('resetPasswordForm'));
                return;
            }
            
            // Disable button and show loading
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang xử lý...';
            
            try {
                const response = await fetch('/api/auth/reset-password', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ 
                        token: token,
                        newPassword: newPasswordValue
                    })
                });
                
                const data = await response.json();
                
                if (response.ok) {
                    // Success
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-success';
                    alertDiv.innerHTML = '<i class="bi bi-check-circle"></i> ' + data.message;
                    document.querySelector('.reset-password-body').insertBefore(alertDiv, document.getElementById('resetPasswordForm'));
                    
                    // Clear form
                    document.getElementById('resetPasswordForm').reset();
                    
                    // Redirect to login after 3 seconds
                    setTimeout(() => {
                        window.location.href = '/login?success=' + encodeURIComponent('Mật khẩu đã được đặt lại thành công. Vui lòng đăng nhập.');
                    }, 3000);
                } else {
                    // Error
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-danger';
                    alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle"></i> ' + (data.error || 'Có lỗi xảy ra');
                    document.querySelector('.reset-password-body').insertBefore(alertDiv, document.getElementById('resetPasswordForm'));
                }
            } catch (error) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger';
                alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle"></i> Có lỗi xảy ra khi kết nối đến server';
                document.querySelector('.reset-password-body').insertBefore(alertDiv, document.getElementById('resetPasswordForm'));
            } finally {
                // Re-enable button
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="bi bi-check-circle"></i> Đặt lại mật khẩu';
            }
        });
    </script>
</body>
</html>
