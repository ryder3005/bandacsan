package vn.edu.hcmute.springboot3_4_12.service.impl;

import vn.edu.hcmute.springboot3_4_12.entity.Post;
import vn.edu.hcmute.springboot3_4_12.repository.PostRepository;
import vn.edu.hcmute.springboot3_4_12.service.IpostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class postService implements IpostService {
    @Autowired
    PostRepository repo;

    @Override
    public List<Post> findAll() {
        return repo.findAll();
    }

    @Override
    public void deleteById(Long aLong) {
        repo.deleteById(aLong);
    }

    @Override
    public Optional<Post> findById(Long aLong) {
        return repo.findById(aLong);
    }

    @Override
    public <S extends Post> S save(S entity) {
        return repo.save(entity);
    }
}
