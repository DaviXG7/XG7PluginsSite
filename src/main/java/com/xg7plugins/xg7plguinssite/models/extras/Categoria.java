package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.Getter;

//Categorias de plugin
@Getter
public enum Categoria {

    GESTAO(4, "Gestão"),
    DEPENDENCIAS(3, "Dependencias"),
    MINIGAMES(2, "Minigames"),
    UTILS(1, "Utilidades");

    final int index;
    final String name;


    /**
     *
     * @param index número de ordem da categoria
     * @param name nome formatado da categoria
     */

    Categoria(int index, String name) {
        this.index = index;
        this.name = name;
    }

    /**
     * Pega a categoria pelo index
     *
     * @param index número de ordem da categoria
     * @return A categoria escolhida
     * @throws IllegalArgumentException Se não encontrar o índice
     */
    public static Categoria fromValue(int index) {
        for (Categoria status : Categoria.values()) {
            if (status.getIndex() == index) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown enum value: " + index);
    }
}
