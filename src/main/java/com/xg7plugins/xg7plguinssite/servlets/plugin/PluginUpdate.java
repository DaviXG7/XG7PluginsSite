package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Date;
import java.sql.SQLException;

@WebServlet(name = "atualizarpl", value = "/home/plugin/atualizarpl")
public class PluginUpdate extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {

        String plName = request.getParameter("plugin");
        if (plName.isEmpty()) throw new RuntimeException();

        String newVersion = request.getParameter("newVersion");
        String log = request.getParameter("changelog");
        System.out.println(log == null );
        System.out.println(log.isEmpty());
        System.out.println(newVersion == null);
        System.out.println(newVersion.isEmpty());

        if (log == null || log.isEmpty() || newVersion == null || newVersion.isEmpty()) throw new RuntimeException();

        Changelog changelog = new Changelog(new Date(System.currentTimeMillis()), newVersion, log);

        try {
            DBManager.postUpdate(plName, changelog);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
