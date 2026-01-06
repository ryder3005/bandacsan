package vn.edu.hcmute.springboot3_4_12.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Category;
import vn.edu.hcmute.springboot3_4_12.mapper.CategoryMapper;
import vn.edu.hcmute.springboot3_4_12.repository.CategoryRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private ProductRepository productRepository;

    // Lưu ý: Không cần @Autowired CategoryMapper nếu dùng .INSTANCE

    @Override
    @Transactional(readOnly = true)
    public List<CategoryResponseDTO> getAll() {
        return categoryRepository.findAll().stream()
                .map(category -> CategoryMapper.INSTANCE.toResponseDTO(category))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public CategoryResponseDTO create(CategoryRequestDTO dto) {
        // DTO -> Entity (Dùng INSTANCE)
        Category category = CategoryMapper.INSTANCE.toEntity(dto);
        Category savedCategory = categoryRepository.save(category);
        // Entity -> ResponseDTO (Dùng INSTANCE)
        return CategoryMapper.INSTANCE.toResponseDTO(savedCategory);
    }

    @Override
    @Transactional
    public CategoryResponseDTO update(Long id, CategoryRequestDTO dto) {
        Category existingCategory = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục với ID: " + id));

        // Update dữ liệu (Dùng INSTANCE)
        CategoryMapper.INSTANCE.updateEntityFromDto(dto, existingCategory);

        Category updatedCategory = categoryRepository.save(existingCategory);
        return CategoryMapper.INSTANCE.toResponseDTO(updatedCategory);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        var categoryOpt = categoryRepository.findById(id);
        if (categoryOpt.isEmpty()) {
            throw new RuntimeException("Không tìm thấy danh mục để xóa");
        }
        
        var category = categoryOpt.get();
        
        // Tìm tất cả products đang sử dụng category này
        var productsUsingCategory = productRepository.findByCategories_Id(id);
        
        if (productsUsingCategory != null && !productsUsingCategory.isEmpty()) {
            // Xóa category khỏi tất cả products trước khi xóa category
            for (var product : productsUsingCategory) {
                if (product.getCategories() != null) {
                    product.getCategories().remove(category);
                }
            }
            // Lưu lại các products đã được cập nhật
            productRepository.saveAll(productsUsingCategory);
        }
        
        categoryRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Category> findById(Long id) {
        return categoryRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Category> findAllByIds(Set<Long> categoryIds)
    {
        return categoryRepository.findAllById(categoryIds);
    }

    @Override
    @Transactional
    public <S extends Category> S save(S entity) {
        return categoryRepository.save(entity);
    }
    @Transactional(readOnly = true)
    @Override
    public CategoryResponseDTO getById(Long id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Danh mục không tồn tại"));
        return CategoryMapper.INSTANCE.toResponseDTO(category);
    }

}