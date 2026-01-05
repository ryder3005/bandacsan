package vn.edu.hcmute.springboot3_4_12.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FaviconController {

    @GetMapping("favicon.ico")
    @ResponseBody
    public void returnNoFavicon() {
        // Returns empty response to prevent 404/500 errors for favicon
    }
}
