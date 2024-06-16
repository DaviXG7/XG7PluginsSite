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

//Deleta o usuário do site
@WebServlet(name = "excluirusuario", value = "/home/admin/excluirusuario")

public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //Pega o usuário que edita, o usuário que está sendo editado e exclui
        UserModel user = (UserModel) req.getSession().getAttribute("user");
        UserModel targetUser = null;
        try {
            targetUser = DBManager.getUserById(req.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        //O usuário precisa das suas permissões
        if (targetUser == null) throw new RuntimeException();
        if (!user.getId().equals(targetUser.getId()) && (user.getPermission() < 5 || targetUser.getPermission() >= 5)) throw new RuntimeException("Você não tem permissão para executar isto!");

        try {
            //Deleta do banco de dados
            DBManager.deleteUser(targetUser.getId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        /*
            Caso o usuário que edita for igual ao usuário que
            está sendo editado ele desloga e manda para a página principal
         */
        if (user.getId().equals(targetUser.getId())) {
            req.getSession().setAttribute("user" , null);
            resp.sendRedirect("../../index.jsp");
            return;
        }
        resp.sendRedirect("clientes.jsp?page=1");
    }
}
