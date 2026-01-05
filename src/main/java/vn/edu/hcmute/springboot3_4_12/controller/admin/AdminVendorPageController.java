package vn.edu.hcmute.springboot3_4_12.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;
import vn.edu.hcmute.springboot3_4_12.dto.VendorRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.VendorResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;

@Controller
@RequestMapping("/admin/vendors")
@RequiredArgsConstructor
public class AdminVendorPageController {

    private final VendorService vendorService;
    private final IUserService userService;
    private final VendorRepository vendorRepository;

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/vendors/create";
    }

    @PostMapping("/create")
    public String createSubmit(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        try {
            String userIdStr = request.getParameter("userId");
            String storeName = request.getParameter("storeName");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            VendorRequestDTO dto = new VendorRequestDTO();
            dto.setUserId(Long.parseLong(userIdStr));
            dto.setStoreName(storeName);
            dto.setDescriptionVi(descriptionVi);
            dto.setDescriptionEn(descriptionEn);
            dto.setAddress(address);
            dto.setPhone(phone);

            vendorService.create(dto);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo nhà bán hàng thành công!");
            return "redirect:/admin/vendors";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("users", userService.getAllUsers());
            return "admin/vendors/create";
        }
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Long id, Model model) {
        try {
            VendorResponseDTO vendor = vendorService.findById(id);
            Vendor vendorEntity = vendorRepository.findById(id).orElse(null);
            if (vendorEntity != null && vendorEntity.getUser() != null) {
                model.addAttribute("userId", vendorEntity.getUser().getId());
            }
            model.addAttribute("vendor", vendor);
            model.addAttribute("users", userService.getAllUsers());
            return "admin/vendors/edit";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/admin/vendors";
        }
    }

    @PostMapping("/save")
    public String saveVendor(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            Long id = idStr != null && !idStr.isEmpty() ? Long.parseLong(idStr) : null;
            String userIdStr = request.getParameter("userId");
            String storeName = request.getParameter("storeName");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            VendorRequestDTO dto = new VendorRequestDTO();
            dto.setUserId(Long.parseLong(userIdStr));
            dto.setStoreName(storeName);
            dto.setDescriptionVi(descriptionVi);
            dto.setDescriptionEn(descriptionEn);
            dto.setAddress(address);
            dto.setPhone(phone);

            if (id != null) {
                vendorService.update(id, dto);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhà bán hàng thành công!");
            }
            return "redirect:/admin/vendors";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/vendors";
        }
    }

    @PostMapping("/delete")
    public String deleteVendor(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                Long id = Long.parseLong(idStr);
                vendorService.delete(id);
                redirectAttributes.addFlashAttribute("successMessage", "Xóa nhà bán hàng thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa nhà bán hàng: " + e.getMessage());
        }
        return "redirect:/admin/vendors";
    }
}

