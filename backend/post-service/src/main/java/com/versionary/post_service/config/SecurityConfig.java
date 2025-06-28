package com.versionary.post_service.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(HttpMethod.GET, "/posts", "/posts/**").permitAll()
                        .requestMatchers("/swagger-ui/**", "/v3/api-docs/**").permitAll()
                        .requestMatchers(HttpMethod.POST, "/posts", "/posts/**").permitAll()
                        .requestMatchers(HttpMethod.PUT, "/posts", "/posts/**").permitAll()
                        .requestMatchers(HttpMethod.DELETE, "/posts", "/posts/**").permitAll()
                        // .requestMatchers(HttpMethod.POST, "/posts", "/posts/**").hasAuthority("ROLE_USER")
                        // .requestMatchers(HttpMethod.PUT, "/posts", "/posts/**").hasAuthority("ROLE_USER")
                        // .requestMatchers(HttpMethod.DELETE, "/posts", "/posts/**").hasAuthority("ROLE_USER")
                ).oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()));

        return http.build();
    }
}
