package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.CartDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CartRequestDTO;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;

@Controller
@RequestMapping("/vendor/cart")
@RequiredArgsConstructor
public class VendorCartController {

    private final ICartService cartService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            CartDTO cart = cartService.getCartByUserId(user.getId());
            model.addAttribute("cart", cart);
            return "vendor/cart";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải giỏ hàng: " + e.getMessage());
            return "vendor/cart";
        }
    }

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addToCart(@RequestBody CartRequestDTO request,
                                       HttpSession session) {
        User user = (User) session.getAttribute("user");

        if (user == null || !"VENDOR".equals(user.getRole())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập bằng tài khoản Vendor");
        }

        try {
            cartService.addToCart(user.getId(), request);
            return ResponseEntity.ok("Đã thêm vào giỏ hàng!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/update")
    public String updateCartItem(@RequestParam Long itemId,
                                @RequestParam Integer quantity,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            cartService.updateCartItem(user.getId(), itemId, quantity);
            redirectAttributes.addFlashAttribute("success", "Đã cập nhật giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể cập nhật: " + e.getMessage());
        }

        return "redirect:/vendor/cart";
    }

    @PostMapping("/remove")
    public String removeCartItem(@RequestParam Long itemId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            cartService.removeCartItem(user.getId(), itemId);
            redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa sản phẩm: " + e.getMessage());
        }

        return "redirect:/vendor/cart";
    }

    @PostMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            cartService.clearCart(user.getId());
            redirectAttributes.addFlashAttribute("success", "Đã xóa toàn bộ giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa giỏ hàng: " + e.getMessage());
        }

        return "redirect:/vendor/cart";
    }
}

