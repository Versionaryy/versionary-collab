package com.versionary.post_service.model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "publicacoes")
//@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;


    @Column(name="categoria")
    private Categoria categoria;

    @NotBlank
    @Column(name = "titulo")
    private String titulo;
    @NotBlank
    @Size(message = "A descrição do post deve ser entre 3 a 150 caracteres", min = 3, max = 150)
    @Column(name = "descricao")
    private String descricao;

    @Column(name = "usuario_id", nullable = false)
    private long usuario_id;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @JsonManagedReference("post-comentarios")
    private Set<Comment> comentarios = new HashSet<>();




    @CreationTimestamp
    @Column(updatable = false, nullable = false)
    private LocalDateTime criado_em = LocalDateTime.now();
    @UpdateTimestamp
    @Column(nullable = false)
    private LocalDateTime atualizado_em = LocalDateTime.now();

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public long getUsuarioId() { return usuario_id; }
    public void setUsuarioId(long usuario_id) { this.usuario_id = usuario_id; }
    public Set<Comment> getComentarios() { return comentarios; }
    public void setComentarios(Set<Comment> comentarios) { this.comentarios = comentarios; }
    public LocalDateTime setCriado_em() { return criado_em; }
    public void setCriado_em(LocalDateTime criado_em) { this.criado_em = criado_em; }
    public LocalDateTime getAtualizado_em() { return atualizado_em; }
    public void setAtualizado_em(LocalDateTime atualizado_em) { this.atualizado_em = atualizado_em; }
    public Categoria getCategoria() { return categoria; }
    public void setCategoria(Categoria categoria) { this.categoria = categoria; }
}