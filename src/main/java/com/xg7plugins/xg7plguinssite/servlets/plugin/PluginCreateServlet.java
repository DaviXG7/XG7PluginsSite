package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
import com.xg7plugins.xg7plguinssite.utils.Pair;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@WebServlet(name = "criarplugin", value = "/home/plugin/criarplugin")
@MultipartConfig
public class PluginCreateServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega todas as informações da página
        Part plugin = request.getPart("plugin");
        Part configs = request.getPart("configs");
        Part images = request.getPart("imagens");

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

        File file = new File("C:\\Users\\davis\\Documents\\XG7Plugins\\PastaSite\\XG7PlguinsSite\\src\\main\\java\\com\\xg7plugins\\xg7plguinssite\\data\\plugindata" + File.separator + name);
        if (!file.exists()) {
            file.mkdirs();
        }
        File imagesDir = new File("C:\\Users\\davis\\Documents\\XG7Plugins\\PastaSite\\XG7PlguinsSite\\src\\main\\java\\com\\xg7plugins\\xg7plguinssite\\data\\plugindata" + File.separator + name + File.separator + "images");
        if (!imagesDir.exists()) {
            imagesDir.mkdirs();
        }
        Collection<Part> fileParts = request.getParts();


        //Escreve o arquivo na paste de dados
        String pluginPath = "C:\\Users\\davis\\Documents\\XG7Plugins\\PastaSite\\XG7PlguinsSite\\src\\main\\java\\com\\xg7plugins\\xg7plguinssite\\data\\plugindata" + File.separator + name + File.separator + name + ".jar";
        String configPath = "C:\\Users\\davis\\Documents\\XG7Plugins\\PastaSite\\XG7PlguinsSite\\src\\main\\java\\com\\xg7plugins\\xg7plguinssite\\data\\plugindata" + File.separator + name + File.separator + name + "Config.zip";
        plugin.write(pluginPath);
        configs.write(configPath);

        List<Pair<String, String>> commands = IntStream.range(0, permValues.length - 1).mapToObj(i -> new Pair<>(commandValues[i], commandDescriptions[i])).collect(Collectors.toList());
        List<Pair<String, String>> perms = IntStream.range(0, permValues.length - 1).mapToObj(i -> new Pair<>(permValues[i], permDescriptions[i])).collect(Collectors.toList());

        //Faz o modelo e manda ao banco de dados
        PluginModel model = null;

        try {
            DBManager.addPlugin(model);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("home/plugin/create.jsp");


    }




}
