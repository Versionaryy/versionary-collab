package com.versionary.post_service.service;

import com.versionary.post_service.model.Comment;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.repository.CommentRepository;
import com.versionary.post_service.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.jwt.Jwt;
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
    public Comment createComment(Long postId, Comment comment, Jwt jwt) {
        long userId = Long.parseLong(jwt.getSubject());

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Publicação não encontrada com id: " + postId));


        comment.setPost(post);
        comment.setUserId(userId);

        return commentRepository.save(comment);
    }


    @Transactional
    public void delete(Long id, Jwt jwt) {
        long userId = Long.parseLong(jwt.getSubject());

        Comment comment = commentRepository.findById(id).orElseThrow(() -> new RuntimeException("Comentário não encontrado"));
        if (comment.getUserId() != userId) {
            throw new SecurityException("Você não tem permissão para deletar este post.");
        }
        commentRepository.deleteById(id);
    }
    @Transactional
    public void update(Long id, Comment comment, Jwt jwt) {
        long userId = Long.parseLong(jwt.getSubject());

        Comment prevComment = commentRepository.findById(id).orElseThrow(() -> new RuntimeException("Comentário não encontrado"));
        if (prevComment.getUserId() != userId) {
            throw new SecurityException("Você não tem permissão para deletar este post.");
        }
        prevComment.setContent(comment.getContent());
        prevComment.setUpdatedAt(LocalDateTime.now());
        commentRepository.save(prevComment);
    }
    @Transactional(readOnly = true)
    public Set<Comment> getCommentsForPost(Long postId) {
        return commentRepository.findByPostId(postId);
    }
}
