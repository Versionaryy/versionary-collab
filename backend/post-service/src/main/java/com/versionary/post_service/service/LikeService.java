package com.versionary.post_service.service;

import com.versionary.post_service.model.Like;
import com.versionary.post_service.model.Post;
import com.versionary.post_service.repository.LikeRepository;
import com.versionary.post_service.repository.PostRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class LikeService {
    private final LikeRepository likeRepository;
    private final PostRepository postRepository;

    public LikeService(LikeRepository likeRepository, PostRepository postRepository) {
        this.likeRepository = likeRepository;
        this.postRepository = postRepository;
    }

    @Transactional
    public void toggleLike(Long postId, Long userId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("Publicação não encontrada com id: " + postId));

        Optional<Like> existingLike = likeRepository.findByPostAndUserId(post, userId);

        if (existingLike.isPresent()) {
            likeRepository.delete(existingLike.get());
        } else {
            Like newLike = new Like();
            newLike.setPost(post);
            newLike.setUserId(userId);
            likeRepository.save(newLike);
        }
    }
}
