package com.versionary.post_service.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Entity

@Table(name="comentarios")
//@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Comentário não pode ser vazio.")
    @Column(name = "conteudo")
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "publicacao_id", nullable = false)
    @JsonBackReference("post-comentarios")
    private Post post;


    @Column(name = "usuario_id")
    private long userId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "comentario_pai_id", nullable = true)
    @JsonBackReference("comentario-respostas")
    private Comment comentarioPai;


    @OneToMany(mappedBy = "comentarioPai", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference("comentario-respostas")
    private Set<Comment> respostas;

    @CreationTimestamp
    @Column(name = "criado_em", updatable = false, nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now();




    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Post getPost() { return post; }
    public void setPost(Post post) { this.post = post; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public Comment getComentarioPai() { return comentarioPai; }
    public void setComentarioPai(Comment comentarioPai) { this.comentarioPai = comentarioPai; }
    public Set<Comment> getRespostas() { return respostas; }
    public void setRespostas(Set<Comment> respostas) { this.respostas = respostas; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}