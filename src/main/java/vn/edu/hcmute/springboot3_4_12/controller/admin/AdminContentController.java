package vn.edu.hcmute.springboot3_4_12.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminContentController {

    private final IProductService productService;
    private final ICategoryService categoryService;
    private final IUserService userService;
    private final VendorService vendorService;

    // Note: product list for /admin/products is handled by existing ProductPageController
    @GetMapping("/categories")
    public String categories(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "admin/category/list";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users/list";
    }

    @GetMapping("/vendors")
    public String vendors(Model model) {
        model.addAttribute("vendors", vendorService.findAll());
        return "admin/vendors/list";
    }
}
