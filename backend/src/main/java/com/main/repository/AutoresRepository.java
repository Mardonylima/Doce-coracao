package com.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.main.database.model.AutoresEntity;

public interface AutoresRepository extends JpaRepository<AutoresEntity, Long> {

    
}
