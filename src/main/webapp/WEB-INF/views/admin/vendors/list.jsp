<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>Admin - Danh sách nhà bán hàng (Vendors)</h2>
<c:if test="${not empty vendors}">
    <table class="table">
        <thead>
            <tr><th>ID</th><th>Tên cửa hàng</th><th>Username</th><th>Email</th></tr>
        </thead>
        <tbody>
            <c:forEach items="${vendors}" var="v">
                <tr>
                    <td><c:out value="${v.id}"/></td>
                    <td><c:out value="${v.storeName}"/></td>
                    <td><c:out value="${v.username}"/></td>
                    <td><c:out value="${v.userEmail}"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>
<c:if test="${empty vendors}">
    <p>Không có nhà bán hàng nào.</p>
</c:if>