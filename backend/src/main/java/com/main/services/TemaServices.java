package com.main.services;

import com.main.database.model.TemaEntity;
import com.main.repository.TemaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TemaServices {

    private final TemaRepository temaRepository;

    public List<TemaEntity> findAll() {
        return temaRepository.findAll();
    }

}
