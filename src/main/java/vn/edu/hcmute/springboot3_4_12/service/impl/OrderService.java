package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.*;
import vn.edu.hcmute.springboot3_4_12.entity.*;
import vn.edu.hcmute.springboot3_4_12.repository.*;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class OrderService implements IOrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final PaymentRepository paymentRepository;
    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final UserRepository userRepository;
    private final ICartService cartService;
    private final VendorRepository vendorRepository;
    private final VendorRevenueRepository vendorRevenueRepository;

    @Override
    public OrderDTO createOrder(Long userId, CheckoutRequestDTO request) {
        // Get user's cart
        CartDTO cart = cartService.getCartByUserId(userId);
        if (cart.getItems().isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        // Create order
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setTotalAmount(cart.getTotalPrice());
        order.setStatus(OrderStatus.PENDING);
        order = orderRepository.save(order);

        // Create order items
        for (CartItemDTO cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);

            // Get product from repository to ensure it's managed
            Product product = cartItemRepository.findById(cartItem.getId())
                    .map(CartItem::getProduct)
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            orderItem.setProduct(product);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(product.getPrice());

            orderItemRepository.save(orderItem);
        }

        // Create payment
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setMethod(request.getPaymentMethod() != null ? request.getPaymentMethod() : "COD");
        payment.setStatus("PENDING");
        paymentRepository.save(payment);

        // Clear cart
        cartService.clearCart(userId);

        return convertToDTO(order);
    }

    @Override
    public List<OrderDTO> getUserOrders(Long userId) {
        return orderRepository.findByUser_IdOrderByIdDesc(userId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public OrderDTO getOrderById(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Check if order belongs to user (or user is admin)
        if (!order.getUser().getId().equals(userId)) {
            // TODO: Add admin check
            throw new RuntimeException("Access denied");
        }

        return convertToDTO(order);
    }

    @Override
    public OrderDTO updateOrderStatus(Long orderId, OrderStatus status) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setStatus(status);
        order = orderRepository.save(order);

        return convertToDTO(order);
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return orderRepository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getOrdersByStatus(OrderStatus status) {
        return orderRepository.findByStatus(status)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public Order findOrderById(Long l) {
        return orderRepository.findOrderById(l);
    }

    @Override
    @Transactional
    public void updateStatus(long orderId, String status) {
        // 1. Tìm thông tin thanh toán dựa trên orderId
        Payment payment = paymentRepository.findByOrder_Id(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin thanh toán cho đơn hàng: " + orderId));

        // 2. Cập nhật trạng thái thanh toán (ví dụ: "PAID", "FAILED")
        payment.setStatus(status);
        paymentRepository.save(payment);

        // 3. Cập nhật trạng thái đơn hàng tương ứng
        Order order = payment.getOrder();
        if ("PAID".equalsIgnoreCase(status)) {
            order.setStatus(OrderStatus.PROCESSING); // Hoặc trạng thái bạn quy định sau khi thanh toán
            // Có thể thêm logic trừ kho sản phẩm ở đây nếu cần
        } else if ("FAILED".equalsIgnoreCase(status)) {
            order.setStatus(OrderStatus.CANCELLED);
        }

        orderRepository.save(order);
    }

    @Override
    public OrderDTO getOrderByIdForVendor(Long orderId, Long vendorId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Check if order contains vendor's products
        boolean hasVendorProducts = order.getItems().stream()
                .anyMatch(item -> item.getProduct() != null &&
                        item.getProduct().getVendor() != null &&
                        item.getProduct().getVendor().getId().equals(vendorId));

        if (!hasVendorProducts) {
            throw new RuntimeException("Order does not contain vendor's products");
        }

        return convertToDTO(order);
    }

    private OrderDTO convertToDTO(Order order) {
        List<OrderItemDTO> itemDTOs = orderItemRepository.findByOrder_Id(order.getId())
                .stream()
                .map(this::convertItemToDTO)
                .collect(Collectors.toList());

        PaymentDTO paymentDTO = paymentRepository.findByOrder_Id(order.getId())
                .map(this::convertPaymentToDTO)
                .orElse(null);

        return new OrderDTO(
                order.getId(),
                order.getUser().getId(),
                order.getUser().getUsername(),
                order.getTotalAmount(),
                order.getStatus(),
                order.getOrderDate(),
                itemDTOs,
                paymentDTO
        );
    }

    private OrderItemDTO convertItemToDTO(OrderItem item) {
        // 1. Tính toán subtotal
        Double subtotal = item.getPrice() * item.getQuantity();

        // 2. Tìm hình ảnh chính (main = true) từ danh sách images của Product
        String mainImage = item.getProduct().getImages().stream()
                .filter(Image::isMain) // Lọc những ảnh có main = true
                .map(Image::getUrl)    // Lấy ra chuỗi URL (tên file)
                .findFirst()           // Lấy ảnh đầu tiên tìm thấy
                .orElse(null);         // Nếu không có ảnh main nào thì trả về null

        // 3. Trả về DTO hoàn chỉnh
        return new OrderItemDTO(
                item.getId(),
                item.getProduct().getId(),
                item.getProduct().getNameVi(),
                item.getProduct().getNameEn(),
                mainImage,              // Gán ảnh chính vào productImage
                item.getQuantity(),
                item.getPrice(),
                subtotal
        );
    }

    private PaymentDTO convertPaymentToDTO(Payment payment) {
        return new PaymentDTO(
                payment.getId(),
                payment.getOrder().getId(),
                payment.getMethod(),
                payment.getStatus(),
                payment.getTransactionId()
        );
    }

    @Override
    @Transactional
    public OrderDTO confirmOrderByVendor(Long orderId, Long vendorId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Kiểm tra order có items của vendor này không
        boolean hasVendorItems = order.getItems().stream()
                .anyMatch(item -> item.getProduct() != null &&
                        item.getProduct().getVendor() != null &&
                        item.getProduct().getVendor().getId().equals(vendorId));

        if (!hasVendorItems) {
            throw new RuntimeException("Order không chứa sản phẩm của vendor này");
        }

        // Chỉ chuyển từ PENDING sang SHIPPING
        if (order.getStatus() != OrderStatus.PENDING) {
            throw new RuntimeException("Chỉ có thể xác nhận đơn hàng ở trạng thái PENDING");
        }

        order.setStatus(OrderStatus.SHIPPING);
        order = orderRepository.save(order);

        return convertToDTO(order);
    }

    @Override
    @Transactional
    public OrderDTO confirmDeliveredByUser(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Kiểm tra order thuộc về user này
        if (!order.getUser().getId().equals(userId)) {
            throw new RuntimeException("Không có quyền xác nhận đơn hàng này");
        }

        // Chỉ chuyển từ SHIPPING sang DELIVERED
        if (order.getStatus() != OrderStatus.SHIPPING) {
            throw new RuntimeException("Chỉ có thể xác nhận đã nhận đơn hàng ở trạng thái SHIPPING");
        }

        order.setStatus(OrderStatus.DELIVERED);
        order = orderRepository.save(order);

        // Tính và cập nhật revenue cho các vendors trong order này
        updateVendorRevenue(order);

        return convertToDTO(order);
    }

    @Override
    @Transactional
    public OrderDTO cancelOrderByUser(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Check if order belongs to user
        if (!order.getUser().getId().equals(userId)) {
            throw new RuntimeException("Bạn không có quyền hủy đơn hàng này");
        }

        // Chỉ cho phép hủy nếu đơn hàng đang ở trạng thái PENDING
        if (order.getStatus() != OrderStatus.PENDING) {
            throw new RuntimeException("Chỉ có thể hủy đơn hàng khi đơn hàng đang ở trạng thái Chờ xử lý");
        }

        // Cập nhật trạng thái đơn hàng thành CANCELLED
        order.setStatus(OrderStatus.CANCELLED);
        order = orderRepository.save(order);

        return convertToDTO(order);
    }

    private void updateVendorRevenue(Order order) {
        // Tính tổng tiền của order (không phải từ items riêng lẻ)
        Double orderTotalAmount = order.getTotalAmount();
        if (orderTotalAmount == null) {
            orderTotalAmount = 0.0;
        }

        // Group items by vendor để xác định vendor nào có trong order này
        Map<Vendor, Double> vendorItemsAmounts = order.getItems().stream()
                .filter(item -> item.getProduct() != null && item.getProduct().getVendor() != null)
                .collect(Collectors.groupingBy(
                        item -> item.getProduct().getVendor(),
                        Collectors.summingDouble(item -> item.getPrice() * item.getQuantity())
                ));

        // Nếu order chỉ có items của 1 vendor, thì vendor đó nhận toàn bộ order totalAmount
        // Nếu order có items của nhiều vendors, mỗi vendor nhận phần tương ứng với items của họ
        if (vendorItemsAmounts.size() == 1) {
            // Chỉ có 1 vendor - nhận toàn bộ order totalAmount
            Vendor vendor = vendorItemsAmounts.keySet().iterator().next();
            updateVendorRevenueAmount(vendor.getId(), orderTotalAmount);
        } else {
            // Có nhiều vendors - tính tỷ lệ và phân bổ theo tỷ lệ items
            Double totalItemsAmount = vendorItemsAmounts.values().stream()
                    .mapToDouble(Double::doubleValue)
                    .sum();
            
            if (totalItemsAmount > 0) {
                for (Map.Entry<Vendor, Double> entry : vendorItemsAmounts.entrySet()) {
                    Vendor vendor = entry.getKey();
                    Double itemsAmount = entry.getValue();
                    // Tính phần doanh thu của vendor này dựa trên tỷ lệ
                    Double vendorRevenueAmount = (itemsAmount / totalItemsAmount) * orderTotalAmount;
                    updateVendorRevenueAmount(vendor.getId(), vendorRevenueAmount);
                }
            }
        }
    }

    private void updateVendorRevenueAmount(Long vendorId, Double amount) {
        VendorRevenue revenue = vendorRevenueRepository.findByVendor_Id(vendorId);
        
        if (revenue == null) {
            // Tạo mới
            revenue = new VendorRevenue();
            revenue.setVendor(vendorRepository.findById(vendorId).orElseThrow());
            revenue.setAmount(amount);
            revenue.setCreatedAt(LocalDateTime.now());
        } else {
            // Cập nhật
            revenue.setAmount((revenue.getAmount() != null ? revenue.getAmount() : 0.0) + amount);
        }

        vendorRevenueRepository.save(revenue);
    }
}
