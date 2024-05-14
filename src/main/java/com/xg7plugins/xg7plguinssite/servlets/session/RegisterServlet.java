package com.xg7plugins.xg7plguinssite.servlets.session;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.emails.Message;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import javax.mail.MessagingException;
import javax.sql.rowset.serial.SerialBlob;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "cadastro", value = "/cadastro")
public class RegisterServlet extends HttpServlet {




    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");
        boolean aceitarTermos = request.getParameter("termos").equals("on");
        if (nome == null || nome.isEmpty() || email == null || email.isEmpty() || senha == null || senha.isEmpty() || confirmarSenha == null || confirmarSenha.isEmpty()) {
            throw new RuntimeException();
        }
        if (senha.toLowerCase().equals(senha) || senha.length() < 7) {
            throw new RuntimeException();
        }
        if (!senha.equals(confirmarSenha)) {
            throw new RuntimeException();
        }

        if (!aceitarTermos) {
            throw new RuntimeException();
        }
        try {
            if (DBManager.exists(email)) {
                request.setAttribute("erromsg", "Este usuário já existe!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        InputStream inputStream = new URL("https://minotar.net/avatar/" + nome + ".png").openStream();

        UserModel model = null;
        try {
            model = new UserModel(nome, UUID.randomUUID(), new SerialBlob(inputStream.readAllBytes()), email,senha, 1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        new Thread(() -> {
            try

            {
                new Message("Bem-vindo ao XG7Plugins!",
                        "<div style=\"\">" +
                                "Depois eu coloco algo aqui, estou com preguiça :P" +
                                "</div>").enviarEmail(email);
            } catch(
                    MessagingException | UnsupportedEncodingException e)

            {
                throw new RuntimeException(e);
            }
        });

        try {
            DBManager.addUser(model);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.getSession().setAttribute("user", model);
        response.sendRedirect("home/dashboard.jsp");


    }

}
