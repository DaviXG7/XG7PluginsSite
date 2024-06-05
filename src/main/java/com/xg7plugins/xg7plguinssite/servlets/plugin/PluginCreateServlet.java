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

import javax.imageio.ImageIO;
import javax.sql.rowset.serial.SerialBlob;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;
import java.sql.Date;

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
        descricao == null || descricao.isEmpty()) throw new RuntimeException();
        if (categoria.equals("0")) throw new RuntimeException();
        if (preco < 0) throw new RuntimeException();
        if (!Objects.equals(configs.getSubmittedFileName(), "") && !configs.getSubmittedFileName().contains("zip")) throw new RuntimeException();
        if (!plugin.getSubmittedFileName().contains("jar")) throw new RuntimeException();
        if (commandValues.length != commandDescriptions.length) throw new RuntimeException();
        if (permValues.length != permDescriptions.length) throw new RuntimeException();

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
                    configs.getSubmittedFileName().equals("") ? null : new SerialBlob(configs.getInputStream().readAllBytes()),
                    Collections.singletonList(log),
                    new ArrayList<>(),
                    preco
            );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {
            DBManager.addPlugin(model);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/home/admin/plugins.jsp");


    }

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
