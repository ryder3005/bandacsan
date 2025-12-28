package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.Data;

@Data
public class LoginRequestDTO {
    private String username;
    private String password;
}