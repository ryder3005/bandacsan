package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.edu.hcmute.springboot3_4_12.dto.OrderDTO;
import vn.edu.hcmute.springboot3_4_12.dto.OrderItemDTO;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;

@Controller
@RequestMapping("/user/orders")
@RequiredArgsConstructor
public class OrderController {

    private final IOrderService orderService;

    @GetMapping
    public String orderHistory(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            List<OrderDTO> orders = orderService.getUserOrders(user.getId());
            model.addAttribute("orders", orders);
            return "user/orders";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải lịch sử đơn hàng: " + e.getMessage());
            return "user/orders";
        }
    }

    @GetMapping("/{orderId}")
    public String orderDetail(@PathVariable Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            OrderDTO order = orderService.getOrderById(orderId, user.getId());
            model.addAttribute("order", order);
            return "user/order-detail";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải chi tiết đơn hàng: " + e.getMessage());
            return "redirect:/user/orders";
        }
    }

    @GetMapping("/{orderId}/products")
    @ResponseBody
    public List<OrderItemDTO> getOrderProducts(@PathVariable Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            throw new RuntimeException("User not authenticated");
        }

        OrderDTO order = orderService.getOrderById(orderId, user.getId());
        return order.getItems();
    }
}
