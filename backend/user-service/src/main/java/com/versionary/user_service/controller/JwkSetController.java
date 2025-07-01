package com.versionary.user_service.controller;

import com.nimbusds.jose.jwk.JWKSet;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class JwkSetController {

    private final JWKSet jwkSet;

    public JwkSetController(JWKSet jwkSet) {
        this.jwkSet = jwkSet;
    }

    @GetMapping("/oauth2/jwks")
    public Map<String, Object> keys() {
        return this.jwkSet.toJSONObject();
    }
}
