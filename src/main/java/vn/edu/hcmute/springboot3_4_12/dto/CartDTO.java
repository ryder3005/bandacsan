package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDTO {
    private Long id;
    private Long userId;
    private Double totalPrice;
    private List<CartItemDTO> items;
    private Integer totalItems;
}
