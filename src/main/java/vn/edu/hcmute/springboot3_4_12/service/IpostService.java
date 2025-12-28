package vn.edu.hcmute.springboot3_4_12.service;

import vn.edu.hcmute.springboot3_4_12.entity.Post;

import java.util.List;
import java.util.Set;
import java.util.Optional;

public interface IpostService {
    List<Post> findAll();

    void deleteById(Long aLong);

    Optional<Post> findById(Long aLong);

    <S extends Post> S save(S entity);
}
