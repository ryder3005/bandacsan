package vn.edu.hcmute.springboot3_4_12.service;

public interface EmailService {
    void sendPasswordResetEmail(String to, String resetToken);
}
