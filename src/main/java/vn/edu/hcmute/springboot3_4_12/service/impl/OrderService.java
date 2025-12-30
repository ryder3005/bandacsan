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
                null, // TODO: Add createdAt field to Order entity
                itemDTOs,
                paymentDTO
        );
    }

    private OrderItemDTO convertItemToDTO(OrderItem item) {
        return new OrderItemDTO(
                item.getId(),
                item.getProduct().getId(),
                item.getProduct().getNameVi(),
                item.getProduct().getNameEn(),
                item.getQuantity(),
                item.getPrice(),
                item.getPrice() * item.getQuantity()
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
}
