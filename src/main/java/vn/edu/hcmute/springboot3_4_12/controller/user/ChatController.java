package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.ChatMessageDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ChatRoomDTO;
import vn.edu.hcmute.springboot3_4_12.service.IChatService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.List;

@Controller
@RequestMapping("/user/chat")
@RequiredArgsConstructor
public class ChatController {

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
            return "user/chat-rooms";
        } catch (Exception e) {
            model.addAttribute("error", "Không thể tải phòng chat: " + e.getMessage());
            return "user/chat-rooms";
        }
    }

    @GetMapping("/room/{roomId}")
    public String chatRoom(@PathVariable Long roomId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            List<ChatMessageDTO> messages = chatService.getRoomMessages(roomId, user.getId());
            model.addAttribute("roomId", roomId);
            model.addAttribute("messages", messages);
            model.addAttribute("currentUserId", user.getId());
            return "user/chat-room";
        } catch (Exception e) {
            return "redirect:/user/chat?error=" + e.getMessage();
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

    @PostMapping("/start/{vendorId}")
    public String startChat(@PathVariable Long vendorId,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            ChatRoomDTO room = chatService.getOrCreateChatRoom(user.getId(), vendorId);
            return "redirect:/user/chat/room/" + room.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Không thể bắt đầu chat: " + e.getMessage());
            return "redirect:/user/products";
        }
    }
}
