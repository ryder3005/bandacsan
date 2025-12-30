package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CheckoutRequestDTO {
    private String shippingAddress;
    private String phone;
    private String notes;
    private String paymentMethod; // COD, MOMO, STRIPE
}
