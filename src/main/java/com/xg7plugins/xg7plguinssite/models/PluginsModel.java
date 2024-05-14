package com.xg7plugins.xg7plguinssite.models;

import com.xg7plugins.xg7plguinssite.models.extras.Categoria;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class PluginsModel {

    private String name;
    private Categoria category;
    private String versions;
    private String resourses;
    private String urlVideo;
    private HashMap<String,String> commands;
    private HashMap<String,String> permissions;
    private String pluginPath;
    private List<Changelog> changelogList;
    private List<UUID> downloads;
    private double price;

    public void addDownload(UUID id) {
        for (UUID uuid : downloads) {
            if (!uuid.equals(id)) downloads.add(id);
        }
    }


}
