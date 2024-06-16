package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import com.xg7plugins.xg7plguinssite.models.extras.Imagem;
import com.xg7plugins.xg7plguinssite.utils.Pair;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.SQLException;
import java.time.format.DateTimeFormatter;

//Pega todos os plugin e coloca em um json para ser pego no site
public class PluginJson {

    /**
     * Transforma um plugin em um JSON
     *
     * @param pluginName O nome do plugin a ser pego
     * @return O JSON do plugin
     */
    public static String getPluginJson(String pluginName) {
        PluginModel pluginModel = null;
        try {
            pluginModel = DBManager.getPlugin(pluginName);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        JSONObject jsonObject = new JSONObject();

        JSONObject json = new JSONObject();

        json.put("nome", pluginModel.getName());
        json.put("descricao", pluginModel.getDescription());
        json.put("downloads", pluginModel.getDownloads().size());
        json.put("github", pluginModel.getGithub());
        json.put("baixar", pluginModel.getPlugin() == null ? JSONObject.NULL : pluginModel.getPlugin().toString());
        json.put("config", pluginModel.getConfig() == null ? "" : "notNull");
        json.put("preco", pluginModel.getPrice());
        json.put("categoria", pluginModel.getCategory().getName());
        json.put("linkYoutube", pluginModel.getUrlVideo());
        json.put("versao", pluginModel.getCompatibilyVersion());
        json.put("dependencias", new JSONArray());

        JSONArray recursos = new JSONArray();
        if (pluginModel.getResourses() != null) {
            for (String recurso : pluginModel.getResourses().split(",")) {
                recursos.put(recurso);
            }
        }
        json.put("recursos", recursos);

        JSONArray comandos = new JSONArray();
        for (Pair<String, String> comando : pluginModel.getCommands()) {
            JSONObject cmdJson = new JSONObject();
            cmdJson.put("nome", comando.getFirst());
            cmdJson.put("descricao", comando.getSecond());
            comandos.put(cmdJson);
        }
        json.put("comandos", comandos);

        JSONArray perms = new JSONArray();
        for (Pair<String, String> perm : pluginModel.getPermissions()) {
            JSONObject permJson = new JSONObject();
            permJson.put("nome", perm.getFirst());
            permJson.put("descricao", perm.getSecond());
            perms.put(permJson);
        }
        json.put("perms", perms);

        JSONArray changelogArray = new JSONArray();
        for (Changelog changelog : pluginModel.getChangelogList()) {
            JSONObject clJson = new JSONObject();
            clJson.put("versao", changelog.getPluginVersion());
            clJson.put("data", changelog.getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + " ás " + changelog.getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("HH:mm")) + "\n");
            clJson.put("logs", changelog.getChangelogText());
            changelogArray.put(clJson);
        }
        json.put("changelog", changelogArray);

        JSONArray imagens64 = new JSONArray();
        for (Imagem imagem : pluginModel.getImages()) {
            JSONObject imgJson = new JSONObject();
            imgJson.put("titulo", imagem.getTitulo());
            imgJson.put("descricao", imagem.getDescricao());
            imgJson.put("imagem64", imagem.getImageData());
            imagens64.put(imgJson);
        }
        json.put("imagens64", imagens64);

        return json.toString();
    }

    /**
     * Pega todos os plugins e coloca em formato JSON
     *
     * @return Todos os plugin em formato JSON
     */
    public static String getAllPluginsJSON() {
        JSONArray array = new JSONArray();

        try {
            for (PluginModel model : DBManager.getAllPlugins()) {
                array.put(getPluginJson(model.getName()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return array.toString();
    }


}
