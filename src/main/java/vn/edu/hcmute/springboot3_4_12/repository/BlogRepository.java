package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import vn.edu.hcmute.springboot3_4_12.entity.Blog;

import java.util.List;

public interface BlogRepository extends JpaRepository<Blog, Long> {
    @Query("SELECT b FROM Blog b ORDER BY b.createdAt DESC")
    List<Blog> findAllByOrderByCreatedAtDesc();

    @Query("SELECT b FROM Blog b WHERE b.author.id = :authorId ORDER BY b.createdAt DESC")
    List<Blog> findByAuthor_IdOrderByCreatedAtDesc(Long authorId);

    @Query("SELECT b FROM Blog b WHERE LOWER(b.titleVi) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(b.titleEn) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(b.contentVi) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(b.contentEn) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Blog> searchBlogs(@Param("keyword") String keyword);

    @Query("SELECT b FROM Blog b JOIN b.products p WHERE p.id = :productId")
    List<Blog> findBlogsByProductId(@Param("productId") Long productId);
}
