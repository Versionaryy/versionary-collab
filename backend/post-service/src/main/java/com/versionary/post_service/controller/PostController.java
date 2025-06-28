package com.versionary.post_service.controller;

import com.versionary.post_service.dto.PostFeedDto;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.service.PostService;
import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<Post> create(@Valid @RequestBody Post post) {
        System.out.println(post);
        return ResponseEntity.status(HttpStatus.CREATED).body(service.save(post));
    }

    @GetMapping
    public ResponseEntity<Iterable<PostFeedDto>> getAll() {
            logger.info("Início GET POSTS");
        Iterable<PostFeedDto> posts = service.getFeed();
            logger.info("POSTS obtidos " + posts);
        return ResponseEntity.ok(posts);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Post> getPost(@PathVariable Long id) {
        Post post =  service.getById(id);
        return ResponseEntity.ok(post);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updatePost(@Valid @RequestBody Post newPost, @PathVariable Long id) {
        service.update(id, newPost);
        return ResponseEntity.noContent().build();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }

}
