package com.versionary.post_service.controller;

import com.versionary.post_service.model.Comment;
import com.versionary.post_service.service.CommentService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/posts/{postId}/comments")
//@RequestMapping(produces = "application/json;charset=UTF-8")

public class CommentController {
    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @PostMapping
    public ResponseEntity<Comment> createComment(@PathVariable Long postId, @Valid @RequestBody Comment comment) {
        Comment createdComment = commentService.createComment(postId, comment);
        return new ResponseEntity<>(createdComment, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<Set<Comment>> getComments(@PathVariable Long postId) {
        Set<Comment> comments = commentService.getCommentsForPost(postId);
        return ResponseEntity.ok(comments);
    }

}
