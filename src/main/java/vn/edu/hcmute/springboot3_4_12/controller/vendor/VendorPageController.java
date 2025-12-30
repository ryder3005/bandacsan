package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VendorPageController {

    @GetMapping({"/vendor", "/vendor/dashboard"})
    public String dashboard(Model model) {
        try {
            // Trang dashboard của vendor
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

