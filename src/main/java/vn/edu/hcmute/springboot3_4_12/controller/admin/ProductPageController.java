package vn.edu.hcmute.springboot3_4_12.controller.admin;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.dto.ProductRequestDTO;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletRequest;

import java.util.List;

@Controller
@RequestMapping("/admin/products")
@RequiredArgsConstructor
public class ProductPageController {

    private final IProductService productService;
    private final ICategoryService categoryService;
    private final VendorService vendorService;
    private final ProductRepository productRepository;

    // Trang danh sách sản phẩm
    @GetMapping
    public String listPage(Model model) {
        model.addAttribute("products", productService.getAll());
        return "admin/product/list";
    }

    // Trang thêm mới sản phẩm
    @GetMapping("/create")
    public String createPage(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        model.addAttribute("vendors", vendorService.findAll());
        return "admin/product/form";
    }

    // Trang chỉnh sửa sản phẩm
    @GetMapping("/{id}/edit")
    @Transactional
    public String editPage(@PathVariable Long id, Model model) {
        try {
            var productDTO = productService.findById(id);
            model.addAttribute("product", productDTO);
            model.addAttribute("categories", categoryService.getAll());
            model.addAttribute("vendors", vendorService.findAll());
            
            // Lấy category IDs từ product entity để pre-select
            var productEntity = productRepository.findById(id);
            if (productEntity.isPresent()) {
                // Force load categories để tránh LazyInitializationException
                var categories = productEntity.get().getCategories();
                var categoryIds = categories.stream()
                    .map(cat -> cat.getId() != null ? cat.getId() : 0L)
                    .filter(catId -> catId > 0)
                    .collect(java.util.stream.Collectors.toList());
                model.addAttribute("selectedCategoryIds", categoryIds);
            }
            
            return "admin/product/form";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Không tìm thấy sản phẩm: " + e.getMessage());
            return "redirect:/admin/products";
        }
    }

    @PostMapping("/create")
    public String createProduct(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        try {
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String vendorIdStr = request.getParameter("vendorId");
            String[] categoryIds = request.getParameterValues("categoryIds");

            // Validation cơ bản
            if (nameVi == null || nameVi.trim().isEmpty()) {
                model.addAttribute("error", "Tên sản phẩm tiếng Việt không được để trống");
                model.addAttribute("categories", categoryService.getAll());
                model.addAttribute("vendors", vendorService.findAll());
                return "admin/product/form";
            }

            ProductRequestDTO dto = new ProductRequestDTO();
            dto.setNameVi(nameVi.trim());
            dto.setNameEn(nameEn != null ? nameEn.trim() : null);
            dto.setDescriptionVi(descriptionVi != null ? descriptionVi.trim() : null);
            dto.setDescriptionEn(descriptionEn != null ? descriptionEn.trim() : null);
            dto.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0.0);
            dto.setStock(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);
            dto.setVendorId(vendorIdStr != null && !vendorIdStr.isEmpty() ? Long.parseLong(vendorIdStr) : null);

            // Xử lý categories
            if (categoryIds != null && categoryIds.length > 0) {
                dto.setCategoryIds(java.util.Arrays.stream(categoryIds)
                    .map(Long::parseLong)
                    .collect(java.util.stream.Collectors.toList()));
            }

            // Tạo sản phẩm (không có file upload trong form đơn giản này)
            productService.create(dto, null);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo sản phẩm thành công!");

            return "redirect:/admin/products";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tạo sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAll());
            model.addAttribute("vendors", vendorService.findAll());
            return "admin/product/form";
        }
    }
    @PostMapping("/save")
    public String saveProduct(
            HttpServletRequest request,
            @RequestParam(value = "files", required = false) List<MultipartFile> files, // Thêm dòng này
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String vendorIdStr = request.getParameter("vendorId");
            String[] categoryIds = request.getParameterValues("categoryIds");

            // Validation cơ bản
            if (nameVi == null || nameVi.trim().isEmpty()) {
                model.addAttribute("error", "Tên sản phẩm tiếng Việt không được để trống");
                model.addAttribute("categories", categoryService.getAll());
                model.addAttribute("vendors", vendorService.findAll());
                return "admin/product/form";
            }

            if (idStr == null || idStr.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "ID sản phẩm không được để trống");
                return "redirect:/admin/products";
            }

            ProductRequestDTO dto = new ProductRequestDTO();
            dto.setNameVi(nameVi.trim());
            dto.setNameEn(nameEn != null ? nameEn.trim() : null);
            dto.setDescriptionVi(descriptionVi != null ? descriptionVi.trim() : null);
            dto.setDescriptionEn(descriptionEn != null ? descriptionEn.trim() : null);
            dto.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0.0);
            dto.setStock(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);
            dto.setVendorId(vendorIdStr != null && !vendorIdStr.isEmpty() ? Long.parseLong(vendorIdStr) : null);

            // Xử lý categories
            if (categoryIds != null && categoryIds.length > 0) {
                dto.setCategoryIds(java.util.Arrays.stream(categoryIds)
                        .map(Long::parseLong)
                        .collect(java.util.stream.Collectors.toList()));
            }

            // SỬA TẠI ĐÂY: Truyền thêm tham số files
            productService.update(Long.parseLong(idStr), dto, files);

            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
            return "redirect:/admin/products";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
            return "redirect:/admin/products";
        }
    }

    // Xóa sản phẩm
    @PostMapping("/delete")
    public String deleteProduct(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "ID sản phẩm không hợp lệ");
                return "redirect:/admin/products";
            }

            Long id = Long.parseLong(idStr);
            productService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");

            return "redirect:/admin/products";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage());
            return "redirect:/admin/products";
        }
    }
}