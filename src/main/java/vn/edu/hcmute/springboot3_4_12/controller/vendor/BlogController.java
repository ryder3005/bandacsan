package vn.edu.hcmute.springboot3_4_12.controller.vendor;

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
@RequestMapping("/vendor/blogs")
@RequiredArgsConstructor
public class BlogController {

    private final IBlogService blogService;


    @GetMapping
    public String listMyBlogs(@RequestParam(value = "search", required = false) String search,
                              HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) return "redirect:/login";

        List<BlogDTO> blogs;
        if (search != null && !search.trim().isEmpty()) {
            blogs = blogService.searchBlogs(search);
            model.addAttribute("searchKeyword", search);
        } else {
            blogs = blogService.getAllBlogs(); // Lấy tất cả blog của mọi người
        }
        
        model.addAttribute("blogs", blogs);
        model.addAttribute("currentUserId", user.getId()); // Để view có thể phân biệt blog nào là của vendor này
        model.addAttribute("isMyBlogs", false); // Đánh dấu đây là trang xem tất cả blog
        return "vendor/blogs/list"; // View quản lý riêng của Vendor
    }
    @GetMapping("/{id}")
    @Transactional(readOnly = true)
    public String viewBlog(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }
        try {
            BlogDTO blog = blogService.getBlogById(id);
            model.addAttribute("blog", blog);
            return "vendor/blogs/detail";
        } catch (Exception e) {
            model.addAttribute("error", "Không tìm thấy bài viết: " + e.getMessage());
            return "redirect:/vendor/blogs";
        }
    }

    @GetMapping("/create")
    public String createBlogForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) return "redirect:/login";

        model.addAttribute("blog", new BlogRequestDTO());
        model.addAttribute("isEdit", false);
        return "vendor/blogs/form"; // Form này có thể tích hợp CKEditor
    }

    @PostMapping("/save")
    public String saveBlog(@ModelAttribute BlogRequestDTO blogRequest,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        // Kiểm tra quyền VENDOR trước khi lưu
        if (user == null || !"VENDOR".equals(user.getRole())) return "redirect:/login";

        try {
            if (blogRequest.getId() != null) {
                blogService.updateBlog(blogRequest.getId(), blogRequest, user.getId());
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thành công!");
            } else {
                blogService.createBlog(blogRequest, user.getId());
                redirectAttributes.addFlashAttribute("successMessage", "Đã đăng bài viết mới!");
            }
            return "redirect:/vendor/blogs"; // Quay về trang quản lý của Vendor
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
            return "redirect:/vendor/blogs/create";
        }
    }

    @GetMapping("/edit/{id}")
    public String editBlogForm(@PathVariable Long id,
                               Model model,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole()) || user.getId() == null) {
            return "redirect:/login";
        }

        try {
            BlogDTO blog = blogService.getBlogById(id);

            // Check if user is the author
            if (blog.getAuthorId() == null || !blog.getAuthorId().equals(user.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn chỉ có thể chỉnh sửa bài viết của mình");
                return "redirect:/vendor/blogs";
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
            return "vendor/blogs/form";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Không tìm thấy bài viết: " + e.getMessage());
            return "redirect:/vendor/blogs";
        }
    }



    @PostMapping("/delete/{id}")
    public String deleteBlog(@PathVariable Long id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole()) || user.getId() == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng đăng nhập bằng tài khoản Vendor");
            return "redirect:/login";
        }

        try {
            blogService.deleteBlog(id, user.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Xóa bài viết thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }

        return "redirect:/vendor/blogs";
    }

    @GetMapping("/my-blogs")
    public String myBlogs(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole()) || user.getId() == null) {
            return "redirect:/login";
        }

        try {
            List<BlogDTO> blogs = blogService.getBlogsByAuthor(user.getId());
            model.addAttribute("blogs", blogs);
            model.addAttribute("isMyBlogs", true);
            return "vendor/blogs/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi khi tải bài viết của bạn: " + e.getMessage());
            return "vendor/blogs/list";
        }
    }
}