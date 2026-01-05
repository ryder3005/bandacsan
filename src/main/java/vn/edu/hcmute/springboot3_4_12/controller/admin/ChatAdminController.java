package vn.edu.hcmute.springboot3_4_12.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import vn.edu.hcmute.springboot3_4_12.repository.ChatMessageRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ChatRoomRepository;

@RestController
@RequestMapping("/admin/chat")
@RequiredArgsConstructor
public class ChatAdminController {

    private final ChatMessageRepository chatMessageRepository;
    private final ChatRoomRepository chatRoomRepository;

    @DeleteMapping("/clear-all")
    public String clearAllChats() {
        chatMessageRepository.deleteAll();
        chatRoomRepository.deleteAll();
        return "All chat history cleared successfully";
    }
}
