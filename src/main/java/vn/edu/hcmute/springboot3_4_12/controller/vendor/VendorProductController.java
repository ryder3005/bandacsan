package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/vendor/products")
@RequiredArgsConstructor
public class VendorProductController {

    private final IProductService productService;
    private final VendorRepository vendorRepository;

    /**
     * Trả về danh sách sản phẩm thuộc vendor hiện tại (JSON) để form blog chọn sản phẩm.
     */
    @GetMapping("/search")
    @ResponseBody
    public List<ProductResponseDTO> searchProducts(@RequestParam(value = "limit", required = false) Integer limit,
                                                   @RequestParam(value = "ids", required = false) List<Long> ids,
                                                   HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"VENDOR".equals(user.getRole())) {
            return Collections.emptyList();
        }

        Optional<vn.edu.hcmute.springboot3_4_12.entity.Vendor> vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
        if (vendorOpt.isEmpty()) {
            return Collections.emptyList();
        }

        Long vendorId = vendorOpt.get().getId();

        // Lọc sản phẩm thuộc vendor
        List<ProductResponseDTO> products = productService.getAll().stream()
                .filter(p -> p.getVendorId() != null && p.getVendorId().equals(vendorId))
                .collect(Collectors.toList());

        // Nếu truyền ids, chỉ giữ các id đó
        if (ids != null && !ids.isEmpty()) {
            products = products.stream()
                    .filter(p -> p.getId() != null && ids.contains(p.getId()))
                    .collect(Collectors.toList());
        }

        // Giới hạn kết quả nếu cần
        if (limit != null && limit > 0 && limit < products.size()) {
            return products.subList(0, limit);
        }

        return products;
    }
}
