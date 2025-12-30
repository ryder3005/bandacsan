package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import vn.edu.hcmute.springboot3_4_12.entity.Review;

import java.util.List;
import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByProduct_IdOrderByCreatedAtDesc(Long productId);
    List<Review> findByUser_IdOrderByCreatedAtDesc(Long userId);
    Optional<Review> findByUser_IdAndProduct_Id(Long userId, Long productId);

    @Query("SELECT AVG(r.stars) FROM Review r WHERE r.product.id = :productId")
    Double getAverageRatingByProductId(@Param("productId") Long productId);

    @Query("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId")
    Long countByProductId(@Param("productId") Long productId);

    @Query("SELECT r FROM Review r WHERE r.product.id = :productId")
    List<Review> findRatingsByProductId(@Param("productId") Long productId);
}
