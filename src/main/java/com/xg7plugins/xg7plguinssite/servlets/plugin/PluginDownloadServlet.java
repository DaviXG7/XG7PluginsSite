package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;

@WebServlet(name = "download", value = "/download")
public class PluginDownloadServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pluginName = request.getParameter("plugin");
        String type = request.getParameter("type");

        if (pluginName == null || type == null || pluginName.isEmpty() || type.isEmpty()) throw new RuntimeException();

        switch (type) {
            case "config" -> {

                try {
                    PluginModel model = DBManager.getPlugin(pluginName);

                    if (model.getConfig() == null) throw new RuntimeException();

                    response.setContentType("application/zip");
                    response.setContentLength((int) model.getConfig().length());

                    response.setHeader("Content-Disposition", "attachment; filename=\"" + model.getName() + ".zip\"");

                    try (InputStream in = model.getConfig().getBinaryStream();
                         OutputStream out = response.getOutputStream()) {

                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;
                        while ((bytesRead = in.read(buffer)) != -1) {
                            out.write(buffer, 0, bytesRead);
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }


            }
            case "plugin" -> {
                try {
                    PluginModel model = DBManager.getPlugin(pluginName);

                    if (model.getPrice() != 0) throw new RuntimeException();

                    response.setContentType("application/java");
                    response.setContentLength((int) model.getPlugin().length());

                    response.setHeader("Content-Disposition", "attachment; filename=\"" + model.getName() + " " + model.getVersion() + ".jar\"");

                    try (InputStream in = model.getPlugin().getBinaryStream();
                         OutputStream out = response.getOutputStream()) {

                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;
                        while ((bytesRead = in.read(buffer)) != -1) {
                            out.write(buffer, 0, bytesRead);
                        }
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }

            }
        }

        throw new RuntimeException();

    }


}