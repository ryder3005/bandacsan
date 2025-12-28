package vn.edu.hcmute.springboot3_4_12.test;


import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Category;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
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

import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

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
        ProductRequestDTO dto = new ProductRequestDTO();
        dto.setVendorId(1L);
        dto.setCategoryIds(List.of(1L));
        dto.setNameVi("Sản phẩm có ảnh");
        dto.setPrice(1000.0);
        dto.setStock(10);

        // Giả lập danh sách file gửi lên
        MockMultipartFile file1 = new MockMultipartFile(
                "files", "test1.png", "image/png", "content1".getBytes());
        MockMultipartFile file2 = new MockMultipartFile(
                "files", "test2.png", "image/png", "content2".getBytes());
        List<MultipartFile> files = List.of(file1, file2);

        // Khởi tạo các Entity thật bằng Mapper (không Mock Mapper)
        Vendor mockVendor = new Vendor();
        mockVendor.setId(1L);

        Category mockCategory = new Category();
        mockCategory.setId(1L);
        mockCategory.setNameVi("Danh mục điện tử");

        // 2. GIẢ LẬP HÀNH VI (When) - Chỉ mock các Repository và StorageService
        when(vendorRepository.findById(1L)).thenReturn(Optional.of(mockVendor));
        when(categoryRepository.findAllById(anyList())).thenReturn(List.of(mockCategory));

        // Giả lập logic tên file của StorageService
        when(storageService.getSorageFilename(any(MultipartFile.class), anyString()))
                .thenReturn("stored_file_1.png")
                .thenReturn("stored_file_2.png");

        // Khi save, trả về chính object Product đó (giả lập lưu thành công)
        when(productRepository.save(any(Product.class))).thenAnswer(invocation -> invocation.getArgument(0));

        // 3. THỰC THI (Act)
        ProductResponseDTO result = productService.create(dto, files);

        // 4. IN KẾT QUẢ VÀ KIỂM TRA (Assert & System.out)
        System.out.println("----- KẾT QUẢ TEST -----");
        System.out.println("Tên SP trả về: " + result.getNameVi());
        System.out.println("Giá SP: " + result.getPrice());

        assertNotNull(result);
        assertEquals(dto.getNameVi(), result.getNameVi());

        // Kiểm tra và in danh sách ảnh đã xử lý
        ArgumentCaptor<Product> productCaptor = ArgumentCaptor.forClass(Product.class);
        verify(productRepository).save(productCaptor.capture());
        Product savedProduct = productCaptor.getValue();

        System.out.println("Số lượng ảnh đã lưu: " + savedProduct.getImages().size());
        savedProduct.getImages().forEach(img -> System.out.println("URL ảnh trong DB: " + img.getUrl()));

        assertEquals(2, savedProduct.getImages().size());
        verify(storageService, times(2)).store(any(MultipartFile.class), anyString());

        System.out.println("------------------------");
    }
    @Test
    void testUpdateProduct_Success() {
        // 1. CHUẨN BỊ DỮ LIỆU (Given)
        Long productId = 1L;
        ProductRequestDTO dto = new ProductRequestDTO();
        dto.setNameVi("Bánh Pía Sóc Trăng");
        dto.setDescriptionVi("banh sieu ngon ");
        dto.setPrice(34200.4);
        dto.setStock(6);
        dto.setVendorId(1L);
        Product existingProduct = new Product();
        existingProduct.setId(productId);
        existingProduct.setNameVi("Tên cũ");

        // 2. GIẢ LẬP HÀNH VI (When)
        // Khi tìm ID, trả về sản phẩm cũ
        when(productRepository.findById(productId)).thenReturn(Optional.of(existingProduct));
        // Khi lưu, trả về chính sản phẩm đó
        when(productRepository.save(any(Product.class))).thenReturn(existingProduct);

        // 3. THỰC THI (Act)
        ProductResponseDTO result = productService.update(productId, dto);

        // 4. KIỂM TRA KẾT QUẢ (Assert)
        assertNotNull(result);
        verify(productRepository).findById(productId); // Xác nhận hàm findById đã được gọi
        verify(productMapper).updateEntityFromDto(dto, existingProduct); // Xác nhận mapper đã chạy
        verify(productRepository).save(existingProduct); // Xác nhận hàm save đã được gọi
    }

    @Test
    void testUpdateProduct_NotFound() {
        // Giả lập trường hợp không tìm thấy sản phẩm
        when(productRepository.findById(99L)).thenReturn(Optional.empty());

        // Kiểm tra xem có bắn ra Exception đúng như thiết kế không
        assertThrows(RuntimeException.class, () -> {
            productService.update(99L, new ProductRequestDTO());
        });
    }
}