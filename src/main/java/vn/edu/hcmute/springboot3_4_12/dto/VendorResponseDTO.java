package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VendorResponseDTO {
    private Long id;
    private String storeName;
    private String descriptionVi;
    private String descriptionEn;
    private String address;
    private String phone;
    private String username; // Trả về username để biết vendor này của ai
    private String userEmail;
}