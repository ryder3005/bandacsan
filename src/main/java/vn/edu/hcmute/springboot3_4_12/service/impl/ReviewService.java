package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.ReviewDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ReviewRequestDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.Review;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ReviewRepository;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.service.IReviewService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewService implements IReviewService {

    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    @Override
    public ReviewDTO createReview(Long userId, ReviewRequestDTO request) {
        // Check if user already reviewed this product
        Optional<Review> existingReview = reviewRepository.findByUser_IdAndProduct_Id(userId, request.getProductId());
        if (existingReview.isPresent()) {
            throw new RuntimeException("Bạn đã đánh giá sản phẩm này rồi");
        }

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new RuntimeException("Product not found"));

        Review review = new Review();
        review.setUser(user);
        review.setProduct(product);
        review.setStars(request.getStars());
        review.setCommentVi(request.getCommentVi());
        review.setCommentEn(request.getCommentEn());
        review.setCreatedAt(LocalDateTime.now());

        review = reviewRepository.save(review);
        return convertToDTO(review);
    }

    @Override
    public List<ReviewDTO> getProductReviews(Long productId) {
        return reviewRepository.findByProduct_IdOrderByCreatedAtDesc(productId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<ReviewDTO> getUserReviews(Long userId) {
        return reviewRepository.findByUser_IdOrderByCreatedAtDesc(userId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public Double getAverageRating(Long productId) {
        return reviewRepository.getAverageRatingByProductId(productId);
    }

    @Override
    public boolean hasUserReviewedProduct(Long userId, Long productId) {
        return reviewRepository.findByUser_IdAndProduct_Id(userId, productId).isPresent();
    }

    private ReviewDTO convertToDTO(Review review) {
        return new ReviewDTO(
                review.getId(),
                review.getUser().getId(),
                review.getUser().getUsername(),
                review.getProduct().getId(),
                review.getProduct().getNameVi(),
                review.getStars(),
                review.getCommentVi(),
                review.getCommentEn(),
                review.getCreatedAt()
        );
    }
}
