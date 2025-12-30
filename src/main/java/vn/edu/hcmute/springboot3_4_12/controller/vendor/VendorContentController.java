package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;

@Controller
@RequestMapping("/vendor")
@RequiredArgsConstructor
public class VendorContentController {

    private final IProductService productService;
    private final ICategoryService categoryService;

    @GetMapping("/products")
    public String products(Model model) {
        model.addAttribute("products", productService.getAll());
        return "vendor/product/list";
    }

    @GetMapping("/categories")
    public String categories(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "vendor/category/list";
    }

    @GetMapping("/orders")
    public String orders(Model model) {
        return "vendor/orders";
    }

    @GetMapping("/shop")
    public String shop(Model model) {
        return "vendor/shop";
    }

    @GetMapping("/revenue")
    public String revenue(Model model) {
        return "vendor/revenue";
    }
}
