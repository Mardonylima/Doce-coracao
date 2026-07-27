package com.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.main.database.model.ConteudosEntity;

public interface ConteudosRepository extends JpaRepository<ConteudosEntity, Long> {

    @Query(
        value = """
                SELECT
                c.*,
                t.slug AS tema_slug
                FROM conteudos c
                JOIN temas t
                    ON c.tema_id = t.id
                WHERE t.slug = 'cotidiano'
                ORDER BY RANDOM()
                LIMIT 1
                """,
        nativeQuery = true
    )
    ConteudosEntity findRandomCotidiano();
}
