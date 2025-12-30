package vn.edu.hcmute.springboot3_4_12.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "blogs")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Blog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titleVi;
    private String titleEn;

    @Column(columnDefinition = "TEXT")
    private String summaryVi;

    @Column(columnDefinition = "TEXT")
    private String summaryEn;

    @Column(columnDefinition = "TEXT")
    private String contentVi;

    @Column(columnDefinition = "TEXT")
    private String contentEn;

    private String slug;
    private String imageUrl;

    @ToString.Exclude
    @ManyToOne
    private User author;

    @ToString.Exclude
    @ManyToMany
    @JoinTable(
            name = "blog_product",
            joinColumns = @JoinColumn(name = "blog_id"),
            inverseJoinColumns = @JoinColumn(name = "product_id")
    )
    private List<Product> products = new ArrayList<>();

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

}

