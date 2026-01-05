package vn.edu.hcmute.springboot3_4_12.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryResponseDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;

import java.util.Collections;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private IProductService productService;

    @Autowired
    private ICategoryService categoryService;
    @GetMapping("/")
    public String home(Model model) {
        try {
            // Lấy 8 sản phẩm mới nhất
            Pageable pageable = PageRequest.of(0, 8, Sort.by("id").descending());
            Page<ProductResponseDTO> products = productService.getAll(pageable);

            if (products != null && !products.getContent().isEmpty()) {
                model.addAttribute("latestProducts", products.getContent());
            } else {
                model.addAttribute("latestProducts", Collections.emptyList());
            }

            // Lấy danh mục
            List<CategoryResponseDTO> categories = categoryService.getAll();
            if (categories != null && !categories.isEmpty()) {
                model.addAttribute("categories", categories);
            } else {
                model.addAttribute("categories", Collections.emptyList());
            }

        } catch (Exception e) {
            System.err.println("=== EXCEPTION trong UserPageController.home() ===");
            e.printStackTrace();

            model.addAttribute("latestProducts", Collections.emptyList());
            model.addAttribute("categories", Collections.emptyList());
        }

        return "user/home";
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            // Chưa đăng nhập -> redirect về login
//            return "redirect:/login";
//        }
//
//        User user = (User) session.getAttribute("user");
//        String role = user.getRole();
//
//        // Redirect theo role
//        if ("ADMIN".equals(role)) {
//            return "redirect:/admin/home";
//        } else if ("VENDOR".equals(role)) {
//            return "redirect:/vendor/dashboard";
//        } else {
//            // USER/CUSTOMER
//            return "redirect:/user/home";
//        }
    }
}

