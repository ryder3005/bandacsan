package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.CartDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CheckoutRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.OrderDTO;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;

@Controller
@RequestMapping("/user/checkout")
@RequiredArgsConstructor
public class CheckoutController {

    private final ICartService cartService;
    private final IOrderService orderService;

    @GetMapping
    public String checkoutPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            CartDTO cart = cartService.getCartByUserId(user.getId());
            if (cart.getItems().isEmpty()) {
                return "redirect:/user/cart?error=Giỏ hàng trống";
            }

            model.addAttribute("cart", cart);
            return "user/checkout";
        } catch (Exception e) {
            return "redirect:/user/cart?error=" + e.getMessage();
        }
    }

    @PostMapping
    public String processCheckout(CheckoutRequestDTO request, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            OrderDTO order = orderService.createOrder(user.getId(), request);
            redirectAttributes.addFlashAttribute("success", "Đặt hàng thành công! Mã đơn hàng: #" + order.getId());
            return "redirect:/user/orders";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Đặt hàng thất bại: " + e.getMessage());
            return "redirect:/user/checkout";
        }
    }
}
