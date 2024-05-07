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

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {




    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (email == null || email.isEmpty() || senha == null || senha.isEmpty()) {
            request.setAttribute("erromsg", "Preencha todos os campos!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserModel model;

        try {
            if (!DBManager.exists(email, senha)) {
                request.setAttribute("erromsg", "Este usuário não existe!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            model = DBManager.getUser(email,senha);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.getSession().setAttribute("user", model);
        response.sendRedirect("home/dashboard.jsp");


    }
}
