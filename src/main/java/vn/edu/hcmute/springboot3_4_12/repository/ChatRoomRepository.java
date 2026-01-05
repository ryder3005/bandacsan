package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.edu.hcmute.springboot3_4_12.entity.ChatRoom;

import java.util.List;
import java.util.Optional;

public interface ChatRoomRepository extends JpaRepository<ChatRoom, Long> {
    Optional<ChatRoom> findByCustomer_IdAndVendor_Id(Long customerId, Long vendorId);

    List<ChatRoom> findByCustomer_Id(Long customerId);

    List<ChatRoom> findByVendor_Id(Long vendorId);
}
