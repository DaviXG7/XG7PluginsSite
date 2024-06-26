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

//Edita as informações do usuário

@WebServlet(name = "editarusuario", urlPatterns = "/home/user/editarusuario")
public class EditUserServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega o usuário que edita e o usuário que está sendo editado
        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5 && !userEdit.getId().equals(userRequest.getId())) throw new RuntimeException("Você não tem permissão para executar isto!");

        //Pega o valor dos inputs
        String novoNome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        String novaSenha = request.getParameter("novaSenha");
        novaSenha = novaSenha == null || novaSenha.equals("undefined") ? "" : novaSenha;
        novoNome = novoNome.equals("undefined") ? "" : novoNome;

        //Verifica se não há erros
        if (userRequest.getPermission() < 5) {
            if (!senha.equals(userEdit.getSenha()) || !userRequest.getId().equals(userEdit.getId())) {
                request.setAttribute("errormsg", "A senha está incorreta!");
                request.getRequestDispatcher("user.jsp?uuid=" + userEdit.getId().toString()).forward(request, response);
                return;
            }
        }

        if (novoNome.isEmpty() && novaSenha.isEmpty()) throw new RuntimeException();

        if (!novaSenha.isEmpty() && (novaSenha.toLowerCase().equals(novaSenha) || novaSenha.length() < 8)) throw new RuntimeException("O tamanho da senha é menor que 8 caracteres ou não tem letra maiúscula");

        //Coloca o nome e a senha
        if (!novoNome.equals(userEdit.getNome()) && !novoNome.isEmpty()) userEdit.setNome(novoNome);


        if (!novaSenha.equals(userEdit.getSenha()) && !novaSenha.isEmpty()) userEdit.setSenha(novaSenha);

        //Manda ao banco de dados
        try {
            DBManager.updateUser(userEdit);
            if (!novaSenha.isEmpty()) {
                request.getSession().setAttribute("user", null);
                response.sendRedirect("/");
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Redireciona para o site
        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());


    }


}
