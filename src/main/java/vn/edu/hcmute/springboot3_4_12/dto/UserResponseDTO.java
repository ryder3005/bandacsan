package vn.edu.hcmute.springboot3_4_12.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

// DTO dùng để trả về thông tin người dùng
public record UserResponseDTO(Long id, String username, String email, String role) {}

