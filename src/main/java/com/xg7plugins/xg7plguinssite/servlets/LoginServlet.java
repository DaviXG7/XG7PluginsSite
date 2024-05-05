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

@WebServlet(name = "cadastro", value = "/cadastro")
public class LoginServlet extends HttpServlet {


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (email == null || email.isEmpty() || senha == null || senha.isEmpty()) {
            request.setAttribute("erromsg", "Preencha todos os campos!");
            request.getRequestDispatcher("cadastro.jsp").forward(request, response);
            response.sendRedirect("cadastro.jsp");
            return;
        }

        UserModel model;

        try {
            if (!DBManager.exists(email)) {
                request.setAttribute("erromsg", "Este usuário não existe!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                response.sendRedirect("cadastro.jsp");
                return;
            }
            model = DBManager.getUser(email,senha);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("user", model);
        request.getRequestDispatcher("home/dashboard.jsp").forward(request, response);
        response.sendRedirect("home/dashboard.jsp");

    }
}
