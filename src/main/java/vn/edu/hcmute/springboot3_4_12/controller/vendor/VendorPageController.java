package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class VendorPageController {

    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;

    @GetMapping({"/vendor", "/vendor/dashboard"})
    public String dashboard(Model model, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
                if (vendorOpt.isPresent()) {
                    var vendor = vendorOpt.get();

                    // Thống kê sản phẩm
                    long totalProducts = productRepository.findByVendor_Id(vendor.getId()).size();

                    // Thống kê đơn hàng (tạm thời = 0 vì chưa implement order system)
                    long totalOrders = 0;

                    // Thống kê doanh thu tháng này (tạm thời = 0 vì chưa implement order system)
                    double monthlyRevenue = 0.0;

                    // Thống kê tin nhắn (tạm thời = 0 vì chưa implement chat)
                    long unreadMessages = 0;

                    // Truyền dữ liệu vào model
                    model.addAttribute("totalProducts", totalProducts);
                    model.addAttribute("totalOrders", totalOrders);
                    model.addAttribute("monthlyRevenue", monthlyRevenue);
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

