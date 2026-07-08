package com.main.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.main.dto.TemaResponseDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/v1/temas")
@RequiredArgsConstructor
public class TemaController {
    
    private final com.main.services.TemaServices temaServices;
    
    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<TemaResponseDto> findAll() {
        return temaServices.findAll();
    }

}