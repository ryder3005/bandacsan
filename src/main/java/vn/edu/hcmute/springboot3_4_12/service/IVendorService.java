package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import jakarta.validation.constraints.NotNull;

import java.util.List;
import java.util.Set;
import java.util.Optional;

public interface IVendorService {
    List<Vendor> findAll();

    <S extends Vendor> S save(S entity);

    Optional<Vendor> findById(Long aLong);

    void deleteById(Long aLong);

    Vendor getById(@NotNull(message = "Vendor không được để trống") Long vendorId);
}
