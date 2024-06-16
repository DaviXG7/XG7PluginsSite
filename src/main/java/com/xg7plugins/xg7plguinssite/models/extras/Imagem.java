package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

//Imagem do plugin
@AllArgsConstructor
@Getter
@Setter
public class Imagem {
    private Blob image;
    private String titulo;
    private String descricao;

    /**
     * Pega o valor em base64 da imagem
     *
     * @return a imagem em base64 para HTML
     */
    public String getImageData() {
        byte[] imagemBytes = null;
        try {
            imagemBytes = this.image.getBytes(1, (int) this.image.length());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return "data:image/png;base64," + Base64.getEncoder().encodeToString(imagemBytes);
    }
}
