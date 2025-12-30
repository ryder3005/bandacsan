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
public class BlogController {

    private final IBlogService blogService;

    @GetMapping
    @Transactional(readOnly = true)
    public String listBlogs(@RequestParam(required = false) String search, Model model) {
        List<BlogDTO> blogs;
        if (search != null && !search.trim().isEmpty()) {
            blogs = blogService.searchBlogs(search.trim());
            model.addAttribute("searchKeyword", search);
        } else {
            blogs = blogService.getAllBlogs();
        }

        model.addAttribute("blogs", blogs);
        return "user/blogs/list";
    }

    @GetMapping("/{id}")
    @Transactional(readOnly = true)
    public String viewBlog(@PathVariable Long id, Model model) {
        try {
            BlogDTO blog = blogService.getBlogById(id);
            model.addAttribute("blog", blog);
            return "user/blogs/detail";
        } catch (Exception e) {
            model.addAttribute("error", "Không tìm thấy bài viết: " + e.getMessage());
            return "redirect:/user/blogs";
        }
    }

    @GetMapping("/create")
    public String createBlogForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("blog", new BlogRequestDTO());
        model.addAttribute("isEdit", false);
        return "user/blogs/form";
    }

    @GetMapping("/edit/{id}")
    public String editBlogForm(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Validate user ID
        if (user.getId() == null) {
            return "redirect:/login";
        }

        try {
            BlogDTO blog = blogService.getBlogById(id);

            // Check if user is the author
            if (blog.getAuthorId() == null || !blog.getAuthorId().equals(user.getId())) {
                model.addAttribute("error", "Bạn chỉ có thể chỉnh sửa bài viết của mình");
                return "redirect:/user/blogs";
            }

            BlogRequestDTO request = new BlogRequestDTO();
            request.setId(blog.getId());
            request.setTitleVi(blog.getTitleVi());
            request.setTitleEn(blog.getTitleEn());
            request.setSummaryVi(blog.getSummaryVi());
            request.setSummaryEn(blog.getSummaryEn());
            request.setContentVi(blog.getContentVi());
            request.setContentEn(blog.getContentEn());
            request.setImageUrl(blog.getImageUrl());

            // Safely get product IDs
            if (blog.getProducts() != null) {
                request.setProductIds(blog.getProducts().stream()
                        .map(p -> p.getId())
                        .collect(java.util.stream.Collectors.toList()));
            } else {
                request.setProductIds(new java.util.ArrayList<>());
            }

            model.addAttribute("blog", request);
            model.addAttribute("isEdit", true);
            return "user/blogs/form";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Không tìm thấy bài viết: " + e.getMessage());
            return "redirect:/user/blogs";
        }
    }

    @PostMapping("/save")
    public String saveBlog(@ModelAttribute BlogRequestDTO blogRequest,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Validate user ID
        if (user.getId() == null) {
            redirectAttributes.addFlashAttribute("error", "Lỗi: Không thể xác định người dùng");
            return "redirect:/login";
        }

        try {
            if (blogRequest.getId() != null) {
                // Update existing blog
                blogService.updateBlog(blogRequest.getId(), blogRequest, user.getId());
                redirectAttributes.addFlashAttribute("success", "Bài viết đã được cập nhật thành công!");
            } else {
                // Create new blog
                blogService.createBlog(blogRequest, user.getId());
                redirectAttributes.addFlashAttribute("success", "Bài viết đã được tạo thành công!");
            }
        } catch (Exception e) {
            // Log the full exception for debugging
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
            return "redirect:/user/blogs/create";
        }

        return "redirect:/user/blogs";
    }

    @PostMapping("/delete/{id}")
    public String deleteBlog(@PathVariable Long id,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Validate user ID
        if (user.getId() == null) {
            redirectAttributes.addFlashAttribute("error", "Lỗi: Không thể xác định người dùng");
            return "redirect:/login";
        }

        try {
            blogService.deleteBlog(id, user.getId());
            redirectAttributes.addFlashAttribute("success", "Bài viết đã được xóa thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi: " + e.getMessage());
        }

        return "redirect:/user/blogs";
    }

    @GetMapping("/my-blogs")
    public String myBlogs(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // Validate user ID
        if (user.getId() == null) {
            return "redirect:/login";
        }

        try {
            List<BlogDTO> blogs = blogService.getBlogsByAuthor(user.getId());
            model.addAttribute("blogs", blogs);
            model.addAttribute("isMyBlogs", true);
            return "user/blogs/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi khi tải bài viết của bạn: " + e.getMessage());
            return "user/blogs/list";
        }
    }
}
