package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.OrderRepository;
import vn.edu.hcmute.springboot3_4_12.entity.Order;
import vn.edu.hcmute.springboot3_4_12.service.IChatService;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class VendorPageController {

    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final IChatService chatService;

    @GetMapping({ "/vendor", "/vendor/dashboard" })
    public String dashboard(Model model, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
                if (vendorOpt.isPresent()) {
                    var vendor = vendorOpt.get();

                    // Thống kê sản phẩm
                    long totalProducts = productRepository.findByVendor_Id(vendor.getId()).size();

                    // Thống kê đơn hàng - đếm orders có sản phẩm của vendor này
                    List<Order> allOrders = orderRepository.findAll();
                    var vendorOrdersEntities = allOrders.stream()
                            .filter(order -> order.getItems() != null && order.getItems().stream()
                                    .anyMatch(item -> item.getProduct() != null &&
                                            item.getProduct().getVendor() != null &&
                                            item.getProduct().getVendor().getId().equals(vendor.getId())))
                            .collect(java.util.stream.Collectors.toList());
                    
                    long totalOrders = vendorOrdersEntities.size();

                    // Thống kê doanh thu - tính từ tổng tiền các đơn hàng đã giao
                    var deliveredOrders = vendorOrdersEntities.stream()
                            .filter(order -> order.getStatus() == vn.edu.hcmute.springboot3_4_12.entity.OrderStatus.DELIVERED)
                            .collect(java.util.stream.Collectors.toList());
                    
                    double totalRevenue = deliveredOrders.stream()
                            .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                            .sum();

                    // Thống kê doanh thu tháng này (từ orders DELIVERED)
                    YearMonth currentMonth = YearMonth.now();
                    LocalDateTime startOfMonth = currentMonth.atDay(1).atStartOfDay();
                    LocalDateTime endOfMonth = currentMonth.atEndOfMonth().atTime(23, 59, 59);

                    double monthlyRevenue = deliveredOrders.stream()
                            .filter(order -> order.getOrderDate() != null &&
                                    !order.getOrderDate().isBefore(startOfMonth) &&
                                    !order.getOrderDate().isAfter(endOfMonth))
                            .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                            .sum();

                    // Thống kê doanh thu tuần này
                    LocalDateTime startOfWeek = LocalDateTime.now()
                            .with(java.time.DayOfWeek.MONDAY)
                            .withHour(0).withMinute(0).withSecond(0);
                    LocalDateTime endOfWeek = startOfWeek.plusDays(6).withHour(23).withMinute(59).withSecond(59);

                    double weeklyRevenue = deliveredOrders.stream()
                            .filter(order -> order.getOrderDate() != null &&
                                    !order.getOrderDate().isBefore(startOfWeek) &&
                                    !order.getOrderDate().isAfter(endOfWeek))
                            .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                            .sum();

                    // Thống kê tin nhắn chưa đọc
                    long unreadMessages = 0;
                    try {
                        unreadMessages = chatService.getUnreadCount(user.getId());
                    } catch (Exception e) {
                        // Nếu có lỗi, giữ giá trị 0
                    }

                    // Truyền dữ liệu vào model
                    model.addAttribute("totalProducts", totalProducts);
                    model.addAttribute("totalOrders", totalOrders);
                    model.addAttribute("totalRevenue", totalRevenue);
                    model.addAttribute("monthlyRevenue", monthlyRevenue);
                    model.addAttribute("weeklyRevenue", weeklyRevenue);
                    model.addAttribute("unreadMessages", unreadMessages);
                }
            }

            return "vendor/dashboard";
        } catch (Exception e) {
            System.err.println("=== EXCEPTION trong VendorPageController.dashboard() ===");
            System.err.println("Exception: " + e.getClass().getName());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            return "vendor/dashboard";
        }
    }
}
