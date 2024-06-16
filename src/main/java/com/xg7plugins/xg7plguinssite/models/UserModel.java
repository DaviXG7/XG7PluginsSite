package com.xg7plugins.xg7plguinssite.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.UUID;

//Modelo do usuário
@Getter
@Setter
@AllArgsConstructor
public class UserModel {

    private String nome;
    private UUID id;
    private Blob avatarImg;
    private String email;
    private String senha;
    private int permission;

    /**
     * Pega a imagem em base64 do usuário
     *
     * @return a imagem do usuário em base64 para HTML
     */
    public String getImageData() {
        if (this.avatarImg == null) return null;
        byte[] imagemBytes = null;
        try {
            imagemBytes = this.avatarImg.getBytes(1, (int) this.avatarImg.length());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return "data:image/png;base64," + Base64.getEncoder().encodeToString(imagemBytes);
    }
}
