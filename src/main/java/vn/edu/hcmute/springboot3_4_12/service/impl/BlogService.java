package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.BlogDTO;
import vn.edu.hcmute.springboot3_4_12.dto.BlogRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Blog;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.BlogRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.service.IBlogService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class BlogService implements IBlogService {

    private final BlogRepository blogRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    @Override
    @Transactional(readOnly = true)
    public List<BlogDTO> getAllBlogs() {
        return blogRepository.findAllByOrderByCreatedAtDesc()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public BlogDTO getBlogById(Long id) {
        Blog blog = blogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Blog not found"));
        return convertToDTO(blog);
    }

    @Override
    public BlogDTO createBlog(BlogRequestDTO request, Long authorId) {
        // Validate input parameters
        if (authorId == null) {
            throw new IllegalArgumentException("Author ID cannot be null");
        }

        if (request == null) {
            throw new IllegalArgumentException("Blog request cannot be null");
        }

        if (request.getTitleVi() == null || request.getTitleVi().trim().isEmpty()) {
            throw new IllegalArgumentException("Tiêu đề tiếng Việt không được để trống");
        }

        if (request.getContentVi() == null || request.getContentVi().trim().isEmpty()) {
            throw new IllegalArgumentException("Nội dung tiếng Việt không được để trống");
        }

        User author = userRepository.findById(authorId)
                .orElseThrow(() -> new RuntimeException("Author not found"));

        Blog blog = new Blog();
        blog.setTitleVi(request.getTitleVi().trim());
        blog.setTitleEn(request.getTitleEn() != null ? request.getTitleEn().trim() : null);
        blog.setSummaryVi(request.getSummaryVi() != null ? request.getSummaryVi().trim() : null);
        blog.setSummaryEn(request.getSummaryEn() != null ? request.getSummaryEn().trim() : null);
        blog.setContentVi(request.getContentVi().trim());
        blog.setContentEn(request.getContentEn() != null ? request.getContentEn().trim() : null);
        blog.setImageUrl(request.getImageUrl() != null ? request.getImageUrl().trim() : null);
        blog.setAuthor(author);
        blog.setCreatedAt(LocalDateTime.now());
        blog.setUpdatedAt(LocalDateTime.now());

        // Generate slug from Vietnamese title
        blog.setSlug(generateSlug(request.getTitleVi()));

        // Set products
        if (request.getProductIds() != null && !request.getProductIds().isEmpty()) {
            try {
                List<Product> products = productRepository.findAllById(request.getProductIds());
                blog.setProducts(products);
            } catch (Exception e) {
                // If product loading fails, continue without products
                System.err.println("Warning: Failed to load products for blog: " + e.getMessage());
                blog.setProducts(new java.util.ArrayList<>());
            }
        }

        Blog savedBlog = blogRepository.save(blog);
        return convertToDTO(savedBlog);
    }

    @Override
    public BlogDTO updateBlog(Long id, BlogRequestDTO request, Long authorId) {
        // Validate input parameters
        if (id == null) {
            throw new IllegalArgumentException("Blog ID cannot be null");
        }

        if (authorId == null) {
            throw new IllegalArgumentException("Author ID cannot be null");
        }

        if (request == null) {
            throw new IllegalArgumentException("Blog request cannot be null");
        }

        if (request.getTitleVi() == null || request.getTitleVi().trim().isEmpty()) {
            throw new IllegalArgumentException("Tiêu đề tiếng Việt không được để trống");
        }

        if (request.getContentVi() == null || request.getContentVi().trim().isEmpty()) {
            throw new IllegalArgumentException("Nội dung tiếng Việt không được để trống");
        }

        Blog blog = blogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Blog not found"));

        // Check if user is the author
        if (blog.getAuthor() == null || !blog.getAuthor().getId().equals(authorId)) {
            throw new RuntimeException("You can only edit your own blogs");
        }

        blog.setTitleVi(request.getTitleVi().trim());
        blog.setTitleEn(request.getTitleEn() != null ? request.getTitleEn().trim() : null);
        blog.setSummaryVi(request.getSummaryVi() != null ? request.getSummaryVi().trim() : null);
        blog.setSummaryEn(request.getSummaryEn() != null ? request.getSummaryEn().trim() : null);
        blog.setContentVi(request.getContentVi().trim());
        blog.setContentEn(request.getContentEn() != null ? request.getContentEn().trim() : null);
        blog.setImageUrl(request.getImageUrl() != null ? request.getImageUrl().trim() : null);
        blog.setSlug(generateSlug(request.getTitleVi()));
        blog.setUpdatedAt(LocalDateTime.now());

        // Update products
        if (request.getProductIds() != null) {
            try {
                List<Product> products = productRepository.findAllById(request.getProductIds());
                blog.setProducts(products);
            } catch (Exception e) {
                // If product loading fails, continue without products
                System.err.println("Warning: Failed to load products for blog update: " + e.getMessage());
                blog.setProducts(new java.util.ArrayList<>());
            }
        }

        Blog updatedBlog = blogRepository.save(blog);
        return convertToDTO(updatedBlog);
    }

    @Override
    public void deleteBlog(Long id, Long authorId) {
        // Validate input parameters
        if (id == null) {
            throw new IllegalArgumentException("Blog ID cannot be null");
        }

        if (authorId == null) {
            throw new IllegalArgumentException("Author ID cannot be null");
        }

        Blog blog = blogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Blog not found"));

        // Check if user is the author
        if (blog.getAuthor() == null || !blog.getAuthor().getId().equals(authorId)) {
            throw new RuntimeException("You can only delete your own blogs");
        }

        blogRepository.delete(blog);
    }

    @Override
    @Transactional(readOnly = true)
    public List<BlogDTO> getBlogsByAuthor(Long authorId) {
        return blogRepository.findByAuthor_IdOrderByCreatedAtDesc(authorId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<BlogDTO> searchBlogs(String keyword) {
        return blogRepository.searchBlogs(keyword)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<BlogDTO> getBlogsByProduct(Long productId) {
        return blogRepository.findBlogsByProductId(productId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    private BlogDTO convertToDTO(Blog blog) {
        List<ProductResponseDTO> productDTOs = new java.util.ArrayList<>();

        try {
            // Safely get products list
            List<Product> products = blog.getProducts();
            if (products != null) {
                productDTOs = products.stream()
                        .map(product -> {
                            try {
                                return new ProductResponseDTO(
                                        product.getId(),
                                        product.getNameVi(),
                                        product.getNameEn(),
                                        product.getDescriptionVi(),
                                        product.getDescriptionEn(),
                                        product.getPrice(),
                                        product.getStock(),
                                        product.getVendor() != null ? product.getVendor().getId() : null,
                                        product.getVendor() != null ? product.getVendor().getStoreName() : null,
                                        // Safely handle categories - if not loaded, return empty list
                                        product.getCategories() != null ?
                                            product.getCategories().stream()
                                                .map(cat -> cat.getNameVi())
                                                .collect(Collectors.toList()) :
                                            new java.util.ArrayList<>(),
                                        // Safely handle images - if not loaded, return empty list
                                        product.getImages() != null ?
                                            product.getImages().stream()
                                                .map(img -> img.getUrl())
                                                .collect(Collectors.toList()) :
                                            new java.util.ArrayList<>()
                                );
                            } catch (Exception e) {
                                // If any lazy loading fails, return basic product info
                                return new ProductResponseDTO(
                                        product.getId(),
                                        product.getNameVi(),
                                        product.getNameEn(),
                                        product.getDescriptionVi(),
                                        product.getDescriptionEn(),
                                        product.getPrice(),
                                        product.getStock(),
                                        product.getVendor() != null ? product.getVendor().getId() : null,
                                        product.getVendor() != null ? product.getVendor().getStoreName() : null,
                                        new java.util.ArrayList<>(),
                                        new java.util.ArrayList<>()
                                );
                            }
                        })
                        .collect(Collectors.toList());
            }
        } catch (Exception e) {
            // If products lazy loading fails, return empty list
            productDTOs = new java.util.ArrayList<>();
        }

        return new BlogDTO(
                blog.getId(),
                blog.getTitleVi(),
                blog.getTitleEn(),
                blog.getSummaryVi(),
                blog.getSummaryEn(),
                blog.getContentVi(),
                blog.getContentEn(),
                blog.getSlug(),
                blog.getImageUrl(),
                blog.getAuthor().getUsername(),
                blog.getAuthor().getId(),
                productDTOs,
                blog.getCreatedAt(),
                blog.getUpdatedAt()
        );
    }

    private String generateSlug(String title) {
        if (title == null) return "";
        return title.toLowerCase()
                .replaceAll("[^a-zA-Z0-9\\s]", "")
                .replaceAll("\\s+", "-")
                .replaceAll("-+", "-")
                .replaceAll("^-|-$", "");
    }
}
