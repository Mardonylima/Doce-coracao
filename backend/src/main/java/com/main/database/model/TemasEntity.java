package com.main.database.model;


import lombok.Data;
import jakarta.persistence.*;

@Data
@Entity
@Table(name = "temas")
public class TemasEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private String slug;
    private String descricao;
}