package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BlogRequestDTO {
    private Long id;
    private String titleVi;
    private String titleEn;
    private String summaryVi;
    private String summaryEn;
    private String contentVi;
    private String contentEn;
    private String imageUrl;
    private List<Long> productIds;
}
