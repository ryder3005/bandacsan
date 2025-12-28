package vn.edu.hcmute.springboot3_4_12.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ToString.Exclude
    @ManyToOne
    private Vendor vendor;

    private String nameVi;
    private String nameEn;

    private String descriptionVi;
    private String descriptionEn;

    private Double price;
    private Integer stock;

    @ToString.Exclude
    @ManyToMany(mappedBy = "products")
    private List<Blog> blogs = new ArrayList<>();

    @ToString.Exclude
    @ManyToMany
    @JoinTable(
            name = "product_category", // Tên bảng trung gian
            joinColumns = @JoinColumn(name = "product_id"), // Khóa ngoại trỏ tới Product
            inverseJoinColumns = @JoinColumn(name = "category_id") // Khóa ngoại trỏ tới Category
    )
    private List<Category> categories = new ArrayList<>();

    @ToString.Exclude
    @OneToMany(
            mappedBy = "product",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )

    private List<Image> images = new ArrayList<>();
}
