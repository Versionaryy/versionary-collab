package com.versionary.user_service.controller;

import com.versionary.user_service.dto.LoginRequestDto;
import com.versionary.user_service.dto.LoginResponseDto;
import com.versionary.user_service.dto.RegisterRequestDto;
import com.versionary.user_service.dto.RegisterResponseDto;
import com.versionary.user_service.model.User;
import com.versionary.user_service.service.TokenService;
import com.versionary.user_service.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {
    private final AuthenticationManager authenticationManager;
    private final TokenService tokenService;
    private final UserService userService;

    public AuthController(AuthenticationManager authenticationManager, TokenService tokenService, UserService userService) {
        this.authenticationManager = authenticationManager;
        this.tokenService = tokenService;
        this.userService = userService;
    }

    @PostMapping("/login")
    public LoginResponseDto login(@RequestBody LoginRequestDto loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.username(),
                        loginRequest.password()
                )
        );
        String token = tokenService.generateToken(authentication);

        return new LoginResponseDto(token);
    }


    }
