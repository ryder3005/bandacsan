package vn.edu.hcmute.springboot3_4_12.service.impl;

import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.dto.ProductRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Category;
import vn.edu.hcmute.springboot3_4_12.entity.Image;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.mapper.ProductMapper;
import vn.edu.hcmute.springboot3_4_12.repository.CategoryRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vn.edu.hcmute.springboot3_4_12.service.IStorageService;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ProductService implements IProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private VendorRepository vendorRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private IStorageService storageService;
    @Autowired
    private ProductMapper productMapper;

    /* ================= GET ================= */

    @Override
    public List<ProductResponseDTO> getAll() {
        return productRepository.findAll().stream()
                .map(this::convertToResponseDTO)
                .collect(Collectors.toList());
    }

    @Override
    public Page<ProductResponseDTO> getAll(Pageable pageable) {
        return productRepository.findAll(pageable)
                .map(this::convertToResponseDTO);
    }

    @Override
    public ProductResponseDTO findById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm id = " + id));
        ProductResponseDTO productResponseDTO = convertToResponseDTO(product);
        // convertToResponseDTO đã xử lý categories, không cần xử lý lại
        // Đảm bảo categories không null
        if (productResponseDTO.getCategories() == null) {
            productResponseDTO.setCategories(new ArrayList<>());
        }
        return productResponseDTO;
    }

    /* ================= CREATE ================= */

    @Transactional
    @Override
    public ProductResponseDTO create(ProductRequestDTO dto, List<MultipartFile> files) {
        Vendor vendor = vendorRepository.findById(dto.getVendorId())
                .orElseThrow(() -> new RuntimeException("Vendor không tồn tại"));

        List<Category> categories = categoryRepository.findAllById(dto.getCategoryIds());

        Product product = productMapper.toEntity(dto);
        product.setVendor(vendor);
        product.setCategories(categories);

        if (files != null && !files.isEmpty()) {
            List<Image> productImages = new ArrayList<>();
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    String filename = storageService.getSorageFilename(file, UUID.randomUUID().toString());
                    storageService.store(file, filename);

                    Image image = new Image();
                    image.setUrl(filename);
                    image.setProduct(product);
                    productImages.add(image);
                }
            }
            product.setImages( productImages);
        }

        Product savedProduct = productRepository.save(product);
        return convertToResponseDTO(savedProduct);
    }

    /* ================= UPDATE ================= */

    @Transactional
    @Override
    public ProductResponseDTO update(Long id, ProductRequestDTO dto) {
        Product existingProduct = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại id = " + id));

        productMapper.updateEntityFromDto(dto, existingProduct);

        Vendor vendor = vendorRepository.findById(dto.getVendorId())
                .orElseThrow(() -> new RuntimeException("Vendor không tồn tại"));
        List<Category> categories = categoryRepository.findAllById(dto.getCategoryIds());

        existingProduct.setVendor(vendor);
        existingProduct.setCategories( categories);

        Product updatedProduct = productRepository.save(existingProduct);
        return convertToResponseDTO(updatedProduct);
    }

    /* ================= DELETE ================= */

    @Override
    public void delete(Long id) {
        if (!productRepository.existsById(id)) {
            throw new RuntimeException("Không tồn tại sản phẩm id = " + id);
        }
        productRepository.deleteById(id);
    }

    /* ================= HELPER METHOD ================= */

    // Hàm bổ trợ để map Entity sang DTO và xử lý danh sách ảnh
    @Override
    public ProductResponseDTO convertToResponseDTO(Product product) {
        ProductResponseDTO dto = productMapper.toResponseDTO(product);
        
        // Đảm bảo imageUrls luôn là một List, không phải null
        if (product.getImages() != null && !product.getImages().isEmpty()) {
            List<String> urls = product.getImages().stream()
                    .map(Image::getUrl)
                    .filter(url -> url != null && !url.isEmpty())
                    .collect(Collectors.toList());
            dto.setImageUrls(urls);
        } else {
            // Đảm bảo luôn có một List rỗng thay vì null
            dto.setImageUrls(new ArrayList<>());
        }
        
        // Đảm bảo categories luôn là một List, không phải null
        if (dto.getCategories() == null) {
            dto.setCategories(new ArrayList<>());
        }
        
        return dto;
    }
}