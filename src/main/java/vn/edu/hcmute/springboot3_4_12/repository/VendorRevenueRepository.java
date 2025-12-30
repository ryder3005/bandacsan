package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import vn.edu.hcmute.springboot3_4_12.entity.Review;
import vn.edu.hcmute.springboot3_4_12.entity.VendorRevenue;

import java.util.List;

public interface VendorRevenueRepository extends JpaRepository<VendorRevenue, Long> {
    VendorRevenue findByVendor_Id(Long vendorId);

    @Query("SELECT vr FROM VendorRevenue vr WHERE vr.vendor.id = :vendorId")
    VendorRevenue findByVendorId(@Param("vendorId") Long vendorId);

}
