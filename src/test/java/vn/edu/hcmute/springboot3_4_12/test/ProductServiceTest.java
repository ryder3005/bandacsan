package vn.edu.hcmute.springboot3_4_12.test;


import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.demo.Car;
import vn.edu.hcmute.springboot3_4_12.entity.demo.CarDto;
import vn.edu.hcmute.springboot3_4_12.entity.demo.CarMapper;
import vn.edu.hcmute.springboot3_4_12.mapper.CategoryMapper;
import vn.edu.hcmute.springboot3_4_12.mapper.ProductMapper;

import vn.edu.hcmute.springboot3_4_12.repository.CategoryRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import org.mockito.junit.jupiter.MockitoExtension;
import org.junit.jupiter.api.extension.ExtendWith;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IStorageService;
import vn.edu.hcmute.springboot3_4_12.service.impl.ProductService;

@ExtendWith(MockitoExtension.class) // Sử dụng Mockito cho JUnit 5
public class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;


    @Mock
    private CategoryMapper categoryMapper;
    @Mock
    private VendorRepository vendorRepository;

    @Mock
    private CategoryRepository categoryRepository;
    @InjectMocks
    private ProductService productService; // Tự động tiêm các Mock vào đây
    @Mock
    private IStorageService storageService;
    @Spy
    private final ProductMapper productMapper = ProductMapper.INSTANCE;
    @Test
    public void shouldMapCarToDto() {
        //given
        Car car = new Car(1L, "Morris", 5, "sedan");
//        car.setId(5);


        //when
        CarDto carDto = CarMapper.INSTANCE.carToCarDto( car );
        System.out.println(carDto);

    }
    @Test
    void testCreateProduct_WithFiles_Success() {
        // 1. CHUẨN BỊ DỮ LIỆU (Given)
        Product product=productRepository.findById(27L).orElse(null);
        assertNotNull(product);
        System.out.println(product.getImages());

    }


}