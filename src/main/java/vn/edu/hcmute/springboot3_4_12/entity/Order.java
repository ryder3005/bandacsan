package vn.edu.hcmute.springboot3_4_12.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;
import vn.edu.hcmute.springboot3_4_12.config.RandomLongGenerator;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(generator = "random-long")
    @GenericGenerator(name = "random-long", type = RandomLongGenerator.class// Dùng 'type' thay vì 'strategy'
    )

    private Long id;
    @ManyToOne
    private User user;

    private Double totalAmount;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private java.util.List<OrderItem> items = new java.util.ArrayList<>();

    private java.time.LocalDateTime orderDate;

    private String shippingAddress;
    private String paymentMethod;
}
