package com.xg7plugins.xg7plguinssite.models;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.extras.Categoria;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import com.xg7plugins.xg7plguinssite.models.extras.Imagem;
import com.xg7plugins.xg7plguinssite.utils.Pair;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
            if (!downloads.contains(id)) {
                downloads.add(id);
                try {
                    PreparedStatement statement = DBManager.getConnection().prepareStatement("INSERT INTO plugindownloads(pluginname,uuid) VALUES(?,?)");
                    statement.setString(1, name);
                    statement.setString(2, id.toString());
                    statement.executeUpdate();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
    }


}
