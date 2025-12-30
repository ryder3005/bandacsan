<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Đặc sản quê hương</title>
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
            background: linear-gradient(-45deg, #4facfe, #00f2fe, #667eea, #764ba2);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
            padding: 20px 0;
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

        .register-container {
            max-width: 600px;
            width: 100%;
            padding: 20px;
            position: relative;
            z-index: 1;
        }

        .register-card {
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

        .register-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 40px 30px 35px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .register-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 25s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .register-header h2 {
            margin: 0;
            font-weight: 700;
            font-size: 32px;
            position: relative;
            z-index: 2;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .register-header p {
            margin: 15px 0 0 0;
            opacity: 0.9;
            font-size: 16px;
            position: relative;
            z-index: 2;
        }

        .register-body {
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

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-control, .form-select {
            border-radius: 12px;
            border: 2px solid #e0e6ed;
            padding: 15px 20px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus, .form-select:focus {
            border-color: #4facfe;
            box-shadow: 0 0 0 0.2rem rgba(79, 172, 254, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .input-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #4facfe;
            font-size: 18px;
        }
        .btn-register {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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

        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-register:hover::before {
            left: 100%;
        }

        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(79, 172, 254, 0.4);
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

        .login-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px solid #e0e6ed;
            position: relative;
        }

        .login-link::before {
            content: 'Đã có tài khoản?';
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

        .login-link a {
            color: #4facfe;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link a:hover {
            color: #00f2fe;
            text-decoration: none;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            transition: width 0.3s ease;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        /* Floating particles animation */
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
            top: 30%;
            right: 20%;
            animation-delay: 1s;
        }

        .particle:nth-child(5) {
            bottom: 10%;
            right: 30%;
            animation-delay: 3s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.3; }
            50% { transform: translateY(-20px) rotate(180deg); opacity: 0.8; }
        }

        /* Loading state */
        .btn-loading {
            position: relative;
            color: transparent !important;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @media (max-width: 768px) {
            .register-header {
                padding: 35px 20px 30px;
            }

            .register-header h2 {
                font-size: 28px;
            }

            .register-body {
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
    <div class="particle"></div>

    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <h2><i class="bi bi-person-plus"></i> Đăng ký tài khoản</h2>
                <p>Tham gia cùng chúng tôi để khám phá đặc sản quê hương</p>
            </div>
            <div class="register-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${message}
                    </div>
                </c:if>

                <form action="<c:url value='/register'/>" method="post">
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-person"></i> Tài khoản *
                        </label>
                        <input class="form-control" type="text" name="username" required 
                               placeholder="Nhập tên đăng nhập" autofocus/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-lock"></i> Mật khẩu *
                        </label>
                        <input class="form-control" type="password" name="password" required 
                               placeholder="Nhập mật khẩu"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-envelope"></i> Email *
                        </label>
                        <input class="form-control" type="email" name="email" required 
                               placeholder="Nhập địa chỉ email"/>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">
                            <i class="bi bi-phone"></i> Số điện thoại
                        </label>
                        <input class="form-control" type="text" name="phone" 
                               placeholder="Nhập số điện thoại"/>
                    </div>

                    <button type="submit" class="btn btn-register">
                        <i class="bi bi-check-circle"></i> Đăng ký
                    </button>
                </form>

                <div class="login-link">
                    <span>Đã có tài khoản? </span>
                    <a href="<c:url value='/login'/>">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng nhập ngay
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
