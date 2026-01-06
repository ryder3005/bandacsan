package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.BlogDTO;
import vn.edu.hcmute.springboot3_4_12.dto.BlogRequestDTO;
import vn.edu.hcmute.springboot3_4_12.service.IBlogService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;


@Controller
@RequestMapping("/user/blogs")
@RequiredArgsConstructor
public class UserBlogController {

    private final IBlogService blogService;

    /**
     * Xem danh sách tất cả các bài viết (Dành cho khách hàng)
     */
    @GetMapping
    public String listBlogs(@RequestParam(value = "search", required = false) String search,
                            Model model) {
        List<BlogDTO> blogs;

        if (search != null && !search.trim().isEmpty()) {
            // Giả sử service của bạn có hàm tìm kiếm, nếu không dùng getAll
            blogs = blogService.searchBlogs(search);
            model.addAttribute("searchKeyword", search);
        } else {
            blogs = blogService.getAllBlogs(); // Lấy tất cả bài viết công khai
        }

        model.addAttribute("blogs", blogs);
        model.addAttribute("isMyBlogs", false);
        return "user/blogs/list"; // Trỏ về view danh sách cho người dùng
    }

    /**
     * Xem chi tiết một bài viết cụ thể
     */
    @GetMapping("/{id}")
    @Transactional(readOnly = true)
    public String viewBlog(@PathVariable Long id, Model model) {
        try {
            BlogDTO blog = blogService.getBlogById(id);
            model.addAttribute("blog", blog);
            return "user/blogs/detail"; // Trỏ về view chi tiết cho người dùng
        } catch (Exception e) {
            model.addAttribute("error", "Không tìm thấy bài viết: " + e.getMessage());
            return "redirect:/user/blogs";
        }
    }
}