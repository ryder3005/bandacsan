package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.HttpServletRequest;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.dto.ProductRequestDTO;

@Controller
@RequestMapping("/vendor")
@RequiredArgsConstructor
public class VendorContentController {

    private final IProductService productService;
    private final ICategoryService categoryService;
    private final VendorService vendorService;
    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final vn.edu.hcmute.springboot3_4_12.repository.OrderRepository orderRepository;

    @GetMapping("/products")
    public String products(Model model, HttpSession session) {
        // Lấy user từ session
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Tìm vendor theo user
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (vendorOpt.isPresent()) {
                // Chỉ lấy sản phẩm của vendor này
                var vendor = vendorOpt.get();
                var products = productService.getAll().stream()
                        .filter(p -> p.getVendorId() != null && p.getVendorId().equals(vendor.getId()))
                        .collect(java.util.stream.Collectors.toList());
                model.addAttribute("products", products);
            } else {
                // Không tìm thấy vendor, trả về danh sách rỗng
                model.addAttribute("products", new java.util.ArrayList<>());
            }
        } else {
            // Không có user trong session, trả về danh sách rỗng
            model.addAttribute("products", new java.util.ArrayList<>());
        }
        return "vendor/product/list";
    }

    @GetMapping("/categories")
    public String categories(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "vendor/category/list";
    }

    @GetMapping("/orders")
    public String orders(Model model, HttpSession session) {
        // Get user from session
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Find vendor by user
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (vendorOpt.isPresent()) {
                var vendor = vendorOpt.get();

                // Get all orders that contain products from this vendor
                var allOrders = orderRepository.findAll();
                var vendorOrders = allOrders.stream()
                        .filter(order -> order.getItems() != null && order.getItems().stream()
                                .anyMatch(item -> item.getProduct() != null &&
                                        item.getProduct().getVendor() != null &&
                                        item.getProduct().getVendor().getId().equals(vendor.getId())))
                        .collect(java.util.stream.Collectors.toList());

                model.addAttribute("orders", vendorOrders);
            } else {
                model.addAttribute("orders", new java.util.ArrayList<>());
            }
        } else {
            model.addAttribute("orders", new java.util.ArrayList<>());
        }
        return "vendor/orders";
    }

    @GetMapping("/shop")
    public String shop(Model model, HttpSession session) {
        // Lấy user từ session
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Tìm vendor theo user
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (vendorOpt.isPresent()) {
                var vendor = vendorOpt.get();
                // Convert sang DTO để hiển thị
                var vendorDTO = vendorService.findById(vendor.getId());
                model.addAttribute("vendor", vendorDTO);
            }
        }
        return "vendor/shop";
    }

    @GetMapping("/revenue")
    public String revenue(Model model) {
        return "vendor/revenue";
    }

    @GetMapping("/products/create")
    public String createProductPage(Model model, HttpSession session) {
        // Lấy user từ session để lấy vendor info
        User user = (User) session.getAttribute("user");
        if (user != null) {
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (vendorOpt.isPresent()) {
                var vendor = vendorOpt.get();
                model.addAttribute("vendorId", vendor.getId());
                model.addAttribute("vendorName", vendor.getStoreName());
            }
        }
        model.addAttribute("categories", categoryService.getAll());
        return "vendor/product/form";
    }

    @GetMapping("/products/edit/{id}")
    @Transactional
    public String editProductPage(@PathVariable Long id, Model model, HttpSession session) {
        try {
            // Kiểm tra quyền sở hữu sản phẩm
            User user = (User) session.getAttribute("user");
            if (user != null) {
                var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
                if (vendorOpt.isPresent()) {
                    var vendor = vendorOpt.get();
                    var productDTO = productService.findById(id);

                    // Kiểm tra sản phẩm có thuộc về vendor này không
                    if (!vendor.getId().equals(productDTO.getVendorId())) {
                        model.addAttribute("error", "Bạn không có quyền chỉnh sửa sản phẩm này");
                        return "redirect:/vendor/products";
                    }

                    model.addAttribute("product", productDTO);
                    model.addAttribute("vendorId", vendor.getId());
                    model.addAttribute("vendorName", vendor.getStoreName());

                    // Lấy category IDs từ product entity
                    var productEntity = productRepository.findById(id);
                    if (productEntity.isPresent()) {
                        var categories = productEntity.get().getCategories();
                        if (categories != null) {
                            var categoryIds = categories.stream()
                                    .map(cat -> cat.getId())
                                    .filter(catId -> catId != null)
                                    .collect(java.util.stream.Collectors.toList());
                            model.addAttribute("selectedCategoryIds", categoryIds);
                        } else {
                            model.addAttribute("selectedCategoryIds", new java.util.ArrayList<>());
                        }
                    } else {
                        model.addAttribute("selectedCategoryIds", new java.util.ArrayList<>());
                    }

                    model.addAttribute("categories", categoryService.getAll());
                    return "vendor/product/form";
                }
            }
            model.addAttribute("error", "Không tìm thấy thông tin vendor");
            return "redirect:/vendor/products";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Không tìm thấy sản phẩm: " + e.getMessage());
            return "redirect:/vendor/products";
        }
    }

    @PostMapping("/products/create")
    public String createProduct(HttpServletRequest request, HttpSession session, Model model) {
        try {
            // Kiểm tra quyền vendor
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                model.addAttribute("error", "Bạn không có quyền tạo sản phẩm");
                return "redirect:/vendor/products";
            }

            var vendor = vendorOpt.get();

            // Thu thập dữ liệu từ form
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String[] categoryIds = request.getParameterValues("categoryIds");

            // Validation cơ bản
            if (nameVi == null || nameVi.trim().isEmpty()) {
                model.addAttribute("error", "Tên sản phẩm tiếng Việt không được để trống");
                model.addAttribute("categories", categoryService.getAll());
                model.addAttribute("vendorId", vendor.getId());
                model.addAttribute("vendorName", vendor.getStoreName());
                return "vendor/product/form";
            }

            ProductRequestDTO dto = new ProductRequestDTO();
            dto.setNameVi(nameVi.trim());
            dto.setNameEn(nameEn != null ? nameEn.trim() : null);
            dto.setDescriptionVi(descriptionVi != null ? descriptionVi.trim() : null);
            dto.setDescriptionEn(descriptionEn != null ? descriptionEn.trim() : null);
            dto.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0.0);
            dto.setStock(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);
            dto.setVendorId(vendor.getId());

            // Xử lý categories
            if (categoryIds != null && categoryIds.length > 0) {
                dto.setCategoryIds(java.util.Arrays.stream(categoryIds)
                        .map(Long::parseLong)
                        .collect(java.util.stream.Collectors.toList()));
            }

            // Tạo sản phẩm (không có file upload trong form đơn giản này)
            productService.create(dto, null);

            return "redirect:/vendor/products?success=Sản phẩm đã được tạo thành công";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tạo sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAll());
            return "vendor/product/form";
        }
    }

    @PostMapping("/products/save")
    public String saveProduct(HttpServletRequest request, HttpSession session, Model model) {
        try {
            // Kiểm tra quyền vendor
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                return "redirect:/vendor/products?error=Bạn không có quyền tạo/chỉnh sửa sản phẩm";
            }

            var vendor = vendorOpt.get();

            String idStr = request.getParameter("id");
            String nameVi = request.getParameter("nameVi");
            String nameEn = request.getParameter("nameEn");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock");
            String[] categoryIds = request.getParameterValues("categoryIds");

            // Validation cơ bản
            if (nameVi == null || nameVi.trim().isEmpty()) {
                String redirectUrl = (idStr != null && !idStr.trim().isEmpty())
                        ? "/vendor/products/edit/" + idStr + "?error=Tên sản phẩm tiếng Việt không được để trống"
                        : "/vendor/products/create?error=Tên sản phẩm tiếng Việt không được để trống";
                return "redirect:" + redirectUrl;
            }

            ProductRequestDTO dto = new ProductRequestDTO();
            dto.setNameVi(nameVi.trim());
            dto.setNameEn(nameEn != null ? nameEn.trim() : null);
            dto.setDescriptionVi(descriptionVi != null ? descriptionVi.trim() : null);
            dto.setDescriptionEn(descriptionEn != null ? descriptionEn.trim() : null);
            dto.setPrice(priceStr != null && !priceStr.isEmpty() ? Double.parseDouble(priceStr) : 0.0);
            dto.setStock(stockStr != null && !stockStr.isEmpty() ? Integer.parseInt(stockStr) : 0);
            dto.setVendorId(vendor.getId());

            // Xử lý categories
            if (categoryIds != null && categoryIds.length > 0) {
                dto.setCategoryIds(java.util.Arrays.stream(categoryIds)
                        .map(Long::parseLong)
                        .collect(java.util.stream.Collectors.toList()));
            }

            if (idStr != null && !idStr.trim().isEmpty()) {
                // Update existing product
                Long id = Long.parseLong(idStr);
                var existingProduct = productService.findById(id);

                // Kiểm tra quyền sở hữu
                if (!vendor.getId().equals(existingProduct.getVendorId())) {
                    return "redirect:/vendor/products?error=Bạn không có quyền chỉnh sửa sản phẩm này";
                }

                productService.update(id, dto);
                return "redirect:/vendor/products/edit/" + id + "?success=Sản phẩm đã được cập nhật thành công";
            } else {
                // Create new product
                productService.create(dto, null);
                return "redirect:/vendor/products?success=Sản phẩm đã được tạo thành công";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/products?error=Có lỗi xảy ra: " + e.getMessage();
        }
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, HttpSession session) {
        try {
            // Kiểm tra quyền vendor
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                return "redirect:/vendor/products?error=Bạn không có quyền xóa sản phẩm";
            }

            var vendor = vendorOpt.get();

            // Kiểm tra sản phẩm có thuộc về vendor này không
            var productDTO = productService.findById(id);
            if (!vendor.getId().equals(productDTO.getVendorId())) {
                return "redirect:/vendor/products?error=Bạn không có quyền xóa sản phẩm này";
            }

            productService.delete(id);
            return "redirect:/vendor/products?success=Sản phẩm đã được xóa thành công";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/products?error=Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage();
        }
    }

    @GetMapping("/shop/update")
    public String shopUpdatePage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (vendorOpt.isPresent()) {
                var vendor = vendorOpt.get();
                var vendorDTO = vendorService.findById(vendor.getId());
                model.addAttribute("vendor", vendorDTO);
                return "vendor/shop-update";
            }
        }
        return "redirect:/vendor/shop";
    }

    @PostMapping("/shop/update")
    public String updateShop(HttpServletRequest request, HttpSession session, Model model) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                return "redirect:/vendor/shop?error=Shop not found";
            }
            var vendor = vendorOpt.get();

            String storeName = request.getParameter("storeName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String descriptionVi = request.getParameter("descriptionVi");
            String descriptionEn = request.getParameter("descriptionEn");

            vn.edu.hcmute.springboot3_4_12.dto.VendorRequestDTO dto = new vn.edu.hcmute.springboot3_4_12.dto.VendorRequestDTO();
            dto.setStoreName(storeName);
            dto.setPhone(phone);
            dto.setAddress(address);
            dto.setDescriptionVi(descriptionVi);
            dto.setDescriptionEn(descriptionEn);
            dto.setUserId(user.getId());

            vendorService.update(vendor.getId(), dto);

            return "redirect:/vendor/shop?success=Cập nhật thông tin shop thành công";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/shop/update?error=" + e.getMessage();
        }
    }
}
