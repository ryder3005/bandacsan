package vn.edu.hcmute.springboot3_4_12.test;

import jakarta.transaction.Transactional;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@Transactional
class ProductRepositoryTest {

    @Autowired
    private ProductRepository productRepository;

    @Test
    void testFindProductWithImages() {
        Product product = productRepository.findById(27L).orElse(null);
        assertNotNull(product);
        System.out.println(product.getImages());
    }
}
