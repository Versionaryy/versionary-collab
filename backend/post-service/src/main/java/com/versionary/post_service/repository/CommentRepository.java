package com.versionary.post_service.repository;

import com.versionary.post_service.model.Comment;
import com.versionary.post_service.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    Set<Comment> findByPostId(Long postId);

}
