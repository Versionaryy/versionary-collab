package com.versionary.user_service.service;
import com.versionary.user_service.dto.RegisterRequestDto;
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
}
