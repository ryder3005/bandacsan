package vn.edu.hcmute.springboot3_4_12.auth;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.edu.hcmute.springboot3_4_12.entity.User;

import java.util.Objects;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler
    ) throws Exception {

        HttpSession session = request.getSession(false);
        User user = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        String uri = request.getRequestURI();

        // Chưa đăng nhập
        if (user == null) {
            response.sendRedirect("/login");
            return false;
        }

        // API chỉ ADMIN được dùng
        if (
                uri.startsWith("/api/")
                ||uri.startsWith("/admin/")
        ) {
            if (Objects.equals(user.getRole(), "ADMIN")) {
                response.sendRedirect("/login");
                return false;
            }
        }

        return true;
    }
}
