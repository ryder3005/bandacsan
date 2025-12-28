package vn.edu.hcmute.springboot3_4_12.entity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "orders")
public class Order {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne private User user;

    private Double totalAmount;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;
}
