package vn.edu.hcmute.springboot3_4_12.controller.vendor;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.edu.hcmute.springboot3_4_12.dto.ChatMessageDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ChatRoomDTO;
import vn.edu.hcmute.springboot3_4_12.service.IChatService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;

@Controller
@RequestMapping("/vendor/chat")
@RequiredArgsConstructor
public class VendorChatController {

    private final IChatService chatService;

    @GetMapping
    public String chatRooms(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            List<ChatRoomDTO> rooms = chatService.getUserChatRooms(user.getId());
            model.addAttribute("chatRooms", rooms);
            return "vendor/chat-rooms";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải phòng chat: " + e.getMessage());
            return "vendor/chat-rooms";
        }
    }

    @GetMapping("/room/{roomId}")
    public String chatRoom(@PathVariable Long roomId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            ChatRoomDTO chatRoom = chatService.getChatRoomInfo(roomId, user.getId());
            model.addAttribute("roomId", roomId);
            model.addAttribute("chatRoom", chatRoom); // Pass ChatRoom info for header
            model.addAttribute("messages", chatRoom.getMessages());
            model.addAttribute("currentUserId", user.getId());
            return "vendor/chat-room";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/vendor/chat?error=" + e.getMessage();
        }
    }

    @GetMapping("/room/{roomId}/messages")
    @ResponseBody
    public List<ChatMessageDTO> getRoomMessages(@PathVariable Long roomId, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return List.of();
        }
        try {
            return chatService.getRoomMessages(roomId, user.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    @PostMapping("/send")
    @ResponseBody
    public ChatMessageDTO sendMessage(@RequestParam Long roomId,
                                      @RequestParam String message,
                                      HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            throw new RuntimeException("User not authenticated");
        }

        return chatService.sendMessage(roomId, user.getId(), message);
    }
}