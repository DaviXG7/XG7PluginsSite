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
import java.util.*;
import java.sql.Date;
import java.util.stream.IntStream;

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
        if (!plugin.getSubmittedFileName().contains("jar")) throw new RuntimeException();
        if (!configs.getSubmittedFileName().contains("zip")) throw new RuntimeException();
        if (commandValues.length != commandDescriptions.length) throw new RuntimeException();
        if (permValues.length != permDescriptions.length) throw new RuntimeException();

        Collection<Part> fileParts = request.getParts();

        List<Imagem> imagens = new ArrayList<>();
        for (int i = 0; i < fileParts.size() - 2; i++) {
            if (fileParts.stream().toList().get(i).getName().contains("img")) {

                Part part = request.getPart("img" + i);
                String title = request.getParameter("img-titulo" + i);
                String description = request.getParameter("img-desc" + i);

                if (part != null) {
                    if (!isImage(part)) throw new RuntimeException();
                    try {
                        imagens.add(new Imagem(new SerialBlob(part.getInputStream().readAllBytes()), title, description));
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                }
            }
        }

        List<Pair<String, String>> commands = IntStream.range(0, permValues.length - 1).mapToObj(i -> new Pair<>(commandValues[i], commandDescriptions[i])).toList();
        List<Pair<String, String>> perms = IntStream.range(0, permValues.length - 1).mapToObj(i -> new Pair<>(permValues[i], permDescriptions[i])).toList();

        Changelog log = new Changelog(new Date(System.currentTimeMillis()), versaoPlugin, "Lançamento do plugin com seus recursos: \n\n" + resources.replace(";;;", "\n"));

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
                    new SerialBlob(configs.getInputStream().readAllBytes()),
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

        response.sendRedirect("home/plugin/create.jsp");


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
