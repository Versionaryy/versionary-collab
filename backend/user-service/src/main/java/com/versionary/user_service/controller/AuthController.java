package com.versionary.user_service.controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.versionary.user_service.dto.LoginRequestDto;
import com.versionary.user_service.dto.LoginResponseDto;
import com.versionary.user_service.model.User;
import com.versionary.user_service.repository.UserRepository;
import com.versionary.user_service.service.TokenService;
import com.versionary.user_service.service.UserService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
public class AuthController {
    private static Logger logger = LoggerFactory.getLogger(AuthController.class);
    private final AuthenticationManager authenticationManager;
    private final TokenService tokenService;
    private final UserRepository userRepository;

    public AuthController(UserRepository userRepository, AuthenticationManager authenticationManager, TokenService tokenService, UserService userService) {
        this.authenticationManager = authenticationManager;
        this.tokenService = tokenService;
        this.userRepository = userRepository;

    }

    @PostMapping("/login")
    public LoginResponseDto login(@RequestBody LoginRequestDto loginRequest) {
            authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.email(),
                        loginRequest.password()
                )
        );
        User user = userRepository.findByEmail(loginRequest.email()).orElseThrow(() -> new IllegalStateException("Usuário não encontrado"));

        String token = tokenService.generateToken(user);


        return new LoginResponseDto(token);
    }


    }
