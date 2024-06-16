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
import org.json.JSONArray;
import org.json.JSONObject;

import javax.imageio.ImageIO;
import javax.net.ssl.HttpsURLConnection;
import javax.sql.rowset.serial.SerialBlob;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

//Atualiza um plugin

@MultipartConfig
@WebServlet(name = "atualizarpl", value = "/home/plugin/atualizarpl")
public class PluginUpdateServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega as insformações do site

        String plName = request.getParameter("plugin");
        if (plName.isEmpty()) throw new RuntimeException();


        String newVersion = request.getParameter("newVersion");
        String log = request.getParameter("changelog");

        if (log == null || log.isEmpty() || newVersion == null || newVersion.isEmpty()) throw new RuntimeException();

        //Faz uma atualização

        Changelog changelog = new Changelog(new Timestamp(System.currentTimeMillis()), newVersion, log);

        try {
            //Posta a atualização
            DBManager.postUpdate(plName, changelog);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        new Thread(() -> {

            //Manda a atualização para o discord

            JSONObject embed = new JSONObject();
            embed.put("title", plName);
            embed.put("color", 0x00FFFF); // Cor no formato decimal (ex: 0xFF0000 para vermelho)

            // Adiciona campos ao embed
            JSONArray fields = new JSONArray();
            JSONObject field1 = new JSONObject();
            field1.put("name", "Versão atual");
            field1.put("value", changelog.getPluginVersion());
            field1.put("inline", false);
            fields.put(field1);

            JSONObject field2 = new JSONObject();
            field2.put("name", "Novidades");
            field2.put("value", changelog.getChangelogText());
            field2.put("inline", false);
            fields.put(field2);

            embed.put("fields", fields);

            embed.put("footer", new JSONObject().put("text", "Para mais informações acesse https://xg7plguins.com"));

            // Adiciona o embed ao payload
            JSONObject payload = new JSONObject();
            payload.put("content", "# NOVA ATUALIZAÇÃO do plugin " + plName + " \n @everyone");
            payload.put("embeds", new JSONArray().put(embed));

            // Envia o payload ao webhook
            try {
                sendWebhook(payload);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }).start();


        //Edita caso a pessoa escolha a opção para editar
        //Ele pega as informações do site e edita o plugin

        if (request.getParameter("editar") != null && request.getParameter("editar").equals("on")) {

            String[] commandValues = request.getParameterValues("commandName");
            String[] commandDescriptions = request.getParameterValues("commandDescription");

            String[] permValues = request.getParameterValues("permName");
            String[] permDescriptions = request.getParameterValues("permDescription");

            String resources = String.join(";;;", request.getParameterValues("resource"));

            if (commandValues.length == 0 || commandDescriptions.length == 0 ||
                    permDescriptions.length == 0 || permValues.length == 0 || resources.isEmpty())
                throw new RuntimeException("Não foi inserido um dos valores esperados!");

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
                DBManager.editPlugin(model.getName(), model);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
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

    /**
     * Manda a atualização para o discord
     *
     * @param payload o json do embed
     * @throws Exception Se ocorrer algum erro ao enviar
     */

    private static void sendWebhook(JSONObject payload) throws Exception {
        URL url = new URL("https://discord.com/api/webhooks/1251771970073395313/qD4y20xe__UFlPenzSFk-0TUS0HnIj67mMf5_BDQ-MIysMO_Vac2HCyWAFz-Whv3cz0L");
        HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
        connection.addRequestProperty("Content-Type", "application/json");
        connection.addRequestProperty("User-Agent", "Java-DiscordWebhook-BY-Gelox_");
        connection.setDoOutput(true);
        connection.setRequestMethod("POST");

        OutputStream stream = connection.getOutputStream();
        stream.write(payload.toString().getBytes());
        stream.flush();
        stream.close();

        connection.getInputStream().close();
        connection.disconnect();
    }
}
