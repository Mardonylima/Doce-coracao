package com.main.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.database.model.ConteudosEntity;

public interface ConteudosRepository extends JpaRepository<ConteudosEntity, Long> {

    @Query(value = """
            SELECT c.*
            FROM conteudos c
            JOIN temas t
                ON c.tema_id = t.id
            WHERE t.slug = :temaSlug
            AND c.status = 'publicado'
            ORDER BY RANDOM()
            LIMIT 1
            """, 
            nativeQuery = true)
    Optional<ConteudosEntity> findRandomTemaSlug(
            String temaSlug);


    @Query(value = """
            SELECT DISTINCT ON (c.tema_id)
                c.*
            FROM conteudos c
            WHERE c.status = 'publicado'
                AND c.autor_id IS NOT NULL
            ORDER BY c.tema_id, RANDOM();
            """,
            nativeQuery = true)
    List<ConteudosEntity> findRandomContentByTema();

}
