package vn.edu.hcmute.springboot3_4_12.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import vn.edu.hcmute.springboot3_4_12.dto.UserRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.UserResponseDTO;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;

import java.util.Optional;

@Controller
@RequestMapping("/admin/users")
@RequiredArgsConstructor
public class AdminUserPageController {

    private final IUserService userService;

    @GetMapping("/create")
    public String createForm() {
        return "admin/users/create";
    }

    @PostMapping("/create")
    public String createSubmit(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");

            UserRequestDTO dto = new UserRequestDTO();
            dto.setUsername(username);
            dto.setPassword(password);
            dto.setEmail(email);
            dto.setRole(role != null ? role : "CUSTOMER");

            userService.register(dto);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo người dùng thành công!");
            return "redirect:/admin/users";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/users/create";
        }
    }

    @GetMapping("/edit/{username}")
    public String editForm(@PathVariable String username, Model model) {
        UserResponseDTO dto = userService.findByUsername(username);
        if (dto == null) {
            model.addAttribute("error", "Người dùng không tồn tại");
            return "redirect:/admin/users";
        }
        model.addAttribute("user", dto);
        return "admin/users/edit";
    }

    @PostMapping("/save")
    public String saveUser(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        try {
            String idStr = request.getParameter("id");
            Long id = idStr != null && !idStr.isEmpty() ? Long.parseLong(idStr) : null;
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");

            UserRequestDTO dto = new UserRequestDTO();
            dto.setUsername(username);
            // If password empty, set a dummy long password to skip validation or handle accordingly in service
            if (password == null || password.isEmpty()) {
                dto.setPassword("_unchanged_");
            } else {
                dto.setPassword(password);
            }
            dto.setEmail(email);
            dto.setRole(role != null ? role : "CUSTOMER");

            if (id != null) {
                userService.update(id, dto);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật người dùng thành công!");
            }
            return "redirect:/admin/users";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }

    @PostMapping("/delete")
    public String deleteUser(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        String username = request.getParameter("username");
        try {
            UserResponseDTO dto = userService.findByUsername(username);
            if (dto != null && dto.id() != null) {
                userService.deleteUser(dto.id());
                redirectAttributes.addFlashAttribute("successMessage", "Xóa người dùng thành công!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa người dùng: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}
