package com.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.main.database.model.ConteudosEntity;

public interface ConteudosRepository extends JpaRepository<ConteudosEntity, Long> {

    
}
