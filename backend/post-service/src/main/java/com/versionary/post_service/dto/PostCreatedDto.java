package com.versionary.post_service.dto;

import com.versionary.post_service.model.Categoria;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record PostCreatedDto (@NotBlank String titulo, @NotBlank String descricao, @NotNull Categoria categoria){
}
