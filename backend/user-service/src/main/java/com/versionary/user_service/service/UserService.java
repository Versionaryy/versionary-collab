package com.versionary.user_service.service;
import com.versionary.user_service.dto.RegisterRequestDto;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.transaction.annotation.Transactional;

import com.versionary.user_service.model.User;
import com.versionary.user_service.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;


import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserService {
    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    @Autowired
    public UserService(UserRepository UserRepository, PasswordEncoder passwordEncoder) {
        this.repository = UserRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public User getByUser(String username) {

         return repository.findByUsuario(username).orElseThrow(() -> new IllegalStateException("Usuário não existe"));
    }

    @Transactional
    public User register(RegisterRequestDto registerRequest) {
        if (repository.findByUsuario(registerRequest.usuario()).isPresent()) {
            throw new IllegalStateException("Nome de usuário já existe.");
        }
        if (repository.findByEmail(registerRequest.email()).isPresent()) {
            throw new IllegalStateException("E-mail já cadastrado");
        }

        User newUser = new User();
        newUser.setNome(registerRequest.nome());
        newUser.setUsuario(registerRequest.usuario());
        newUser.setEmail(registerRequest.email());

        newUser.setSenha(passwordEncoder.encode(registerRequest.senha()));

        return repository.save(newUser);
    }


    @Transactional
    public void update(Long id, RegisterRequestDto newUser, Jwt jwt) {

        long userId = Long.parseLong(jwt.getSubject());

        User prevUser = repository.findByUsuario(newUser.usuario()).orElseThrow(() -> new IllegalStateException("Usuário não encontrado"));
        if(prevUser.getId() != userId) {
            throw new SecurityException("Você não tem permissão para editar este usuário");
        }

        prevUser.setNome(newUser.nome());
        prevUser.setUsuario(newUser.usuario());
        prevUser.setEmail(newUser.email());
        prevUser.setSenha(newUser.senha());
        repository.save(prevUser);
    }
}
