package com.versionary.post_service.model;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class CategoriaBanco implements AttributeConverter<Categoria, Integer> {

    @Override
    public Integer convertToDatabaseColumn(Categoria categoria) {
        if (categoria == null) {
            return null;
        }
        return categoria.getId();
    }

    @Override
    public Categoria convertToEntityAttribute(Integer dbData) {
        if (dbData == null) {
            return null;
        }
        return Categoria.fromId(dbData);
    }
}