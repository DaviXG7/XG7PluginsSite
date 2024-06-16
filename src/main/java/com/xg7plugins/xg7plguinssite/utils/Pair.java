package com.xg7plugins.xg7plguinssite.utils;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;


//Classe pair para pares Ex.: par<Nome do plugin, Atualização dele>

@Getter
@Setter
@AllArgsConstructor
public class Pair<A,B> {

    private A first;
    private B second;
}
