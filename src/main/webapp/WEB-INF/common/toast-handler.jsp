<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/common/Toast.jsp" />
<script>
    // Show toast messages from flash attributes when page loads
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty successMessage}">
            if (typeof showToast === 'function') {
                showToast('${successMessage}', 'success');
            }
        </c:if>
        <c:if test="${not empty errorMessage}">
            if (typeof showToast === 'function') {
                showToast('${errorMessage}', 'danger');
            }
        </c:if>
        <c:if test="${not empty success}">
            if (typeof showToast === 'function') {
                showToast('${success}', 'success');
            }
        </c:if>
        <c:if test="${not empty error}">
            if (typeof showToast === 'function') {
                showToast('${error}', 'danger');
            }
        </c:if>
    });
</script>

