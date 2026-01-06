package vn.edu.hcmute.springboot3_4_12.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import vn.edu.hcmute.springboot3_4_12.dto.LoginRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.UserRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.UserResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;

import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.service.EmailService;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;
    @Override
    @Transactional
    public UserResponseDTO register(UserRequestDTO dto) {
        // 1. Kiểm tra username đã tồn tại chưa
        if (userRepository.existsByUsername(dto.getUsername())) {
            throw new RuntimeException("Username đã tồn tại!");
        }
        if (userRepository.existsUserByEmailContainingIgnoreCase(dto.getEmail())) {
            throw new RuntimeException("Email này đã được sử dụng!");
        }
        // 2. Map DTO sang Entity & Mã hóa mật khẩu
        User user = new User();
        user.setUsername(dto.getUsername());
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword())); // MÃ HÓA TẠI ĐÂY
        user.setRole(dto.getRole() == null ? "CUSTOMER" : dto.getRole());

        // 3. Lưu và trả về DTO
        User savedUser = userRepository.save(user);
        return new UserResponseDTO(savedUser.getId(), savedUser.getUsername(), savedUser.getEmail(), savedUser.getRole());
    }

    @Override
    public UserResponseDTO findByUsername(String username) {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new RuntimeException("User không tồn tại"));
        return new UserResponseDTO(user.getId(), user.getUsername(), user.getEmail(), user.getRole());
    }

    @Override
    public UserResponseDTO findById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User không tồn tại với ID: " + id));
        return new UserResponseDTO(user.getId(), user.getUsername(), user.getEmail(), user.getRole());
    }

    @Override
    public List<UserResponseDTO> getAllUsers() {
        return userRepository.findAll().stream()
                .map(u -> new UserResponseDTO(u.getId(), u.getUsername(), u.getEmail(), u.getRole()))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public UserResponseDTO update(Long id, UserRequestDTO dto) {
        // 1. Kiểm tra User có tồn tại không
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User không tồn tại với ID: " + id));

        // 2. Cập nhật thông tin (Chỉ cập nhật nếu field đó có dữ liệu)
        if (dto.getEmail() != null) user.setEmail(dto.getEmail());
        if (dto.getRole() != null) user.setRole(dto.getRole());

        // Nếu có đổi mật khẩu thì phải mã hóa lại
        // Kiểm tra nếu password là "_unchanged_" thì không cập nhật
        if (dto.getPassword() != null && !dto.getPassword().isEmpty() && !dto.getPassword().equals("_unchanged_")) {
            user.setPassword(passwordEncoder.encode(dto.getPassword()));
        }

        // 3. Lưu và trả về
        User updatedUser = userRepository.save(user);
        return new UserResponseDTO(updatedUser.getId(), updatedUser.getUsername(), updatedUser.getEmail(), updatedUser.getRole());
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        if(!userRepository.existsById(id)) throw new RuntimeException("User không tồn tại");
        userRepository.deleteById(id);
    }

    @Override
    @Transactional
    public void forgotPassword(String email) {
        // 1. Tìm user theo email
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Email không tồn tại trong hệ thống"));

        // 2. Tạo reset token
        String resetToken = UUID.randomUUID().toString();
        LocalDateTime expiryTime = LocalDateTime.now().plusHours(1); // Token hết hạn sau 1 giờ

        // 3. Lưu token vào database
        user.setResetToken(resetToken);
        user.setResetTokenExpiry(expiryTime);
        userRepository.save(user);

        // 4. Gửi email chứa link reset password
        emailService.sendPasswordResetEmail(user.getEmail(), resetToken);
    }

    @Override
    @Transactional
    public void resetPassword(String token, String newPassword) {
        // 1. Tìm user theo reset token
        User user = userRepository.findByResetToken(token)
                .orElseThrow(() -> new RuntimeException("Token không hợp lệ hoặc đã hết hạn"));

        // 2. Kiểm tra token còn hạn không
        if (user.getResetTokenExpiry() == null || user.getResetTokenExpiry().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Token đã hết hạn. Vui lòng yêu cầu đặt lại mật khẩu mới");
        }

        // 3. Cập nhật mật khẩu mới
        user.setPassword(passwordEncoder.encode(newPassword));
        
        // 4. Xóa reset token sau khi đã sử dụng
        user.setResetToken(null);
        user.setResetTokenExpiry(null);
        
        userRepository.save(user);
    }

//    @Override
//    public UserResponseDTO login(LoginRequestDTO dto) {
//        // 1. Tìm user theo username
//        User user = userRepository.findUserByUsername(dto.getUsername())
//                .orElseThrow(() -> new RuntimeException("Tên đăng nhập hoặc mật khẩu không đúng!"));
//
//        // 2. Kiểm tra mật khẩu
//        // matches(mật_khẩu_thô, mật_khẩu_đã_mã_hóa_trong_db)
//        if (!passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
//            throw new RuntimeException("Tên đăng nhập hoặc mật khẩu không đúng!");
//        }
//
//        // 3. Trả về thông tin User (không bao gồm password)
//        return new UserResponseDTO(
//                user.getId(),
//                user.getUsername(),
//                user.getEmail(),
//                user.getRole()
//        );
//    }
}