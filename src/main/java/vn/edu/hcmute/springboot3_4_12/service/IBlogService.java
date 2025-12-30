package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.dto.BlogDTO;
import vn.edu.hcmute.springboot3_4_12.dto.BlogRequestDTO;

import java.util.List;

public interface IBlogService {
    List<BlogDTO> getAllBlogs();
    BlogDTO getBlogById(Long id);
    BlogDTO createBlog(BlogRequestDTO request, Long authorId);
    BlogDTO updateBlog(Long id, BlogRequestDTO request, Long authorId);
    void deleteBlog(Long id, Long authorId);
    List<BlogDTO> getBlogsByAuthor(Long authorId);
    List<BlogDTO> searchBlogs(String keyword);
    List<BlogDTO> getBlogsByProduct(Long productId);
}
