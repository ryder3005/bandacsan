package vn.edu.hcmute.springboot3_4_12.controller.admin;

import vn.edu.hcmute.springboot3_4_12.entity.Post;
import vn.edu.hcmute.springboot3_4_12.service.IpostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PostController {
    @Autowired
    IpostService postService;
    @GetMapping("/admin/post/create")
    public String createPostForm(Model model) {
        model.addAttribute("post", new Post());
        return "admin/product-form";
    }

    @PostMapping("/admin/post/save")
    public String savePost(@ModelAttribute Post post) {
        postService.save(post);
        return "redirect:/admin/post/" + post.getId();
    }

    @GetMapping("/admin/post/{id}")
    public String viewPost(@PathVariable Long id, Model model) {
        model.addAttribute("post", postService.findById(id).get());
        return "admin/view-post";
    }

}
