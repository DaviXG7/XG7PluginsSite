package com.xg7plugins.xg7plguinssite.servlets.plugin;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.PluginModel;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "deletarpl", value = "/home/admin/deletarpl")
public class PluginDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //Pega o usuário que edita, o usuário que está sendo editado e exclui
        UserModel user = (UserModel) req.getSession().getAttribute("user");
        PluginModel plugin = null;
        try {
            plugin = DBManager.getPlugin(req.getParameter("plugin"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        if (user.getPermission() == 4 && user.getPermission() <= 2) throw new RuntimeException();

            try {
            DBManager.deletePlugin(plugin);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        resp.sendRedirect("plugins.jsp");
    }
}
