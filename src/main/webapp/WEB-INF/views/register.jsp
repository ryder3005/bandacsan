<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
</head>
<body class="container mt-5">

<h2>Đăng ký tài khoản</h2>

<p class="text-danger">${message}</p>

<form action="register" method="post">

    <div class="mb-3">
        <label>Tài khoản</label>
        <input class="form-control" type="text" name="username" required/>
    </div>

    <div class="mb-3">
        <label>Mật khẩu</label>
        <input class="form-control" type="password" name="password" required/>
    </div>

    <div class="mb-3">
        <label>Họ tên</label>
        <input class="form-control" type="text" name="fullname"/>
    </div>

    <div class="mb-3">
        <label>Email</label>
        <input class="form-control" type="email" name="email"/>
    </div>

    <div class="mb-3">
        <label>Số điện thoại</label>
        <input class="form-control" type="text" name="phone"/>
    </div>

    <button class="btn btn-success">Đăng ký</button>
    <a href="login" class="btn btn-link">Đăng nhập</a>

</form>

</body>
</html>
