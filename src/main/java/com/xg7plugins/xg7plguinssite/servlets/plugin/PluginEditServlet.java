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
import java.rmi.RemoteException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.*;

@WebServlet(name = "editarplugin", value = "/home/plugin/editarplugin")
@MultipartConfig
public class PluginEditServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String plName = request.getParameter("plugin");
        if (plName.isEmpty()) throw new RuntimeException("Não foi inserido um dos valores esperados!");

        //Pega todas as informações da página
        Part configs = request.getPart("configs");

        String nome = request.getParameter("nome");
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
                permDescriptions.length == 0 || permValues.length == 0 || resources.isEmpty()
                || categoria == null || depedencies == null
                || depedencies.isEmpty() || versaoCompativel == null || versaoCompativel.isEmpty() ||
                descricao == null || descricao.isEmpty()) throw new RuntimeException("Não foi inserido um dos valores esperados!");
        if (categoria.equals("0")) throw new RuntimeException("Categoria ta errada!");
        if (preco < 0) throw new RuntimeException("preço não pode ser menor que 0");
        if (!Objects.equals(configs.getSubmittedFileName(), "") && !configs.getSubmittedFileName().contains("zip")) throw new RuntimeException("Tipo de arquivo inválido");
        if (commandValues.length != commandDescriptions.length) throw new RuntimeException("Não foi inserido um dos valores esperados!");
        if (permValues.length != permDescriptions.length) throw new RuntimeException("Não foi inserido um dos valores esperados!");


        //Pega as imagens do site
        Collection<Part> fileParts = request.getParts();

        List<Imagem> imagens = new ArrayList<>();
        int indexImage = 0;
        for (int i = 0; i < fileParts.size(); i++) {
            if (fileParts.stream().toList().get(i).getName().contains("img") &&
                    !fileParts.stream().toList().get(i).getName().contains("-")) {

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
                } else {
                    try {
                        PluginModel model = DBManager.getPlugin(plName);

                       if (model.getImages().size() > indexImage) imagens.add(model.getImages().get(indexImage));
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

        //Edita o plugin e bota no banco de dados
        try {
            PluginModel model = DBManager.getPlugin(plName);
            if (model == null) throw new RuntimeException();

            model.setName(nome);
            model.setDescription(descricao);
            model.setCategory(Categoria.fromValue(Integer.parseInt(categoria)));
            model.setCommands(commands);
            model.setPermissions(perms);
            model.setImages(imagens);
            model.setGithub(github);
            model.setCompatibilyVersion(versaoCompativel);
            model.setUrlVideo(url);
            model.setResourses(resources);
            model.setDependencies(depedencies);
            model.setPrice(preco);
            model.setConfig(configs.getSubmittedFileName().isEmpty() ? model.getConfig() : new SerialBlob(configs.getInputStream().readAllBytes()));
            DBManager.editPlugin(plName, model);


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Redireciona a pessoa para o site
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
