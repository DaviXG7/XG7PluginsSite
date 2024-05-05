package com.xg7plugins.xg7plguinssite.servlets;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.emails.Message;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "cadastro", value = "/cadastro")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmaSenha");
        boolean aceitarTermos = request.getParameter("aceitarTermos") != null;

        if (nome == null || nome.isEmpty() || email == null || email.isEmpty() || senha == null || senha.isEmpty() || confirmarSenha == null || confirmarSenha.isEmpty()) {
            request.setAttribute("erromsg", "Preencha todos os campos!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            response.sendRedirect("cadastro.jsp");
            return;
        }
        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("erromsg", "As senhas devem combinar!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            response.sendRedirect("cadastro.jsp");
            return;
        }

        if (!aceitarTermos) {
            request.setAttribute("erromsg", "Você precisa aceitar os termos!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            response.sendRedirect("cadastro.jsp");
            return;
        }
        try {
            if (DBManager.exists(email)) {
                request.setAttribute("erromsg", "Este usuário já existe!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                response.sendRedirect("cadastro.jsp");
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        UserModel model = new UserModel(nome, UUID.randomUUID(), "", email,senha);

        try {
            new Message("Bem-vindo ao XG7Plugins!",
                    "<div style=\"\">" +
                    "Depois eu coloco algo aqui, estou com preguiça :P" +
                    "</div>").enviarEmail(email);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        try {
            DBManager.addUser(model);
            DBManager.addPerm(model.getId(), 1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("user", model);
        request.getRequestDispatcher("home/dashboard.jsp").forward(request, response);
        response.sendRedirect("home/dashboard.jsp");


    }

}
