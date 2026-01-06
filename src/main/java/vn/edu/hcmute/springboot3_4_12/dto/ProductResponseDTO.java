package vn.edu.hcmute.springboot3_4_12.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponseDTO {

    private Long id;
    private String nameVi;
    private String nameEn;
    private String descriptionVi;
    private String descriptionEn;
    private Double price;
    private Integer stock;
    private Long vendorId;
    private String vendorName;
    private List<String> categories;
    private List<String> imageUrls;
    public String getProductImage() {
        if (imageUrls != null && !imageUrls.isEmpty()) {
            return imageUrls.get(0); // Lấy ảnh đầu tiên trong list
        }
        return null;
    }

    // getter & setter
}
