package com.versionary.post_service.model;

import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

@Getter
public enum Categoria {
    BUG(1, "Bug"),
    DUVIDA(2, "Duvida"),
    RESOLUCAO(3, "Resolucao");

    private final int id;
    private final String value;

    Categoria(int id, String value) {
        this.id = id;
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    public static Categoria fromId(int id) {
        for (Categoria categoria : values()) {
            if (categoria.getId() == id) {
                return categoria;
            }
        }
        throw new IllegalArgumentException("ID de Categoria inválido: " + id);
    }
}