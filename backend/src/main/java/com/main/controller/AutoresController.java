package com.main.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.main.dto.AutoresResponseDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/v1/autores")
@RequiredArgsConstructor
public class AutoresController {

    private final com.main.services.AutoresServices autoresServices;

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public List<AutoresResponseDto> findAll() {
        return autoresServices.findAll();
    }
}
