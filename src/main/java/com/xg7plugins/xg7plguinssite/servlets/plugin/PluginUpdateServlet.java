package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
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
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

@MultipartConfig
@WebServlet(name = "atualizarpl", value = "/home/plugin/atualizarpl")
public class PluginUpdateServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String plName = request.getParameter("plugin");
        if (plName.isEmpty()) throw new RuntimeException();


        String newVersion = request.getParameter("newVersion");
        String log = request.getParameter("changelog");

        if (log == null || log.isEmpty() || newVersion == null || newVersion.isEmpty()) throw new RuntimeException();

        Changelog changelog = new Changelog(new Timestamp(System.currentTimeMillis()), newVersion, log);

        try {
            DBManager.postUpdate(plName, changelog);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        if (request.getParameter("editar") != null && request.getParameter("editar").equals("on")) {

            String[] commandValues = request.getParameterValues("commandName");
            String[] commandDescriptions = request.getParameterValues("commandDescription");

            String[] permValues = request.getParameterValues("permName");
            String[] permDescriptions = request.getParameterValues("permDescription");

            String resources = String.join(";;;", request.getParameterValues("resource"));

            if (commandValues.length == 0 || commandDescriptions.length == 0 ||
                    permDescriptions.length == 0 || permValues.length == 0 || resources.isEmpty())
                throw new RuntimeException();

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

            PluginModel model = null;
            try {
                model = DBManager.getPlugin(plName);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            model.setResourses(resources);
            model.setImages(imagens);
            model.setCommands(commands);
            model.setPermissions(perms);

            try {
                DBManager.editPlugin(model);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
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
