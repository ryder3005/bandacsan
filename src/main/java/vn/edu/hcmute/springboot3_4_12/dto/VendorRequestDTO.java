package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VendorRequestDTO {
    private Long userId; // Chỉ cần truyền ID của User lên
    private String storeName;
    private String descriptionVi;
    private String descriptionEn;
    private String address;
    private String phone;
}