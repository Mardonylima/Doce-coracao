package com.main.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class ConteudosResponseDto {

    private Long id;

    private String tipo;
    private String classificacao;

    private String titulo;
    private String conteudo;

    private String referencia;
    private String fonte;
    private String slug;

    private Long temaId;
    private Long autorId;

    private String nivel;
    private Integer ordem;
    private String status;
    private String tempoLiturgico;
}
