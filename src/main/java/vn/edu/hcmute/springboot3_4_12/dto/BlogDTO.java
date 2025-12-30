package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BlogDTO {
    private Long id;
    private String titleVi;
    private String titleEn;
    private String summaryVi;
    private String summaryEn;
    private String contentVi;
    private String contentEn;
    private String slug;
    private String imageUrl;
    private String authorName;
    private Long authorId;
    private List<ProductResponseDTO> products;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
