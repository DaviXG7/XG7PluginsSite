package com.xg7plugins.xg7plguinssite.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.io.File;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class UserModel {

    private String nome;
    private UUID id;
    private String avatarPath;
    private String email;
    private String senha;
    public File getUserImage() {
        return (new File(avatarPath));
    }
}
