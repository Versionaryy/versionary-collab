package com.versionary.post_service.controller;

import com.versionary.post_service.dto.PostCreatedDto;
import com.versionary.post_service.dto.PostFeedDto;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.service.PostService;
import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/posts")
public class PostController {
    private static Logger logger = LoggerFactory.getLogger(PostController.class);

    private final PostService service;

    @Autowired
    public PostController(PostService postService) {this.service = postService;}

    @PostMapping
    public ResponseEntity<Post> create(@Valid @RequestBody PostCreatedDto post, @AuthenticationPrincipal Jwt jwt) {

//        logger.info("ID usuário = " + post.getUsuarioId());
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(post, jwt));
    }

    @GetMapping
    public ResponseEntity<Iterable<PostFeedDto>> getAll() {

        Iterable<PostFeedDto> posts = service.getFeed();

        return ResponseEntity.ok(posts);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Post> getPost(@PathVariable Long id) {
        Post post =  service.getById(id);
        return ResponseEntity.ok(post);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updatePost(@Valid @RequestBody Post newPost, @PathVariable Long id, @AuthenticationPrincipal Jwt jwt) {
        service.update(id, newPost, jwt);
        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id, @AuthenticationPrincipal Jwt jwt) {
        service.delete(id, jwt);
        return ResponseEntity.noContent().build();
    }

}
