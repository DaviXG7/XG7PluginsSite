package com.xg7plugins.xg7plguinssite.servlets.userservlet;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "editarpermissao", value = "/home/user/editarpermissao")
public class EditUserPermissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5) throw new RuntimeException();
        if (request.getParameter("permissao") == null) throw new RuntimeException();
        System.out.println(request.getParameter("permissao"));
        int permission = Integer.parseInt(request.getParameter("permissao"));
        if (permission == 0) throw new RuntimeException();

        userEdit.setPermission(permission);
        try {
            DBManager.updateUserPermission(userEdit);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());

    }
}
