package com.versionary.post_service.controller;

import com.versionary.post_service.model.Comment;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.service.CommentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/posts/{postId}/comments")

public class CommentController {
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PostMapping
    public ResponseEntity<Comment> createComment(@PathVariable Long postId, @Valid @RequestBody Comment comment, @AuthenticationPrincipal Jwt jwt) {
        Comment createdComment = commentService.createComment(postId, comment, jwt);
        return new ResponseEntity<>(createdComment, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<Set<Comment>> getComments(@PathVariable Long postId) {
        Set<Comment> comments = commentService.getCommentsForPost(postId);
        return ResponseEntity.ok(comments);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateComment(@Valid @RequestBody Comment newComment, @PathVariable Long id, @AuthenticationPrincipal Jwt jwt) {
        commentService.update(id, newComment, jwt);
        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteComment(@PathVariable Long id, @AuthenticationPrincipal Jwt jwt) {
        commentService.delete(id, jwt);
        return ResponseEntity.noContent().build();
    }

}
