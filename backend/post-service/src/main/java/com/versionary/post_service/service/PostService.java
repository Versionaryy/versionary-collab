package com.versionary.post_service.service;

import com.versionary.post_service.dto.PostFeedDto;
import org.springframework.transaction.annotation.Transactional;

import com.versionary.post_service.model.Post;
import com.versionary.post_service.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostService {
    private final PostRepository repository;

    @Autowired
    public PostService(PostRepository postRepository) {
        this.repository = postRepository;
    }

    @Transactional
    public Post save(Post post) {
        return repository.save(post);
    }

    @Transactional(readOnly = true)
    public List<PostFeedDto> getFeed() {
        return repository.findAll().stream().map(PostFeedDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public Post getById(Long id) {
        return repository.findById(id).orElseThrow(() -> new RuntimeException("Post não encontrado"));
    }

    @Transactional
    public void delete(Long id) {
        if (!repository.existsById((id))) {
            throw new RuntimeException("Post não encontrado");
        }
        repository.deleteById(id);
    }

    @Transactional
    public void update(Long id, Post newPost) {
        Post prevPost = repository.findById(id).orElseThrow(() -> new RuntimeException("Post não encontrado"));
        prevPost.setTitulo(newPost.getTitulo());
        prevPost.setDescricao(newPost.getDescricao());
        prevPost.setAtualizado_em(LocalDateTime.now());
        repository.save(prevPost);
    }
}
