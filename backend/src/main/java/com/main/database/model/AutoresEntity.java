package com.main.database.model;

import lombok.Data;
import jakarta.persistence.*;

@Data
@Entity
@Table(name = "autores")
public class AutoresEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private String slug;
    private String tipo;
}
