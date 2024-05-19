package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.Getter;

//Categorias de plugin
@Getter
public enum Categoria {

    ADMIN(4, "Administração"),
    DEPENDENCIAS(3, "Dependencias"),
    MINIGAMES(2, "Minigames"),
    UTILS(1, "Utilidades");

    final int index;
    final String name;

    Categoria(int index, String name) {
        this.index = index;
        this.name = name;
    }

    public static Categoria fromValue(int index) {
        for (Categoria status : Categoria.values()) {
            if (status.getIndex() == index) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown enum value: " + index);
    }
}
