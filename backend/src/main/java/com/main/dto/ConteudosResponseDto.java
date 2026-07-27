package com.main.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@ToString
@Builder
public class ConteudosResponseDto {

    private String tipo;
    private String subtipo;
    private String tema;
    private String tema_slug;
    private String conteudo;
    private String nivel;
}
