package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRevenueRepository;
import vn.edu.hcmute.springboot3_4_12.entity.OrderStatus;
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
    private final IOrderService orderService;
    private final VendorRevenueRepository vendorRevenueRepository;

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
                var vendorOrdersEntities = allOrders.stream()
                        .filter(order -> order.getItems() != null && order.getItems().stream()
                                .anyMatch(item -> item.getProduct() != null &&
                                        item.getProduct().getVendor() != null &&
                                        item.getProduct().getVendor().getId().equals(vendor.getId())))
                        .collect(java.util.stream.Collectors.toList());

                // Convert to DTOs
                var vendorOrders = vendorOrdersEntities.stream()
                        .map(order -> orderService.getOrderByIdForVendor(order.getId(), vendor.getId()))
                        .collect(java.util.stream.Collectors.toList());

                // Calculate statistics
                long totalOrders = vendorOrders.size();
                long deliveredCount = vendorOrders.stream()
                        .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                        .count();
                long pendingCount = vendorOrders.stream()
                        .filter(order -> order.getStatus() == OrderStatus.PENDING)
                        .count();
                
                // Calculate total revenue từ tổng tiền các đơn hàng đã giao
                // Nếu order có items của vendor này, thì tính toàn bộ totalAmount của order
                double totalRevenue = vendorOrdersEntities.stream()
                        .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                        .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                        .sum();

                model.addAttribute("orders", vendorOrders);
                model.addAttribute("totalOrders", totalOrders);
                model.addAttribute("deliveredCount", deliveredCount);
                model.addAttribute("pendingCount", pendingCount);
                model.addAttribute("totalRevenue", totalRevenue);
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
    public String revenue(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
        if (!vendorOpt.isPresent()) {
            return "redirect:/vendor/dashboard";
        }

        var vendor = vendorOpt.get();

        // Get all vendor orders (DELIVERED)
        var allOrders = orderRepository.findAll();
        var vendorOrdersEntities = allOrders.stream()
                .filter(order -> order.getItems() != null && order.getItems().stream()
                        .anyMatch(item -> item.getProduct() != null &&
                                item.getProduct().getVendor() != null &&
                                item.getProduct().getVendor().getId().equals(vendor.getId())))
                .filter(order -> order.getStatus() == OrderStatus.DELIVERED)
                .collect(java.util.stream.Collectors.toList());

        // Calculate total revenue từ tổng tiền các đơn hàng đã giao
        // Nếu order có items của vendor này, thì tính toàn bộ totalAmount của order
        double totalRevenue = vendorOrdersEntities.stream()
                .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                .sum();

        // Get vendor revenue for createdAt date
        var vendorRevenue = vendorRevenueRepository.findByVendor_Id(vendor.getId());
        String revenueCreatedAtStr = null;
        if (vendorRevenue != null && vendorRevenue.getCreatedAt() != null) {
            revenueCreatedAtStr = vendorRevenue.getCreatedAt().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }

        // Calculate monthly revenue
        java.time.YearMonth currentMonth = java.time.YearMonth.now();
        java.time.LocalDateTime startOfMonth = currentMonth.atDay(1).atStartOfDay();
        java.time.LocalDateTime endOfMonth = currentMonth.atEndOfMonth().atTime(23, 59, 59);

        double monthlyRevenue = vendorOrdersEntities.stream()
                .filter(order -> order.getOrderDate() != null &&
                        (order.getOrderDate().isEqual(startOfMonth) || order.getOrderDate().isAfter(startOfMonth)) &&
                        (order.getOrderDate().isEqual(endOfMonth) || order.getOrderDate().isBefore(endOfMonth)))
                .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                .sum();

        // Calculate weekly revenue
        java.time.LocalDateTime startOfWeek = java.time.LocalDateTime.now()
                .with(java.time.DayOfWeek.MONDAY)
                .withHour(0).withMinute(0).withSecond(0);
        java.time.LocalDateTime endOfWeek = startOfWeek.plusDays(6).withHour(23).withMinute(59).withSecond(59);

        double weeklyRevenue = vendorOrdersEntities.stream()
                .filter(order -> order.getOrderDate() != null &&
                        (order.getOrderDate().isEqual(startOfWeek) || order.getOrderDate().isAfter(startOfWeek)) &&
                        (order.getOrderDate().isEqual(endOfWeek) || order.getOrderDate().isBefore(endOfWeek)))
                .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                .sum();

        long totalDeliveredOrders = vendorOrdersEntities.size();

        // Tính doanh thu theo từng tháng (12 tháng gần nhất) cho biểu đồ
        java.util.Map<String, Double> monthlyRevenueData = new java.util.LinkedHashMap<>();
        for (int i = 11; i >= 0; i--) {
            java.time.YearMonth month = java.time.YearMonth.now().minusMonths(i);
            java.time.LocalDateTime monthStart = month.atDay(1).atStartOfDay();
            java.time.LocalDateTime monthEnd = month.atEndOfMonth().atTime(23, 59, 59);
            
            double monthRevenue = vendorOrdersEntities.stream()
                    .filter(order -> order.getOrderDate() != null &&
                            (order.getOrderDate().isEqual(monthStart) || order.getOrderDate().isAfter(monthStart)) &&
                            (order.getOrderDate().isEqual(monthEnd) || order.getOrderDate().isBefore(monthEnd)))
                    .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                    .sum();
            
            monthlyRevenueData.put(month.format(java.time.format.DateTimeFormatter.ofPattern("MM/yyyy")), monthRevenue);
        }

        // Tính doanh thu theo từng tuần (8 tuần gần nhất) cho biểu đồ
        java.util.Map<String, Double> weeklyRevenueData = new java.util.LinkedHashMap<>();
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        for (int i = 7; i >= 0; i--) {
            java.time.LocalDateTime weekStart = now.minusWeeks(i)
                    .with(java.time.DayOfWeek.MONDAY)
                    .withHour(0).withMinute(0).withSecond(0).withNano(0);
            java.time.LocalDateTime weekEnd = weekStart.plusDays(6).withHour(23).withMinute(59).withSecond(59).withNano(999000000);
            
            double weekRevenue = vendorOrdersEntities.stream()
                    .filter(order -> order.getOrderDate() != null &&
                            (order.getOrderDate().isEqual(weekStart) || order.getOrderDate().isAfter(weekStart)) &&
                            (order.getOrderDate().isEqual(weekEnd) || order.getOrderDate().isBefore(weekEnd)))
                    .mapToDouble(order -> order.getTotalAmount() != null ? order.getTotalAmount() : 0.0)
                    .sum();
            
            String weekLabel = "Tuần " + (8 - i) + " (" + 
                    weekStart.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")) + " - " +
                    weekEnd.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")) + ")";
            weeklyRevenueData.put(weekLabel, weekRevenue);
        }
        
        // Chuyển đổi Map sang JSON string để truyền vào JSP
        String monthlyRevenueDataJson = "{}";
        String weeklyRevenueDataJson = "{}";
        try {
            com.fasterxml.jackson.databind.ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();
            monthlyRevenueDataJson = objectMapper.writeValueAsString(monthlyRevenueData);
            weeklyRevenueDataJson = objectMapper.writeValueAsString(weeklyRevenueData);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("monthlyRevenue", monthlyRevenue);
        model.addAttribute("weeklyRevenue", weeklyRevenue);
        model.addAttribute("totalDeliveredOrders", totalDeliveredOrders);
        model.addAttribute("vendorRevenue", vendorRevenue);
        model.addAttribute("revenueCreatedAtStr", revenueCreatedAtStr);
        model.addAttribute("monthlyRevenueData", monthlyRevenueData);
        model.addAttribute("weeklyRevenueData", weeklyRevenueData);
        model.addAttribute("monthlyRevenueDataJson", monthlyRevenueDataJson);
        model.addAttribute("weeklyRevenueDataJson", weeklyRevenueDataJson);

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
    public String createProduct(HttpServletRequest request, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
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

            // Tạo sản phẩm
            productService.create(dto, null);
            redirectAttributes.addFlashAttribute("successMessage", "Tạo sản phẩm thành công!");

            return "redirect:/vendor/products";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tạo sản phẩm: " + e.getMessage());
            model.addAttribute("categories", categoryService.getAll());
            return "vendor/product/form";
        }
    }

    @PostMapping("/products/save")
    public String saveProduct(
            @org.springframework.web.bind.annotation.RequestParam(value = "id", required = false) String idStr,
            @org.springframework.web.bind.annotation.RequestParam("nameVi") String nameVi,
            @org.springframework.web.bind.annotation.RequestParam(value = "nameEn", required = false) String nameEn,
            @org.springframework.web.bind.annotation.RequestParam(value = "descriptionVi", required = false) String descriptionVi,
            @org.springframework.web.bind.annotation.RequestParam(value = "descriptionEn", required = false) String descriptionEn,
            @org.springframework.web.bind.annotation.RequestParam(value = "price", required = false) String priceStr,
            @org.springframework.web.bind.annotation.RequestParam(value = "stock", required = false) String stockStr,
            @org.springframework.web.bind.annotation.RequestParam(value = "categoryIds", required = false) String[] categoryIds,
            @org.springframework.web.bind.annotation.RequestParam(value = "files", required = false) org.springframework.web.multipart.MultipartFile[] files,
            HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra quyền vendor
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền tạo/chỉnh sửa sản phẩm");
                return "redirect:/vendor/products";
            }

            var vendor = vendorOpt.get();

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

            // Xử lý file upload
            java.util.List<org.springframework.web.multipart.MultipartFile> fileList = null;
            if (files != null && files.length > 0) {
                fileList = new java.util.ArrayList<>();
                for (org.springframework.web.multipart.MultipartFile file : files) {
                    if (file != null && !file.isEmpty()) {
                        fileList.add(file);
                    }
                }
                if (fileList.isEmpty()) {
                    fileList = null;
                }
            }

            if (idStr != null && !idStr.trim().isEmpty()) {
                // Update existing product
                Long id = Long.parseLong(idStr);
                var existingProduct = productService.findById(id);

                // Kiểm tra quyền sở hữu
                if (!vendor.getId().equals(existingProduct.getVendorId())) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền chỉnh sửa sản phẩm này");
                    return "redirect:/vendor/products";
                }

                productService.update(id, dto, fileList);
                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
                return "redirect:/vendor/products";
            } else {
                // Create new product
                productService.create(dto, fileList);
                redirectAttributes.addFlashAttribute("successMessage", "Tạo sản phẩm thành công!");
                return "redirect:/vendor/products";
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/vendor/products";
        }
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra quyền vendor
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền xóa sản phẩm");
                return "redirect:/vendor/products";
            }

            var vendor = vendorOpt.get();

            // Kiểm tra sản phẩm có thuộc về vendor này không
            var productDTO = productService.findById(id);
            if (!vendor.getId().equals(productDTO.getVendorId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền xóa sản phẩm này");
                return "redirect:/vendor/products";
            }

            productService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
            return "redirect:/vendor/products";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa sản phẩm: " + e.getMessage());
            return "redirect:/vendor/products";
        }
    }

    @GetMapping("/orders/{orderId}")
    public String orderDetail(@PathVariable Long orderId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                return "redirect:/vendor/orders";
            }

            var vendor = vendorOpt.get();
            var orderOpt = orderRepository.findById(orderId);
            
            if (!orderOpt.isPresent()) {
                return "redirect:/vendor/orders";
            }

            var order = orderOpt.get();
            
            // Check if order contains vendor's products
            boolean hasVendorProducts = order.getItems().stream()
                    .anyMatch(item -> item.getProduct() != null &&
                            item.getProduct().getVendor() != null &&
                            item.getProduct().getVendor().getId().equals(vendor.getId()));

            if (!hasVendorProducts) {
                return "redirect:/vendor/orders";
            }

            // Get order as DTO
            var orderDTO = orderService.getOrderByIdForVendor(orderId, vendor.getId());
            model.addAttribute("order", orderDTO);
            return "vendor/order-detail";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/orders";
        }
    }

    @PostMapping("/orders/{orderId}/confirm")
    public String confirmOrder(@PathVariable Long orderId, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền xác nhận đơn hàng");
                return "redirect:/vendor/orders";
            }

            var vendor = vendorOpt.get();
            orderService.confirmOrderByVendor(orderId, vendor.getId());
            redirectAttributes.addFlashAttribute("successMessage", "Xác nhận đơn hàng thành công! Đơn hàng đang được giao.");
            
            return "redirect:/vendor/orders";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xác nhận đơn hàng: " + e.getMessage());
            return "redirect:/vendor/orders";
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
    public String updateShop(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return "redirect:/login";
            }

            var vendorOpt = vendorRepository.findVendorByUser_Id(user.getId());
            if (!vendorOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy shop");
                return "redirect:/vendor/shop";
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

            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin shop thành công!");
            return "redirect:/vendor/shop";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/vendor/shop";
        }
    }
}
