package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
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
@RequestMapping("/user/cart")
@RequiredArgsConstructor
public class CartController {

    private final ICartService cartService;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            CartDTO cart = cartService.getCartByUserId(user.getId());
            model.addAttribute("cart", cart);
            return "user/cart";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải giỏ hàng: " + e.getMessage());
            return "user/cart";
        }
    }

    @PostMapping("/add")
    public String addToCart(@ModelAttribute CartRequestDTO request,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            cartService.addToCart(user.getId(), request);
            redirectAttributes.addFlashAttribute("success", "Đã thêm sản phẩm vào giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể thêm sản phẩm: " + e.getMessage());
        }

        return "redirect:/user/products/" + request.getProductId();
    }

    @PostMapping("/update")
    public String updateCartItem(@RequestParam Long itemId,
                                @RequestParam Integer quantity,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            cartService.updateCartItem(user.getId(), itemId, quantity);
            redirectAttributes.addFlashAttribute("success", "Đã cập nhật giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể cập nhật: " + e.getMessage());
        }

        return "redirect:/user/cart";
    }

    @PostMapping("/remove")
    public String removeCartItem(@RequestParam Long itemId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            cartService.removeCartItem(user.getId(), itemId);
            redirectAttributes.addFlashAttribute("success", "Đã xóa sản phẩm khỏi giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa sản phẩm: " + e.getMessage());
        }

        return "redirect:/user/cart";
    }

    @PostMapping("/clear")
    public String clearCart(HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            cartService.clearCart(user.getId());
            redirectAttributes.addFlashAttribute("success", "Đã xóa toàn bộ giỏ hàng!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa giỏ hàng: " + e.getMessage());
        }

        return "redirect:/user/cart";
    }
}
