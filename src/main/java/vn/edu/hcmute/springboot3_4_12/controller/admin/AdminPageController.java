package vn.edu.hcmute.springboot3_4_12.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collections;

@Controller
public class AdminPageController {

    @GetMapping({"/admin", "/admin/home"})
    public String dashboard(Model model) {
        try {
            // Provide empty collections to avoid null checks in JSP
            model.addAttribute("users", Collections.emptyList());
            model.addAttribute("categories", Collections.emptyList());
            model.addAttribute("videos", Collections.emptyList());
            return "admin/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, vẫn trả về view với dữ liệu rỗng
            model.addAttribute("users", Collections.emptyList());
            model.addAttribute("categories", Collections.emptyList());
            model.addAttribute("videos", Collections.emptyList());
            return "admin/dashboard";
        }
    }
}
