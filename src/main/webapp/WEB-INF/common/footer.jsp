<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="bg-dark text-light py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="mb-3 text-white"> <i class="bi bi-shop text-warning"></i> Đặc Sản Quê Hương
                </h5>
                <p class="text-white-50"> Website quảng bá và kinh doanh đặc sản quê hương Việt Nam.
                    Chúng tôi mang đến những món ăn đậm đà bản sắc dân tộc.
                </p>
            </div>

            <div class="col-md-2 mb-4">
                <h6 class="mb-3 text-white">Liên kết nhanh</h6>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <a href="<c:url value='/'/>" class="text-decoration-none text-white-50 link-light">
                            <i class="bi bi-house"></i> Trang chủ
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="<c:url value='/user/products'/>" class="text-decoration-none text-white-50 link-light">
                            <i class="bi bi-box-seam"></i> Sản phẩm
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="<c:url value='/user/categories'/>" class="text-decoration-none text-white-50 link-light">
                            <i class="bi bi-tags"></i> Danh mục
                        </a>
                    </li>
                </ul>
            </div>

            <div class="col-md-3 mb-4">
                <h6 class="mb-3 text-white">Liên hệ</h6>
                <ul class="list-unstyled text-white-50"> <li class="mb-2">
                    <i class="bi bi-envelope text-primary"></i> Email: info@dacsanquehuong.com
                </li>
                    <li class="mb-2">
                        <i class="bi bi-telephone text-success"></i> Hotline: 1900-xxxx
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-geo-alt text-danger"></i> Địa chỉ: Việt Nam
                    </li>
                </ul>
            </div>

            <div class="col-md-3 mb-4">
                <h6 class="mb-3 text-white">Theo dõi chúng tôi</h6>
                <div class="d-flex gap-3">
                    <a href="#" class="text-white-50 link-light text-decoration-none" title="Facebook">
                        <i class="bi bi-facebook" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-white-50 link-light text-decoration-none" title="Instagram">
                        <i class="bi bi-instagram" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-white-50 link-light text-decoration-none" title="YouTube">
                        <i class="bi bi-youtube" style="font-size: 1.5rem;"></i>
                    </a>
                    <a href="#" class="text-white-50 link-light text-decoration-none" title="Zalo">
                        <i class="bi bi-chat-dots" style="font-size: 1.5rem;"></i>
                    </a>
                </div>
            </div>
        </div>

        <hr class="my-4" style="border-color: rgba(255,255,255,0.15);">

        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-white-50"> &copy; <%= java.time.Year.now() %> <span class="text-white fw-bold">Đặc Sản Quê Hương</span>. Tất cả quyền được bảo lưu.
                </p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <p class="mb-0 text-white-50"> <i class="bi bi-person-badge"></i> Sinh viên: <strong class="text-white">23110101 - Đặng Gia Huy</strong>
                </p>
            </div>
        </div>
    </div>
</footer>