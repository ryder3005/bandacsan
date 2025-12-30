package vn.edu.hcmute.springboot3_4_12.service.impl;


import lombok.RequiredArgsConstructor;
import vn.edu.hcmute.springboot3_4_12.dto.VendorRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.VendorResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.mapper.VendorMapper;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VendorService {
    private final VendorRepository vendorRepository;
    private final VendorMapper vendorMapper;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public List<VendorResponseDTO> findAll() {
        return vendorRepository.findAllWithUser().stream()
                .map(vendorMapper::toResponseDTO)
                .toList();
    }

    public VendorResponseDTO findById(Long id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));
        VendorResponseDTO vendorResponseDTO=vendorMapper.toResponseDTO(vendor);
        User user= vendor.getUser();
        assert user != null;
        vendorResponseDTO.setUsername(user.getUsername());
        vendorResponseDTO.setUserEmail(user.getEmail());
        return vendorMapper.toResponseDTO(vendor);
    }

    public VendorResponseDTO create(VendorRequestDTO dto) {
        User user = userRepository.findById(dto.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Kiểm tra xem user đã có vendor chưa
        if (vendorRepository.existsByUserId(user.getId())) {
            throw new RuntimeException("User này đã có shop. Mỗi user chỉ có thể có một shop.");
        }

        Vendor vendor = vendorMapper.toEntity(dto);
        vendor.setUser(user); // Gán User đầy đủ (có cả username, email) vào vendor

        // Tự động cập nhật role của user thành VENDOR (nếu chưa phải VENDOR)
        if (!"VENDOR".equals(user.getRole()) && !"ADMIN".equals(user.getRole())) {
            user.setRole("VENDOR");
            userRepository.save(user);
        }

        Vendor savedVendor = vendorRepository.save(vendor);
        return vendorMapper.toResponseDTO(savedVendor);
    }

    public VendorResponseDTO update(Long id, VendorRequestDTO dto) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendorMapper.updateEntityFromDto(dto, vendor);
        return vendorMapper.toResponseDTO(vendorRepository.save(vendor));
    }

    @Transactional
    public void delete(Long id) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        User user = vendor.getUser();

        // Xóa tất cả VendorRevenue của vendor trước (để tránh foreign key constraint)
        entityManager.createQuery("DELETE FROM VendorRevenue vr WHERE vr.vendor.id = :vendorId")
                .setParameter("vendorId", id)
                .executeUpdate();

        // Xóa tất cả sản phẩm của vendor trước (để tránh foreign key constraint)
        var products = productRepository.findByVendor_Id(id);
        if (products != null && !products.isEmpty()) {
            productRepository.deleteAll(products);
        }

        // Xóa vendor
        vendorRepository.deleteById(id);

        // Nếu user không phải ADMIN, đổi role về CUSTOMER
        if (user != null && !"ADMIN".equals(user.getRole())) {
            user.setRole("CUSTOMER");
            userRepository.save(user);
        }
    }
}
