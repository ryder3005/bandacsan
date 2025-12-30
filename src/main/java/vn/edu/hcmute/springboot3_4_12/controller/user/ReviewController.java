package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.ReviewDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ReviewRequestDTO;
import vn.edu.hcmute.springboot3_4_12.service.IReviewService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;

@Controller
@RequestMapping("/user/reviews")
@RequiredArgsConstructor
public class ReviewController {

    private final IReviewService reviewService;

    @GetMapping
    public String myReviews(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            List<ReviewDTO> reviews = reviewService.getUserReviews(user.getId());
            model.addAttribute("reviews", reviews);
            return "user/reviews";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải đánh giá: " + e.getMessage());
            return "user/reviews";
        }
    }

    @PostMapping("/create")
    public String createReview(@ModelAttribute ReviewRequestDTO request,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            reviewService.createReview(user.getId(), request);
            redirectAttributes.addFlashAttribute("success", "Đánh giá đã được gửi thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể gửi đánh giá: " + e.getMessage());
        }

        return "redirect:/user/products/" + request.getProductId();
    }

    @GetMapping("/product/{productId}")
    @ResponseBody
    public List<ReviewDTO> getProductReviews(@PathVariable Long productId) {
        return reviewService.getProductReviews(productId);
    }

    @GetMapping("/product/{productId}/average")
    @ResponseBody
    public Double getProductAverageRating(@PathVariable Long productId) {
        return reviewService.getAverageRating(productId);
    }

    @GetMapping("/check/{productId}")
    @ResponseBody
    public boolean hasUserReviewedProduct(@PathVariable Long productId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return false;
        }
        return reviewService.hasUserReviewedProduct(user.getId(), productId);
    }
}
