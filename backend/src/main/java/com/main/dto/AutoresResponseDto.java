package com.main.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@ToString
@Builder
public class AutoresResponseDto {

    private String nome;
    private String slug;
    private String tipo;
}
