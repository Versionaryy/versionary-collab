package com.versionary.post_service.dto;
import com.versionary.post_service.model.Categoria;
import com.versionary.post_service.model.Post;
import java.time.LocalDateTime;
import java.util.List;

public record PostFeedDto (
        long id,
        String titulo,
        LocalDateTime atualizado_em,
        long usuarioId,
        String descricao,
        Categoria categoria,
        int totalComentarios

){
    public static PostFeedDto fromEntity(Post post) {
        return new PostFeedDto(post.getId(), post.getTitulo(), post.getAtualizado_em(), post.getUsuarioId(), post.getDescricao(), post.getCategoria(), post.getComentarios() != null ? post.getComentarios().size() : 0);
    }
}
