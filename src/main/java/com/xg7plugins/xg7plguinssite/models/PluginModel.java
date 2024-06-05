package com.xg7plugins.xg7plguinssite.models;

import com.xg7plugins.xg7plguinssite.models.extras.Categoria;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import com.xg7plugins.xg7plguinssite.models.extras.Imagem;
import com.xg7plugins.xg7plguinssite.utils.Pair;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.sql.Blob;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class PluginModel {

    private String name;
    private Categoria category;
    private String version;
    private String description;
    private String compatibilyVersion;
    private String resourses;
    private String urlVideo;
    private String github;
    private String dependencies;
    private List<Pair<String, String>> commands;
    private List<Pair<String, String>> permissions;
    private List<Imagem> images;
    private Blob plugin;
    private Blob config;
    private List<Changelog> changelogList;
    private List<UUID> downloads;
    private double price;

    public void addDownload(UUID id) {
        for (UUID uuid : downloads) {
            if (!uuid.equals(id)) downloads.add(id);
        }
    }


}
