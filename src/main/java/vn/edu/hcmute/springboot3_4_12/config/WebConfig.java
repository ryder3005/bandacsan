package vn.edu.hcmute.springboot3_4_12.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import vn.edu.hcmute.springboot3_4_12.auth.AuthInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Autowired
    private AuthInterceptor authInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/**") // Áp dụng cho tất cả routes
                .excludePathPatterns(
                        "/login",              // Trang đăng nhập
                        "/register",           // Trang đăng ký
                        "/forgot-password",    // Trang quên mật khẩu
                        "/reset-password",     // Trang đặt lại mật khẩu
                        "/perform_login",      // Xử lý đăng nhập
                        "/logout",             // Đăng xuất
                        "/error",              // Trang lỗi
                        "/resources/**",       // Static resources (CSS, JS, images)
                        "/api/auth/**",         // API đăng nhập/đăng ký (nếu có)
                        "/files/**"
                );
    }
}
