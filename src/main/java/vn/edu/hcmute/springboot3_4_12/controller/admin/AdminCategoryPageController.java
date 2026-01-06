package vn.edu.hcmute.springboot3_4_12.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryResponseDTO;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;

import java.util.List;


@Controller
@RequestMapping("/admin/categories")
@RequiredArgsConstructor // Sử dụng Constructor Injection thay cho @Autowired (khuyên dùng)
public class AdminCategoryPageController {

    private final ICategoryService categoryService;

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("category", new CategoryRequestDTO());
        return "admin/category/create";
    }

    @PostMapping("/create")
    public String createSubmit(@ModelAttribute CategoryRequestDTO dto, RedirectAttributes redirectAttributes) {
        try {
            categoryService.create(dto);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo danh mục thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            CategoryResponseDTO found = categoryService.getById(id);
            model.addAttribute("category", found);
            return "admin/category/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục");
            return "redirect:/admin/categories";
        }
    }

    @PostMapping("/update/{id}") // Nên tách rõ update và create
    public String updateCategory(@PathVariable Long id, @ModelAttribute CategoryRequestDTO dto, RedirectAttributes redirectAttributes) {
        try {
            categoryService.update(id, dto);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @PostMapping("/delete")
    public String deleteCategory(@RequestParam Long id, RedirectAttributes redirectAttributes) {
        try {
            categoryService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
}
