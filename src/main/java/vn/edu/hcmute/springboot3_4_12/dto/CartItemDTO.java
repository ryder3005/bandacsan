package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemDTO {
    private Long id;
    private Long productId;
    private String productNameVi;
    private String productNameEn;
    private Double productPrice;
    private String productImage;
    private Integer quantity;
    private Double subtotal;
}
