<%--
  Created by IntelliJ IDEA.
  User: caoth
  Date: 1/5/2026
  Time: 9:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%-- WEB-INF/common/common-toast.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 2000">
    <div id="systemToast" class="toast align-items-center text-white border-0 shadow" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body d-flex align-items-center">
                <i id="toastIcon" class="bi me-2 fs-5"></i>
                <span id="toastMessage"></span>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script>
    /**
     * Hàm hiển thị thông báo dùng chung
     * @param message: Nội dung thông báo
     * @param type: 'success', 'danger', 'warning', 'info'
     */
    function showToast(message, type = 'success') {
        const toastEl = document.getElementById('systemToast');
        const toastMessage = document.getElementById('toastMessage');
        const toastIcon = document.getElementById('toastIcon');

        // Reset classes
        toastEl.classList.remove('bg-success', 'bg-danger', 'bg-warning', 'bg-info');
        toastIcon.classList.remove('bi-check-circle', 'bi-exclamation-triangle', 'bi-info-circle', 'bi-x-circle');

        // Cấu hình theo loại
        switch(type) {
            case 'success':
                toastEl.classList.add('bg-success');
                toastIcon.classList.add('bi-check-circle');
                break;
            case 'danger':
                toastEl.classList.add('bg-danger');
                toastIcon.classList.add('bi-x-circle');
                break;
            case 'warning':
                toastEl.classList.add('bg-warning');
                toastIcon.classList.add('bi-exclamation-triangle');
                break;
            default:
                toastEl.classList.add('bg-info');
                toastIcon.classList.add('bi-info-circle');
        }

        toastMessage.innerText = message;

        // Khởi tạo và hiển thị
        const bsToast = new bootstrap.Toast(toastEl, { delay: 3000 });
        bsToast.show();
    }
</script>
