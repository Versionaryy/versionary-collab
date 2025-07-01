package com.versionary.user_service.controller;

import com.versionary.user_service.dto.RegisterRequestDto;
import com.versionary.user_service.dto.RegisterResponseDto;
import com.versionary.user_service.model.User;
import com.versionary.user_service.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService service;


    public UserController(UserService UserService) {this.service = UserService;}
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequestDto registerRequest) {

        try {
            User newUser = service.register(registerRequest);

            return new ResponseEntity<>(new RegisterResponseDto(newUser.getNome(), newUser.getUsuario(), newUser.getEmail()), HttpStatus.CREATED);

        } catch (IllegalStateException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.CONFLICT);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> editProfile(@RequestBody RegisterRequestDto editRequestDto) {
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }



}
