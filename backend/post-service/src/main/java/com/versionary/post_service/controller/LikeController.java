package com.versionary.post_service.controller;

import com.versionary.post_service.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/posts/{postId}/likes")
//@RequestMapping(produces = "application/json;charset=UTF-8")
public class LikeController {

    private final LikeService service;

    @Autowired
    public LikeController(LikeService likeService) {this.service = likeService;}

    @PostMapping
    public ResponseEntity<Void> likeAndDislike(@PathVariable Long postId,  @AuthenticationPrincipal Jwt jwt) {
        service.toggleLike(postId,jwt);
        return ResponseEntity.ok().build();
    }

}
