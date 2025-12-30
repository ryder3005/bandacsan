package vn.edu.hcmute.springboot3_4_12.dto;


import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class ProductRequestDTO {

    @NotBlank(message = "Tên tiếng Việt không được để trống")
    private String nameVi;

//    @NotBlank(message = "Tên tiếng Anh không được để trống")
    private String nameEn;

    @NotBlank(message = "Mô tả tiếng Việt không được để trống")
    private String descriptionVi;

//    @NotBlank(message = "Mô tả tiếng Anh không được để trống")
    private String descriptionEn;

    @NotNull(message = "Giá không được để trống")
    @Positive(message = "Giá phải lớn hơn 0")
    private Double price;

    @NotNull(message = "Số lượng tồn kho không được để trống")
    @Min(value = 0, message = "Tồn kho không được âm")
    private Integer stock;

    @NotNull(message = "Vendor không được để trống")
    private Long vendorId;

    private List<Long> categoryIds;
    private List<String> imageUrls;
    // getter & setter
}

