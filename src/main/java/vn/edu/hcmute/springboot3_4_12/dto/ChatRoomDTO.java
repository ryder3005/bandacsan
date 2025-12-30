package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoomDTO {
    private Long id;
    private Long customerId;
    private String customerName;
    private Long vendorId;
    private String vendorName;
    private String lastMessage;
    private String lastMessageTime;
    private int unreadCount;
    private List<ChatMessageDTO> messages;
}
