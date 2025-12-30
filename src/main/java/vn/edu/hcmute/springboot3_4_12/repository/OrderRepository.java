package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.edu.hcmute.springboot3_4_12.entity.Order;
import vn.edu.hcmute.springboot3_4_12.entity.OrderStatus;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser_IdOrderByIdDesc(Long userId);
    List<Order> findByStatus(OrderStatus status);
    List<Order> findByUser_IdAndStatus(Long userId, OrderStatus status);
}
