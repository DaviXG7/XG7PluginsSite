package com.xg7plugins.xg7plguinssite.servlets;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "excluirusuario", value = "/home/admin/excluirusuario")

public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel user = (UserModel) req.getSession().getAttribute("user");
        UserModel targetUser = null;
        try {
            targetUser = DBManager.getUserById(req.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (targetUser == null) throw new RuntimeException();
        if (!user.getId().equals(targetUser.getId()) && user.getPermission() < 5 || targetUser.getPermission() >= 5) throw new RuntimeException();
        try {
            DBManager.deleteUser(targetUser.getId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (user.getId().equals(targetUser.getId())) {
            req.getSession().setAttribute("user" , null);
            resp.sendRedirect("../../index.jsp");
            return;
        }
        resp.sendRedirect("clientes.jsp?page=1");
    }
}
