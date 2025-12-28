package vn.edu.hcmute.springboot3_4_12.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "vendor_revenue")
public class VendorRevenue {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne private Vendor vendor;

    private Double amount;
    private LocalDateTime createdAt;

    @Entity
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    @Table(name = "ratings")
    public static class Rating {
        @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        @ToString.Exclude
        @ManyToOne private User user;

        @ToString.Exclude
        @ManyToOne private Product product;

        private Integer stars; // 1-5
        private String commentVi;
        private String commentEn;

        private LocalDateTime createdAt;
    }
}
