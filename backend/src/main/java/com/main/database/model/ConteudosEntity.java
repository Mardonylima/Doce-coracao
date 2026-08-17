package com.main.database.model;

import lombok.Data;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Data
@Entity
@Table(name = "conteudos")
public class ConteudosEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String tipo;

    @Column(nullable = false)
    private String classificacao;

    private String titulo;

    @Column(nullable = false)
    private String conteudo;

    private String referencia;

    private String fonte;

    @Column(nullable = false)
    private String slug;

    @ManyToOne
    @JoinColumn(name = "tema_id", nullable = false)
    private TemaEntity tema;

    @ManyToOne
    @JoinColumn(name = "autor_id")
    private AutoresEntity autor;

    private String nivel;

    private Integer ordem;

    private String status;

    @Column(name = "tempo_liturgico")
    private String tempoLiturgico;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
}