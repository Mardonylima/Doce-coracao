package com.main.services;

import com.main.database.model.TemaEntity;
import com.main.dto.TemaResponseDto;
import com.main.repository.TemaRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TemaServices {

    private final TemaRepository temaRepository;

    public List<TemaResponseDto> findAll() {
        return temaRepository.findAll()
            .stream()
            .map(this::toDto)
            .toList();
    }

    private TemaResponseDto toDto(TemaEntity temaEntity) {
        return TemaResponseDto.builder()
            .nome(temaEntity.getNome())
            .slug(temaEntity.getSlug())
            .descricao(temaEntity.getDescricao())
            .build();
    }

}
