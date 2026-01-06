package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.edu.hcmute.springboot3_4_12.dto.BlogDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.service.IBlogService;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user/products")
@RequiredArgsConstructor
public class UserProductController {

    private final IProductService productService;
    private final IBlogService blogService;

    @GetMapping("/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        ProductResponseDTO product = productService.findById(id);
        List<BlogDTO> relatedBlogs;
        try {
            relatedBlogs = blogService.getBlogsByProduct(id);
        } catch (Exception e) {
            relatedBlogs = Collections.emptyList();
        }

        model.addAttribute("product", product);
        model.addAttribute("blogs", relatedBlogs);
        return "user/product/detail";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<ProductResponseDTO> searchProducts(@RequestParam(value = "limit", required = false) Integer limit,
                                                   @RequestParam(value = "ids", required = false) List<Long> ids) {
        List<ProductResponseDTO> all = productService.getAll();

        if (ids != null && !ids.isEmpty()) {
            all = all.stream()
                    .filter(p -> p.getId() != null && ids.contains(p.getId()))
                    .collect(Collectors.toList());
        }

        if (limit != null && limit > 0 && limit < all.size()) {
            return all.subList(0, limit);
        }
        return all;
    }
}
