package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import vn.edu.hcmute.springboot3_4_12.service.EmailService;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    @Value("${spring.mail.username:noreply@example.com}")
    private String fromEmail;

    @Override
    public void sendPasswordResetEmail(String to, String resetToken) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject("Đặt lại mật khẩu");
            
            String resetUrl = baseUrl + "/reset-password?token=" + resetToken;
            String emailBody = String.format(
                "Xin chào,\n\n" +
                "Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình.\n\n" +
                "Vui lòng sử dụng token sau để đặt lại mật khẩu:\n" +
                "Token: %s\n\n" +
                "Hoặc truy cập link sau:\n" +
                "%s\n\n" +
                "Token này sẽ hết hạn sau 1 giờ.\n\n" +
                "Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.\n\n" +
                "Trân trọng,\n" +
                "Đội ngũ hỗ trợ",
                resetToken,
                resetUrl
            );
            
            message.setText(emailBody);
            mailSender.send(message);
            log.info("Email đặt lại mật khẩu đã được gửi đến: {}", to);
        } catch (Exception e) {
            log.error("Lỗi khi gửi email đến {}: {}", to, e.getMessage());
            // In ra console để test nếu email không được cấu hình
            System.out.println("=== EMAIL RESET PASSWORD ===");
            System.out.println("To: " + to);
            System.out.println("Reset Token: " + resetToken);
            System.out.println("Reset URL: " + baseUrl + "/api/auth/reset-password?token=" + resetToken);
            System.out.println("===========================");
        }
    }
}
