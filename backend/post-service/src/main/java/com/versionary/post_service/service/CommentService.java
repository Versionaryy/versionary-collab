package com.versionary.post_service.service;

import com.versionary.post_service.model.Comment;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.repository.CommentRepository;
import com.versionary.post_service.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final PostRepository postRepository;

    public CommentService(CommentRepository commentRepository, PostRepository postRepository) {
        this.commentRepository = commentRepository;
        this.postRepository = postRepository;
    }

    @Transactional
    public Comment createComment(Long postId, Comment comment) {

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Publicação não encontrada com id: " + postId));


        comment.setPost(post);

        return commentRepository.save(comment);
    }

    @Transactional(readOnly = true)
    public Set<Comment> getCommentsForPost(Long postId) {
        return commentRepository.findByPostId(postId);
    }
}
