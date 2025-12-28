<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body class="container mt-5">

<h2>Đăng nhập</h2>

<p class="text-danger">${message}</p>

<form action="login" method="post">

    <div class="mb-3">
        <label>Tài khoản</label>
        <input class="form-control" type="text" name="username" required/>
    </div>

    <div class="mb-3">
        <label>Mật khẩu</label>
        <input class="form-control" type="password" name="password" required/>
    </div>

    <button class="btn btn-primary">Đăng nhập</button>
    <a href="register" class="btn btn-link">Đăng ký</a>

</form>

</body>
</html>
