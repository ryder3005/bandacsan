package vn.edu.hcmute.springboot3_4_12.repository;

import vn.edu.hcmute.springboot3_4_12.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Set;
public interface ProductRepository extends JpaRepository<Product,Long> {

    List<Product> findByNameViContaining(String keyword);

    List<Product> findByNameEnContaining(String keyword);

    List<Product> findByPriceBetween(Double min, Double max);

    List<Product> findByStockGreaterThan(Integer stock);

    List<Product> findByVendor_Id(Long vendorId);

    List<Product> findByCategories_Id(Long categoryId);

    @Query("""
        SELECT p FROM Product p
        WHERE p.nameVi LIKE %:keyword%
           OR p.nameEn LIKE %:keyword%
    """)
    List<Product> searchByName(@Param("keyword") String keyword);
    @Query("SELECT p FROM Product p WHERE " +
            "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
            "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
            "(:vendorId IS NULL OR p.vendor.id = :vendorId)")
    List<Product> filterProducts(
            @Param("minPrice") Double minPrice,
            @Param("maxPrice") Double maxPrice,
            @Param("vendorId") Long vendorId
    );
}
