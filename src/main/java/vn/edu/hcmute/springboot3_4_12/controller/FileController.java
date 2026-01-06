package vn.edu.hcmute.springboot3_4_12.controller;

import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.edu.hcmute.springboot3_4_12.service.IStorageService;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/files")
public class FileController {

    private final IStorageService storageService;

    public FileController(IStorageService storageService) {
        this.storageService = storageService;
    }

    @GetMapping("/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        try {
            Resource file = storageService.loadAsResource(filename);
            
            // Xác định content type dựa trên extension
            String contentType = "application/octet-stream";
            String lowerFilename = filename.toLowerCase();
            
            if (lowerFilename.endsWith(".jpg") || lowerFilename.endsWith(".jpeg")) {
                contentType = "image/jpeg";
            } else if (lowerFilename.endsWith(".png")) {
                contentType = "image/png";
            } else if (lowerFilename.endsWith(".gif")) {
                contentType = "image/gif";
            } else if (lowerFilename.endsWith(".webp")) {
                contentType = "image/webp";
            } else if (lowerFilename.endsWith(".svg")) {
                contentType = "image/svg+xml";
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION,
                            "inline; filename=\"" + file.getFilename() + "\"")
                    .contentType(MediaType.parseMediaType(contentType))
                    .body(file);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
    @PostMapping("/upload-image")
    @ResponseBody
    public Map<String, Object> uploadBlogImage(@RequestParam("upload") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        try {
            // Sử dụng storageService bạn đã có để lưu ảnh
            String filename = storageService.getSorageFilename(file, UUID.randomUUID().toString());
            storageService.store(file, filename);

            // URL để CKEditor hiển thị ảnh sau khi upload thành công
            String url = "/files/" + filename;

            response.put("uploaded", true);
            response.put("url", url);
        } catch (Exception e) {
            response.put("uploaded", false);
            response.put("error", Map.of("message", "Không thể tải ảnh lên: " + e.getMessage()));
        }
        return response;
    }
}
