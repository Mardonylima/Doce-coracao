package com.main.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.main.dto.ConteudosResponseDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/v1/conteudos")
@RequiredArgsConstructor
public class ConteudosController {

    private final com.main.services.ConteudosServices conteudosServices;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<ConteudosResponseDto> findAll() {
        return conteudosServices.findAll();
    }

    @GetMapping("/random/cotidiano")
    @ResponseStatus(HttpStatus.OK)
    public ConteudosResponseDto findRandomTemaSlug() {
        return conteudosServices.findRandomTemaSlug("cotidiano");
    }
}
