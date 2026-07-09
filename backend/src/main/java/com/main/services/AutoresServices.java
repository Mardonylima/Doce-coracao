package com.main.services;

import com.main.database.model.AutoresEntity;
import com.main.dto.AutoresResponseDto;
import com.main.repository.AutoresRepository;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AutoresServices {

    private final AutoresRepository AutoresRepository;

    public List<AutoresResponseDto> findAll() {
        return AutoresRepository.findAll()
            .stream()
            .map(this::toDto)
            .toList();
    }

    private AutoresResponseDto toDto(AutoresEntity autoresEntity) {
        return AutoresResponseDto.builder()
            .nome(autoresEntity.getNome())
            .slug(autoresEntity.getSlug())
            .tipo(autoresEntity.getTipo())
            .build();
    }
}
