package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.OrderDTO;
import vn.edu.hcmute.springboot3_4_12.dto.OrderItemDTO;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/vendor/my-orders")
@RequiredArgsConstructor
public class VendorOrderController {

    private final IOrderService orderService;

    @GetMapping
    public String orderHistory(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            // Get orders where vendor is the buyer (not seller)
            List<OrderDTO> orders = orderService.getUserOrders(user.getId());
            model.addAttribute("orders", orders);
            return "vendor/my-orders";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải lịch sử đơn hàng: " + e.getMessage());
            return "vendor/my-orders";
        }
    }

    @GetMapping("/{orderId}")
    public String orderDetail(@PathVariable Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            OrderDTO order = orderService.getOrderById(orderId, user.getId());
            model.addAttribute("order", order);
            return "vendor/my-order-detail";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải chi tiết đơn hàng: " + e.getMessage());
            return "redirect:/vendor/my-orders";
        }
    }

    @GetMapping("/{orderId}/products")
    @ResponseBody
    public List<OrderItemDTO> getOrderProducts(@PathVariable Long orderId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            throw new RuntimeException("User not authenticated");
        }

        OrderDTO order = orderService.getOrderById(orderId, user.getId());
        return order.getItems();
    }

    @PostMapping("/{orderId}/confirm-delivered")
    public String confirmDelivered(@PathVariable Long orderId, HttpSession session, 
                                   RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            orderService.confirmDeliveredByUser(orderId, user.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Xác nhận đã nhận hàng thành công!");
            return "redirect:/vendor/my-orders";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xác nhận: " + e.getMessage());
            return "redirect:/vendor/my-orders";
        }
    }

    @PostMapping("/{orderId}/cancel")
    public String cancelOrder(@PathVariable Long orderId, HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return "redirect:/login";
        }

        try {
            orderService.cancelOrderByUser(orderId, user.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Hủy đơn hàng thành công!");
            return "redirect:/vendor/my-orders";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể hủy đơn hàng: " + e.getMessage());
            return "redirect:/vendor/my-orders";
        }
    }

    @GetMapping("/status/summary")
    @ResponseBody
    public Map<String, Object> getOrderStatusSummary(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return Map.of("error", "User not authenticated");
        }

        try {
            List<OrderDTO> orders = orderService.getUserOrders(user.getId());
            
            long pending = orders.stream().filter(o -> o.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.PENDING).count();
            long processing = orders.stream().filter(o -> o.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.PROCESSING).count();
            long shipping = orders.stream().filter(o -> o.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.SHIPPING).count();
            long delivered = orders.stream().filter(o -> o.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.DELIVERED).count();
            long cancelled = orders.stream().filter(o -> o.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.CANCELLED).count();
            
            return Map.of(
                "total", orders.size(),
                "pending", pending,
                "processing", processing,
                "shipping", shipping,
                "delivered", delivered,
                "cancelled", cancelled
            );
        } catch (Exception e) {
            return Map.of("error", e.getMessage());
        }
    }
}

