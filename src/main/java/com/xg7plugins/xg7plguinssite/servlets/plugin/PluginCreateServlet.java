package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
import com.xg7plugins.xg7plguinssite.models.extras.Categoria;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import com.xg7plugins.xg7plguinssite.models.extras.Imagem;
import com.xg7plugins.xg7plguinssite.utils.Pair;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.imageio.ImageIO;
import javax.sql.rowset.serial.SerialBlob;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

//Cria o plugin

@WebServlet(name = "criarplugin", value = "/home/plugin/criarplugin")
@MultipartConfig
public class PluginCreateServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega todas as informações da página
        Part plugin = request.getPart("plugin");
        Part configs = request.getPart("configs");

        String name = request.getParameter("nome");
        String versaoPlugin = request.getParameter("pluginversion");
        String descricao = request.getParameter("description");
        String categoria = request.getParameter("categoria");
        String url = request.getParameter("urlVideo");
        String github = request.getParameter("github");
        String versaoCompativel = request.getParameter("compatibilyVersion");
        double preco = Double.parseDouble(request.getParameter("preco"));
        String depedencies = request.getParameter("dependencies");

        String[] commandValues = request.getParameterValues("commandName");
        String[] commandDescriptions = request.getParameterValues("commandDescription");

        String[] permValues = request.getParameterValues("permName");
        String[] permDescriptions = request.getParameterValues("permDescription");

        String resources = String.join(";;;", request.getParameterValues("resource"));

        //Verifica se algo saiu errado
        if (commandValues.length == 0 || commandDescriptions.length == 0 ||
        permDescriptions.length == 0 || permValues.length == 0 || resources.isEmpty() ||
        plugin == null || name == null || name.isEmpty()
        || categoria == null || versaoPlugin == null || versaoPlugin.isEmpty() || depedencies == null
        || depedencies.isEmpty() || versaoCompativel == null || versaoCompativel.isEmpty() ||
        descricao == null || descricao.isEmpty()) throw new RuntimeException("Não foi inserido um dos valores esperados!");
        if (categoria.equals("0")) throw new RuntimeException("Categoria inválida");
        if (preco < 0) throw new RuntimeException("O preço nao pode ser 0");
        if (!Objects.equals(configs.getSubmittedFileName(), "") && !configs.getSubmittedFileName().contains("zip")) throw new RuntimeException();
        if (!plugin.getSubmittedFileName().contains("jar")) throw new RuntimeException();
        if (commandValues.length != commandDescriptions.length) throw new RuntimeException("Não foi inserido um dos valores esperados!");
        if (permValues.length != permDescriptions.length) throw new RuntimeException("Não foi inserido um dos valores esperados!");
        try {
            if (DBManager.getPlugin(name) != null) throw new RuntimeException();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Junta todas as informações para colocar no construtor

        Collection<Part> fileParts = request.getParts();

        List<Imagem> imagens = new ArrayList<>();
        int indexImage = 0;
        for (int i = 0; i < fileParts.size(); i++) {
            if (fileParts.stream().toList().get(i).getName().contains("img")) {

                Part part = request.getPart("img" + indexImage);
                String title = request.getParameter("img-titulo" + indexImage);
                String description = request.getParameter("img-desc" + indexImage);


                if (part != null && !part.getSubmittedFileName().isEmpty()) {
                    if (!isImage(part)) throw new RuntimeException();
                    try {
                        imagens.add(new Imagem(new SerialBlob(part.getInputStream().readAllBytes()), title, description));
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                }
                indexImage++;
            }
        }

        List<Pair<String, String>> commands = new ArrayList<>();
        for (int i = 0; i < commandValues.length; i++) {
            if (Objects.equals(commandValues[i], "") || Objects.equals(commandDescriptions[i], "")) throw new RuntimeException();
            Pair<String, String> stringStringPair = new Pair<>(commandValues[i], commandDescriptions[i]);
            commands.add(stringStringPair);
        }
        List<Pair<String, String>> perms = new ArrayList<>();
        for (int i = 0; i < permValues.length; i++) {
            if (Objects.equals(permValues[i], "") || Objects.equals(permDescriptions[i], "")) throw new RuntimeException();
            Pair<String, String> stringStringPair = new Pair<>(permValues[i], permDescriptions[i]);
            perms.add(stringStringPair);
        }

        Changelog log = new Changelog(new Timestamp(System.currentTimeMillis()), versaoPlugin, "Lançamento do plugin com seus recursos: \n\n" + resources.replace(";;;", "\n"));

        PluginModel model = null;
        try {
            //Constrói o plugin
            model = new PluginModel(
                    name,
                    Categoria.fromValue(Integer.parseInt(categoria)),
                    versaoPlugin,
                    descricao,
                    versaoCompativel,
                    resources,
                    url,
                    github,
                    depedencies,
                    commands,
                    perms,
                    imagens,
                    new SerialBlob(plugin.getInputStream().readAllBytes()),
                    configs.getSubmittedFileName().isEmpty() ? null : new SerialBlob(configs.getInputStream().readAllBytes()),
                    Collections.singletonList(log),
                    new ArrayList<>(),
                    preco
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Adiciona ao banco de dados
        try {
            DBManager.addPlugin(model);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        PluginModel finalModel = model;
        new Thread(() -> {

            //Manda a atualização para o discord

            JSONObject embed = new JSONObject();
            embed.put("title", "NOVO PLUGIN " + finalModel.getImages());
            embed.put("color", 0x00FFFF);

            // Adiciona campos ao embed
            JSONArray fields = new JSONArray();
            JSONObject field1 = new JSONObject();
            field1.put("name", "<:file:1254976723066290188> Descrição");
            field1.put("value", "<:java:1252027840552108143> " + finalModel.getDescription());
            field1.put("inline", false);
            fields.put(field1);

            JSONObject field2 = new JSONObject();
            field2.put("name", "<a:estrela:1254976686454345770> Recursos");
            field2.put("value", finalModel.getResourses().replace(";;;", "\n") );
            field2.put("inline", false);
            fields.put(field2);

            JSONObject field3 = new JSONObject();
            field3.put("name", "Links");
            String a = finalModel.getPrice() == 0 ? "\n[<:8719downloadapps:1252027852573114459> Download](https://xg7plugins.com/download?plugin=" + finalModel.getName() + "&type=plugin)" : "";
            field3.put("value", "[<:8346github:1252027857228664872> Github](https://github.com/DaviXG7)\n"
                    + "[\uD83D\uDCAD Saiba mais](https://xg7plugins.com)"
                    +  a);

            field3.put("inline", false);
            fields.put(field3);

            embed.put("fields", fields);

            embed.put("footer", new JSONObject().put("text", "XG7Plugins - Todos os direitos reservados"));

            // Adiciona o embed ao payload
            JSONObject payload = new JSONObject();
            payload.put("content", "@everyone");
            payload.put("embeds", new JSONArray().put(embed));

            // Envia o payload ao webhook
            try {
                PluginUpdateServlet.sendWebhook(payload);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }).start();

        //Redireciona para a página de plugins
        response.sendRedirect("/home/admin/plugins.jsp");


    }


    /**
     * Verifica se a Part é uma imagem
     *
     * @param part A Part da imagem
     * @return se é uma imagem ou não
     */
    private boolean isImage(Part part) {
        try (InputStream input = part.getInputStream()) {
            BufferedImage image = ImageIO.read(input);
            return image != null;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }




}
