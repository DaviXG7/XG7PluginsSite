package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.sql.Blob;

@AllArgsConstructor
@Getter
@Setter
public class Imagem {
    private Blob image;
    private String titulo;
    private String descricao;
}
