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

@WebServlet(name = "editarpermissao", urlPatterns = "/home/user/editarpermissao")
public class EditUserPermissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega o usuário que edita e o usuário que está sendo editado
        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Verifica se tem erros
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5) throw new RuntimeException();
        if (request.getParameter("permissions") == null) throw new RuntimeException();

        int permission = Integer.parseInt(request.getParameter("permissions"));
        if (permission == 0) throw new RuntimeException();
        if (permission == 6 && userEdit.getPermission() <= 5) throw new RuntimeException();

        //Coloca a permissão e manda ao banco de dados
        userEdit.setPermission(permission);
        try {
            DBManager.updateUserPermission(userEdit);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());

    }
}
