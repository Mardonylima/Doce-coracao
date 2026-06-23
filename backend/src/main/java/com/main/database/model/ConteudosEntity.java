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

    private String tipo;
    private String subtipo;
    private String tema;
    private String conteudo;

    @ManyToOne
    @JoinColumn(name = "tema_id")
    private TemasEntity temaRelacionamento;

    private String nivel;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
