package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.edu.hcmute.springboot3_4_12.entity.ChatMessage;

import java.util.List;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    List<ChatMessage> findByRoom_IdOrderByTimestampAsc(Long roomId);
    List<ChatMessage> findByRoom_IdAndSender_IdNotOrderByTimestampDesc(Long roomId, Long senderId);
}
