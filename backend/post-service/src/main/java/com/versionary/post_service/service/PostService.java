package com.versionary.post_service.service;

import com.versionary.post_service.controller.PostController;
import com.versionary.post_service.dto.PostCreatedDto;
import com.versionary.post_service.dto.PostFeedDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.oauth2.jwt.Jwt;
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
    private static Logger logger = LoggerFactory.getLogger(PostService.class);

    @Transactional
    public Post save(PostCreatedDto postDto, Jwt jwt) {

        long userId = Long.parseLong(jwt.getSubject());
//        logger.info("USER ID FROM TOKEN " + userId);
        Post post = new Post();
        post.setTitulo(postDto.titulo());
        post.setDescricao(postDto.descricao());
        post.setUsuarioId(userId);
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
    public void delete(Long id, Jwt jwt) {
        long userId = Long.parseLong(jwt.getSubject());

        Post post = repository.findById(id).orElseThrow(() -> new RuntimeException("Post não encontrado"));
        if (post.getUsuarioId() != userId) {
            throw new SecurityException("Você não tem permissão para deletar este post.");
        }
        repository.deleteById(id);
    }

    @Transactional
    public void update(Long id, Post newPost, Jwt jwt) {
        long userId = Long.parseLong(jwt.getSubject());

        Post prevPost = repository.findById(id).orElseThrow(() -> new RuntimeException("Post não encontrado"));
        if (prevPost.getUsuarioId() != userId) {
            throw new SecurityException("Você não tem permissão para editar este post.");
        }
        prevPost.setTitulo(newPost.getTitulo());
        prevPost.setDescricao(newPost.getDescricao());
        prevPost.setAtualizado_em(LocalDateTime.now());
        prevPost.setCategoria(newPost.getCategoria());
        repository.save(prevPost);
    }
}
