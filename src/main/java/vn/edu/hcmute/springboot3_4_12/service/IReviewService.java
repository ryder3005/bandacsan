package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.dto.ReviewDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ReviewRequestDTO;

import java.util.List;

public interface IReviewService {
    ReviewDTO createReview(Long userId, ReviewRequestDTO request);
    List<ReviewDTO> getProductReviews(Long productId);
    List<ReviewDTO> getUserReviews(Long userId);
    Double getAverageRating(Long productId);
    boolean hasUserReviewedProduct(Long userId, Long productId);
}
