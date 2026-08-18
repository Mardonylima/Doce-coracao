package com.main.services;

import com.main.database.model.ConteudosEntity;
import com.main.dto.ConteudosResponseDto;
import com.main.repository.ConteudosRepository;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ConteudosServices {

    private final ConteudosRepository conteudosRepository;

    public List<ConteudosResponseDto> findAll() {
        return conteudosRepository.findAll()
            .stream()
            .map(this::toDto)
            .toList();
    }

    private ConteudosResponseDto toDto(ConteudosEntity conteudosEntity) {
        return ConteudosResponseDto.builder()
            .id(conteudosEntity.getId())
            .tipo(conteudosEntity.getTipo())
            .classificacao(conteudosEntity.getClassificacao())
            .titulo(conteudosEntity.getTitulo())
            .conteudo(conteudosEntity.getConteudo())
            .referencia(conteudosEntity.getReferencia())
            .fonte(conteudosEntity.getFonte())
            .slug(conteudosEntity.getSlug())
            .temaId(conteudosEntity.getTema().getId())
            .autorId(
                conteudosEntity.getAutor() != null
                ? conteudosEntity.getAutor().getId()
                : null
            )
            .nivel(conteudosEntity.getNivel())
            .ordem(conteudosEntity.getOrdem())
            .status(conteudosEntity.getStatus())
            .tempoLiturgico(conteudosEntity.getTempoLiturgico())
            .build();
    }

    public ConteudosResponseDto findRandomTemaSlug(String temaSlug) {
        Optional<ConteudosEntity> conteudosEntity = conteudosRepository.findRandomTemaSlug(temaSlug);
        return toDto(conteudosEntity.orElse(null));
    }

    public List<ConteudosResponseDto> findRandomContentByTema() {
        return conteudosRepository
            .findRandomContentByTema()
            .stream()
            .map(this::toDto)
            .toList();
    }

}
