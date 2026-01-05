package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.dto.CheckoutRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.OrderDTO;
import vn.edu.hcmute.springboot3_4_12.entity.Order;
import vn.edu.hcmute.springboot3_4_12.entity.OrderStatus;

import java.util.List;

public interface IOrderService {
    OrderDTO createOrder(Long userId, CheckoutRequestDTO request);
    List<OrderDTO> getUserOrders(Long userId);
    OrderDTO getOrderById(Long orderId, Long userId);
    OrderDTO updateOrderStatus(Long orderId, OrderStatus status);
    List<OrderDTO> getAllOrders();
    List<OrderDTO> getOrdersByStatus(OrderStatus status);
    Order findOrderById(Long l );
    void updateStatus(long l, String paid);
    OrderDTO confirmOrderByVendor(Long orderId, Long vendorId);
    OrderDTO confirmDeliveredByUser(Long orderId, Long userId);
    OrderDTO getOrderByIdForVendor(Long orderId, Long vendorId);
    OrderDTO cancelOrderByUser(Long orderId, Long userId);
}
