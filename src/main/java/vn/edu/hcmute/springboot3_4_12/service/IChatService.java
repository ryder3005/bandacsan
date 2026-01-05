package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.dto.ChatMessageDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ChatRoomDTO;

import java.util.List;

public interface IChatService {
    ChatRoomDTO getOrCreateChatRoom(Long customerId, Long vendorId);

    List<ChatRoomDTO> getUserChatRooms(Long userId);

    ChatMessageDTO sendMessage(Long roomId, Long senderId, String message);

    List<ChatMessageDTO> getRoomMessages(Long roomId, Long userId);

    ChatRoomDTO getChatRoomInfo(Long roomId, Long userId);

    int getUnreadCount(Long userId);

    void markAsRead(Long roomId, Long userId);
}
