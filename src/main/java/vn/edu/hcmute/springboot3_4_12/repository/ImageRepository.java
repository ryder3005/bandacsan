package vn.edu.hcmute.springboot3_4_12.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.edu.hcmute.springboot3_4_12.entity.Image;

public interface ImageRepository extends JpaRepository<Image, Long> {
}

