package vn.edu.hcmute.springboot3_4_12.controller.admin.api;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.dto.ProductRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/api/products")
public class ProductController {


    private final IProductService productService;

    /* ================= GET ================= */

    @GetMapping
    public ResponseEntity<Page<ProductResponseDTO>> getAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        // Trả về Page của DTO thay vì Entity
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        return ResponseEntity.ok(productService.getAll(pageable));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponseDTO> getById(@PathVariable Long id) {
        // Đổi kiểu trả về sang ProductResponseDTO
        return ResponseEntity.ok(productService.findById(id));
    }

    /* ================= CREATE ================= */

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProductResponseDTO> create(
            @Valid @RequestPart("product") ProductRequestDTO dto,
            @RequestPart(value = "files", required = false) List<MultipartFile> files) {

        ProductResponseDTO result = productService.create(dto, files);
        return ResponseEntity.ok(result);
    }

    /* ================= UPDATE ================= */

    @PutMapping("/{id}")
    public ResponseEntity<ProductResponseDTO> update(
            @PathVariable Long id,
            @RequestBody ProductRequestDTO dto
    ) {
        // Validation được xử lý trong service layer
        try {
            ProductResponseDTO result = productService.update(id, dto);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /* ================= DELETE ================= */

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        productService.delete(id);
        return ResponseEntity.noContent().build();
    }
}