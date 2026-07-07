package com.main.services;

import com.main.database.model.TemaEntity;
import com.main.dto.TemaDto;
import com.main.repository.TemaRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TemaServices {

    private final TemaRepository temaRepository;

    public List<TemaDto> findAll() {
        return temaRepository.findAll()
            .stream()
            .map(this::toDto)
            .toList();
    }

    private TemaDto toDto(TemaEntity temaEntity) {
        return TemaDto.builder()
            .nome(temaEntity.getNome())
            .slug(temaEntity.getSlug())
            .descricao(temaEntity.getDescricao())
            .build();
    }

}
