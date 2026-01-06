package vn.edu.hcmute.springboot3_4_12.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;
import vn.edu.hcmute.springboot3_4_12.dto.UserRequestDTO;
import java.util.Optional;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "forgot-password";
    }

    @GetMapping("/reset-password")
    public String resetPassword() {
        return "reset-password";
    }

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private IUserService userService;

    @PostMapping("/perform_login")
    public String performLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpServletRequest request) {
        try {
            Optional<User> opt = userRepository.findUserByUsername(username);
            if (opt.isEmpty()) {
                request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
                return "login";
            }

            User user = opt.get();
            
            if (!passwordEncoder.matches(password, user.getPassword())) {
                request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
                return "login";
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            // Redirect theo role
            String role = user.getRole();
            
            if ("ADMIN".equals(role)) {
                return "redirect:/admin/home";
            } else if ("VENDOR".equals(role)) {
                return "redirect:/vendor/dashboard";
            } else {
                // USER/CUSTOMER
                return "redirect:/user/home";
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Có lỗi xảy ra khi đăng nhập: " + e.getMessage());
            return "login";
        }
    }

    @PostMapping("/register")
    public String performRegister(@RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam String email,
                                  @RequestParam(required = false) String phone,
                                  HttpServletRequest request,
                                  org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            // Tạo DTO từ form data
            UserRequestDTO dto = new UserRequestDTO();
            dto.setUsername(username);
            dto.setPassword(password);
            dto.setEmail(email);
            dto.setRole("CUSTOMER"); // Mặc định là CUSTOMER
            
            // Gọi service để đăng ký
            userService.register(dto);
            
            // Đăng ký thành công, redirect về login
            redirectAttributes.addFlashAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            return "redirect:/login";
        } catch (Exception e) {
            // Nếu có lỗi (ví dụ: username đã tồn tại)
            request.setAttribute("message", e.getMessage() != null ? e.getMessage() : "Có lỗi xảy ra khi đăng ký");
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
}
