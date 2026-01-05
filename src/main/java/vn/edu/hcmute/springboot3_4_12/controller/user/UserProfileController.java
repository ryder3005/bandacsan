package vn.edu.hcmute.springboot3_4_12.controller.user;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.UserRequestDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;

@Controller
public class UserProfileController {

    @Autowired
    private IUserService userService;
    
    @Autowired
    private UserRepository userRepository;

    @GetMapping({"/profile", "/user/profile", "/admin/profile", "/vendor/profile"})
    public String profile(HttpSession session, Model model) {
        Object userObj = session.getAttribute("user");
        if (userObj == null) {
            return "redirect:/login";
        }
        
        User user = (User) userObj;
        model.addAttribute("user", user);
        return "user/profile";
    }

    @PostMapping({"/profile/update", "/user/profile/update", "/admin/profile/update", "/vendor/profile/update"})
    public String updateProfile(
            @RequestParam Long id,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam(required = false) String password,
            @RequestParam(required = false) String confirmPassword,
            @RequestParam String role,
            @RequestParam(required = false) String redirectUrl,
            HttpServletRequest request,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            // Kiểm tra user đã đăng nhập
            Object userObj = session.getAttribute("user");
            if (userObj == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn chưa đăng nhập");
                return "redirect:/login";
            }
            
            User currentUser = (User) userObj;
            
            // Đảm bảo user chỉ có thể sửa thông tin của chính mình
            if (!currentUser.getId().equals(id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền sửa thông tin của người khác");
                String referer = request.getHeader("Referer");
                return (referer != null && !referer.isEmpty()) ? "redirect:" + referer : "redirect:/profile";
            }
            
            // Kiểm tra password nếu có
            if (password != null && !password.trim().isEmpty()) {
                if (password.length() < 6) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự");
                    String referer = request.getHeader("Referer");
                    return (referer != null && !referer.isEmpty()) ? "redirect:" + referer : "redirect:/profile";
                }
                
                if (!password.equals(confirmPassword)) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Mật khẩu xác nhận không khớp");
                    String referer = request.getHeader("Referer");
                    return (referer != null && !referer.isEmpty()) ? "redirect:" + referer : "redirect:/profile";
                }
            }
            
            // Tạo DTO để update
            UserRequestDTO dto = new UserRequestDTO();
            dto.setUsername(username);
            dto.setEmail(email);
            dto.setRole(role);
            
            // Chỉ set password nếu có thay đổi
            if (password != null && !password.trim().isEmpty()) {
                dto.setPassword(password);
            } else {
                dto.setPassword("_unchanged_"); // Dấu hiệu không đổi password
            }
            
            // Cập nhật thông tin
            userService.update(id, dto);
            
            // Cập nhật lại thông tin user trong session bằng cách lấy từ database
            java.util.Optional<User> updatedUserOpt = userRepository.findById(id);
            if (updatedUserOpt.isPresent()) {
                User updatedUser = updatedUserOpt.get();
                // Cập nhật session với thông tin mới
                session.setAttribute("user", updatedUser);
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin thành công!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        // Redirect về trang trước đó hoặc trang profile
        String referer = redirectUrl != null && !redirectUrl.isEmpty() ? redirectUrl : request.getHeader("Referer");
        if (referer != null && !referer.isEmpty() && !referer.contains("/profile/update")) {
            return "redirect:" + referer;
        }
        return "redirect:/profile";
    }
}
