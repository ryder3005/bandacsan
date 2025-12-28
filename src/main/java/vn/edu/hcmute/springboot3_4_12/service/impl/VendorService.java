package vn.edu.hcmute.springboot3_4_12.service.impl;


import lombok.RequiredArgsConstructor;
import vn.edu.hcmute.springboot3_4_12.dto.VendorRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.VendorResponseDTO;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.mapper.VendorMapper;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;
import vn.edu.hcmute.springboot3_4_12.service.IVendorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class VendorService {
    private final VendorRepository vendorRepository;
    private final VendorMapper vendorMapper;
    private final UserRepository userRepository;// Inject mapper

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

        Vendor vendor = vendorMapper.toEntity(dto);
        vendor.setUser(user); // Gán User đầy đủ (có cả username, email) vào vendor

        Vendor savedVendor = vendorRepository.save(vendor);
        return vendorMapper.toResponseDTO(savedVendor);
    }

    public VendorResponseDTO update(Long id, VendorRequestDTO dto) {
        Vendor vendor = vendorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Vendor not found"));

        vendorMapper.updateEntityFromDto(dto, vendor);
        return vendorMapper.toResponseDTO(vendorRepository.save(vendor));
    }

    public void delete(Long id) {
        if (!vendorRepository.existsById(id)) {
            throw new RuntimeException("Vendor not found");
        }
        vendorRepository.deleteById(id);
    }
}
