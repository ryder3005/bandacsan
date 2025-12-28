package vn.edu.hcmute.springboot3_4_12.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "vendors")
public class Vendor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ToString.Exclude
    @OneToOne
    private User user;

    private String storeName;
    private String descriptionVi;
    private String descriptionEn;

    private String address;
    private String phone;
}
