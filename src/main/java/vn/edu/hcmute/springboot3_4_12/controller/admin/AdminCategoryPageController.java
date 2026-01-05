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
@RequiredArgsConstructor
public class AdminCategoryPageController {

    private final ICategoryService categoryService;

    @GetMapping("/create")
    public String createForm() {
        return "admin/category/create";
    }

    @PostMapping("/create")
    public String createSubmit(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        try {
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");

            CategoryRequestDTO dto = new CategoryRequestDTO();
            dto.setNameVi(nameVi);
            dto.setNameEn(nameEn);

            categoryService.create(dto);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo danh mục thành công!");
            return "redirect:/admin/categories";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/categories";
        }
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        var opt = categoryService.findById(id);
        if (opt.isEmpty()) {
            return "redirect:/admin/categories";
        }
        // Map entity to response DTO (service also provides DTO list)
        List<CategoryResponseDTO> list = categoryService.getAll();
        CategoryResponseDTO found = list.stream().filter(c -> c.getId().equals(id)).findFirst().orElse(null);
        if (found == null) {
            model.addAttribute("error", "Danh mục không tìm thấy");
            return "redirect:/admin/categories";
        }
        model.addAttribute("category", found);
        return "admin/category/edit";
    }

    @PostMapping("/save")
    public String saveCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            Long id = idStr != null && !idStr.isEmpty() ? Long.parseLong(idStr) : null;
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");

            CategoryRequestDTO dto = new CategoryRequestDTO();
            dto.setNameVi(nameVi);
            dto.setNameEn(nameEn);

            if (id != null) {
                categoryService.update(id, dto);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật danh mục thành công!");
            }
            return "redirect:/admin/categories";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/categories";
        }
    }

    @PostMapping("/delete")
    public String deleteCategory(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String idStr = request.getParameter("id");
        try {
            Long id = Long.parseLong(idStr);
            categoryService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa danh mục thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa danh mục: " + e.getMessage());
        }
        return "redirect:/admin/categories";
    }
}
