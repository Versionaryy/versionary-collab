package com.versionary.post_service.controller;

import com.versionary.post_service.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/posts/{postId}/likes")
//@RequestMapping(produces = "application/json;charset=UTF-8")
public class LikeController {

    private final LikeService service;

    @Autowired
    public LikeController(LikeService likeService) {this.service = likeService;}

    @PostMapping
    public ResponseEntity<Void> likeAndDislike(@PathVariable Long postId, @RequestParam Long userId) {
        service.toggleLike(postId, userId);
        return ResponseEntity.ok().build();
    }

}
