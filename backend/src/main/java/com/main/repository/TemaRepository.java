package com.main.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.main.database.model.TemaEntity;


public interface TemaRepository extends JpaRepository<TemaEntity, Long> {


}