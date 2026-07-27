package com.main.services;

import com.main.database.model.ConteudosEntity;
import com.main.dto.ConteudosResponseDto;
import com.main.repository.ConteudosRepository;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ConteudosServices {

    private final ConteudosRepository ConteudosRepository;

    public List<ConteudosResponseDto> findAll() {
        return ConteudosRepository.findAll()
            .stream()
            .map(this::toDto)
            .toList();
    }

    private ConteudosResponseDto toDto(ConteudosEntity conteudosEntity) {
        return ConteudosResponseDto.builder()
            .tipo(conteudosEntity.getTipo())
            .subtipo(conteudosEntity.getSubtipo())
            .tema(conteudosEntity.getTema())
            .tema_slug(conteudosEntity.getTemaRelacionamento().getSlug())
            .conteudo(conteudosEntity.getConteudo())
            .nivel(conteudosEntity.getNivel())
            .build();
    }

    public ConteudosResponseDto findRandomCotidiano() {
        ConteudosEntity conteudosEntity = ConteudosRepository.findRandomCotidiano();
        return toDto(conteudosEntity);
    }
}
