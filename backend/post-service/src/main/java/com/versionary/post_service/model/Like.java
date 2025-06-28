package com.versionary.post_service.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "curtidas_publicacoes")
//@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Like {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name="usuario_id", nullable=false)
    private long userId;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "publicacao_id", nullable = false)
    @JsonBackReference("post-curtidas")
    private Post post;

    @Column(updatable = false, nullable = false)
    private LocalDateTime criado_em = LocalDateTime.now();

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public Post getPost() { return post; }
    public void setPost(Post post) { this.post = post; }
    public long getUserId() { return userId; }
    public void setUserId(long usuario_id) { this.userId = usuario_id; }

}