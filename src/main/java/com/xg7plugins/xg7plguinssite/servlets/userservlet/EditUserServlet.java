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

@WebServlet(name = "editarusuario", value = "/home/user/editarusuario")
public class EditUserServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5 && !userEdit.getId().equals(userRequest.getId())) throw new RuntimeException();

        String novoNome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        String novaSenha = request.getParameter("novaSenha");
        novaSenha = novaSenha.equals("undefined") ? "" : novaSenha;
        novoNome = novoNome.equals("undefined") ? "" : novoNome;

        System.out.println(novoNome);
        System.out.println(senha);
        System.out.println(novaSenha);

        if (userRequest.getPermission() < 5) {
            if (!senha.equals(userEdit.getSenha()) || !userRequest.getId().equals(userEdit.getId())) {
                request.setAttribute("errormsg", "A senha está incorreta!");
                request.getRequestDispatcher("user.jsp?uuid=" + userEdit.getId().toString()).forward(request, response);
                return;
            }
        }

        if (novoNome.isEmpty() && novaSenha.isEmpty()) {
            throw new RuntimeException();
        }
        if (novaSenha.toLowerCase().equals(novaSenha) || novaSenha.length() < 8) {
            throw new RuntimeException("O tamanho da senha é menor que 8 caracteres ou não tem letra maiúscula");
        }

        if (!novoNome.equals(userEdit.getNome()) && !novoNome.isEmpty()) {
            userEdit.setNome(novoNome);
        }

        if (!novaSenha.equals(userEdit.getSenha()) && !novaSenha.isEmpty()) {
            userEdit.setSenha(novaSenha);
        }
        try {
            DBManager.updateUser(userEdit);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());


    }


}
