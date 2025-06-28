package com.versionary.post_service.repository;

import com.versionary.post_service.model.Like;
import com.versionary.post_service.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {
    Optional<Like> findByPostAndUserId(Post post, long userId);


}
