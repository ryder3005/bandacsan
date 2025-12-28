<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 11/21/2025
  Time: 10:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-5">
    <h1 class="mb-4">Admin Dashboard</h1>

    <!-- Users -->
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Users</span>
            <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-success btn-sm">Add User</a>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.username}</td>
                        <td>${user.email}</td>
                        <td>${user.fullName}</td>
                        <td>${user.phone}</td>
                        <td><c:out value="${user.admin ? 'Admin' : 'User'}"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.username}" class="btn btn-primary btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/users/delete?id=${user.username}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure to delete this user?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Categories -->
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Categories</span>
            <a href="${pageContext.request.contextPath}/admin/categories/create" class="btn btn-success btn-sm">Add Category</a>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Code</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cat" items="${categories}">
                    <tr>
                        <td>${cat.categoryId}</td>
                        <td>${cat.categoryName}</td>
                        <td>${cat.categorycode}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/categories/edit?id=${cat.id}" class="btn btn-primary btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/categories/delete?id=${cat.id}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure to delete this category?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Videos -->
    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Videos</span>
            <a href="${pageContext.request.contextPath}/admin/videos/create" class="btn btn-success btn-sm">Add Video</a>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="video" items="${videos}">
                    <tr>
                        <td>${video.id}</td>
                        <td>${video.title}</td>
                        <td>${video.description}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/videos/edit?id=${video.id}" class="btn btn-primary btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/videos/delete?id=${video.id}"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure to delete this video?');">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

