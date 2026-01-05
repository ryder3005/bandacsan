package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.ChatMessageDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ChatRoomDTO;
import vn.edu.hcmute.springboot3_4_12.entity.ChatMessage;
import vn.edu.hcmute.springboot3_4_12.entity.ChatRoom;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.repository.ChatMessageRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ChatRoomRepository;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IChatService;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class ChatService implements IChatService {

        private final ChatRoomRepository chatRoomRepository;
        private final ChatMessageRepository chatMessageRepository;
        private final UserRepository userRepository;
        private final VendorRepository vendorRepository;

        @Override
        public ChatRoomDTO getOrCreateChatRoom(Long customerId, Long vendorId) {
                Optional<ChatRoom> existingRoom = chatRoomRepository.findByCustomer_IdAndVendor_Id(customerId,
                                vendorId);

                if (existingRoom.isPresent()) {
                        return convertToDTO(existingRoom.get(), customerId);
                }

                // Create new room
                User customer = userRepository.findById(customerId)
                                .orElseThrow(() -> new RuntimeException("Customer not found"));

                Vendor vendor = vendorRepository.findById(vendorId)
                                .orElseThrow(() -> new RuntimeException("Vendor not found"));

                ChatRoom room = new ChatRoom();
                room.setCustomer(customer);
                room.setVendor(vendor);

                room = chatRoomRepository.save(room);
                return convertToDTO(room, customerId);
        }

        @Override
        public List<ChatRoomDTO> getUserChatRooms(Long userId) {
                User user = userRepository.findById(userId)
                                .orElseThrow(() -> new RuntimeException("User not found"));

                List<ChatRoom> rooms;

                if ("VENDOR".equals(user.getRole())) {
                        // Vendor sees rooms with all customers
                        Vendor vendor = vendorRepository.findVendorByUser_Id(userId)
                                        .orElseThrow(() -> new RuntimeException("Vendor not found"));
                        rooms = chatRoomRepository.findByVendor_Id(vendor.getId());
                } else {
                        // Customer sees rooms with vendors
                        rooms = chatRoomRepository.findByCustomer_Id(userId);
                }

                return rooms.stream()
                                .map(room -> convertToDTO(room, userId))
                                .collect(Collectors.toList());
        }

        @Override
        public ChatMessageDTO sendMessage(Long roomId, Long senderId, String message) {
                ChatRoom room = chatRoomRepository.findById(roomId)
                                .orElseThrow(() -> new RuntimeException("Chat room not found"));

                User sender = userRepository.findById(senderId)
                                .orElseThrow(() -> new RuntimeException("Sender not found"));

                // Validate sender is part of the room
                Long customerId = room.getCustomer() != null ? room.getCustomer().getId() : null;
                Long vendorUserId = (room.getVendor() != null && room.getVendor().getUser() != null)
                                ? room.getVendor().getUser().getId()
                                : null;

                boolean isValidSender = (customerId != null && customerId.equals(senderId)) ||
                                (vendorUserId != null && vendorUserId.equals(senderId));

                if (!isValidSender) {
                        throw new RuntimeException("User is not part of this chat room");
                }

                ChatMessage chatMessage = new ChatMessage();
                chatMessage.setRoom(room);
                chatMessage.setSender(sender);
                chatMessage.setMessage(message);
                chatMessage.setTimestamp(LocalDateTime.now());

                chatMessage = chatMessageRepository.save(chatMessage);

                return convertMessageToDTO(chatMessage, senderId);
        }

        @Override
        public List<ChatMessageDTO> getRoomMessages(Long roomId, Long userId) {
                ChatRoom room = chatRoomRepository.findById(roomId)
                                .orElseThrow(() -> new RuntimeException("Chat room not found"));

                // Validate user is part of the room
                // Validate user is part of the room
                Long customerId = room.getCustomer() != null ? room.getCustomer().getId() : null;
                Long vendorUserId = (room.getVendor() != null && room.getVendor().getUser() != null)
                                ? room.getVendor().getUser().getId()
                                : null;

                boolean isValidUser = (customerId != null && customerId.equals(userId)) ||
                                (vendorUserId != null && vendorUserId.equals(userId));

                if (!isValidUser) {
                        throw new RuntimeException("User is not part of this chat room");
                }

                List<ChatMessage> messages = chatMessageRepository.findByRoom_IdOrderByTimestampAsc(roomId);

                return messages.stream()
                                .map(message -> convertMessageToDTO(message, userId))
                                .collect(Collectors.toList());
        }

        @Override
        public ChatRoomDTO getChatRoomInfo(Long roomId, Long userId) {
                ChatRoom room = chatRoomRepository.findById(roomId)
                                .orElseThrow(() -> new RuntimeException("Chat room not found"));

                // Validate user is part of the room
                Long customerId = room.getCustomer() != null ? room.getCustomer().getId() : null;
                Long vendorUserId = (room.getVendor() != null && room.getVendor().getUser() != null)
                                ? room.getVendor().getUser().getId()
                                : null;

                boolean isValidUser = (customerId != null && customerId.equals(userId)) ||
                                (vendorUserId != null && vendorUserId.equals(userId));

                if (!isValidUser) {
                        throw new RuntimeException("User is not part of this chat room");
                }

                return convertToDTO(room, userId);
        }

        @Override
        public int getUnreadCount(Long userId) {
                User user = userRepository.findById(userId)
                                .orElseThrow(() -> new RuntimeException("User not found"));

                List<ChatRoom> rooms;
                if ("VENDOR".equals(user.getRole())) {
                        Vendor vendor = vendorRepository.findVendorByUser_Id(userId)
                                        .orElseThrow(() -> new RuntimeException("Vendor not found"));
                        rooms = chatRoomRepository.findByVendor_Id(vendor.getId());
                } else {
                        rooms = chatRoomRepository.findByCustomer_Id(userId);
                }

                return rooms.stream()
                                .mapToInt(room -> chatMessageRepository
                                                .findByRoom_IdAndSender_IdNotOrderByTimestampDesc(
                                                                room.getId(), userId)
                                                .size())
                                .sum();
        }

        @Override
        public void markAsRead(Long roomId, Long userId) {
                // For simplicity, we'll just mark messages as "read" by not showing unread
                // count
                // In a real app, you'd add a read status to messages
        }

        private ChatRoomDTO convertToDTO(ChatRoom room, Long currentUserId) {
                List<ChatMessage> messages = chatMessageRepository.findByRoom_IdOrderByTimestampAsc(room.getId());
                String lastMessage = messages.isEmpty() ? "" : messages.get(messages.size() - 1).getMessage();

                String lastMessageTime = messages.isEmpty() ? ""
                                : messages.get(messages.size() - 1).getTimestamp()
                                                .format(DateTimeFormatter.ofPattern("HH:mm dd/MM"));

                int unreadCount = chatMessageRepository.findByRoom_IdAndSender_IdNotOrderByTimestampDesc(
                                room.getId(), currentUserId).size();

                List<ChatMessageDTO> messageDTOs = messages.stream()
                                .map(msg -> convertMessageToDTO(msg, currentUserId))
                                .collect(Collectors.toList());

                return new ChatRoomDTO(
                                room.getId(),
                                room.getCustomer().getId(),
                                room.getCustomer().getUsername(),
                                room.getVendor().getId(),
                                room.getVendor().getStoreName(),
                                lastMessage,
                                lastMessageTime,
                                unreadCount,
                                messageDTOs);
        }

        private ChatMessageDTO convertMessageToDTO(ChatMessage message, Long currentUserId) {
                return new ChatMessageDTO(
                                message.getId(),
                                message.getRoom().getId(),
                                message.getSender().getId(),
                                message.getSender().getUsername(),
                                message.getMessage(),
                                message.getTimestamp(),
                                message.getSender().getId().equals(currentUserId));
        }
}
