package com.xg7plugins.xg7plguinssite.servlets.session;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.UserModel;

import javax.sql.rowset.serial.SerialBlob;

import com.xg7plugins.xg7plguinssite.utils.emails.Mensagem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.sql.SQLException;
import java.util.UUID;

//Faz o cadastro do usuário
@WebServlet(name = "cadastro", value = "/cadastro")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Pega todas as informações da página
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");
        boolean aceitarTermos = request.getParameter("termos").equals("on");

        //Verifica algum erro
        if (nome == null || nome.isEmpty() || email == null || email.isEmpty() || senha == null || senha.isEmpty() || confirmarSenha == null || confirmarSenha.isEmpty()) throw new RuntimeException("Não foi preenchido os campos!");
        if (senha.toLowerCase().equals(senha) || senha.length() < 8) throw new RuntimeException("O tamanho da senha é menor que 8 caracteres ou não tem letra maiúscula");
        if (!senha.equals(confirmarSenha)) throw new RuntimeException("As senhas não conhecidem");
        if (senha.trim().contains(" ")) throw new RuntimeException("A senha contém espaços");
        if (!aceitarTermos) throw new RuntimeException("Você precisa aceitar os termos");
        try {
            if (DBManager.exists(email)) {
                request.setAttribute("erromsg", "Este usuário já existe!");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response);
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Pega a imagem do usuário do minecraft pela API do minotar.net
        InputStream inputStream = new URL("https://minotar.net/avatar/" + nome.replace( " ", "") + ".png").openStream();

        //Cria o usuário
        UserModel model = null;
        try {
            model = new UserModel(nome, UUID.randomUUID(), new SerialBlob(inputStream.readAllBytes()), email,senha.trim(), 1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        //Adiciona o usuário ao banco de dados
        try {
            DBManager.addUser(model);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        UserModel finalModel = model;
        new Thread(() -> new Mensagem("Bem-vindo a XG7Plugins, " + finalModel.getNome() + "!",
                "<div   style=\"color: black; display: flex; justify-content: center ; font-family: Arial, Helvetica, sans-serif ; border-radius: 20px ; border: solid black 1px ; width: 300px ; height: 350px; background-color: white \">\n" +
                        "\n" +
                        "  <div align=\"center\" style=\"text-align: center ; padding: 10px ; border-radius: 20px ; margin: 20px ;  width: 300px ; height: 300px ; background-color: #f5f5f5 \" >\n" +
                        "    <img width=\"100\" height=\"100\" src=\"https://xg7plugins.com/imgs/logo.png\" alt=\"Logo\">\n" +
                        "\n" +
                        "   <h3>Seja muito Bem-vindo à XG7Plugins, " + finalModel.getNome() + "!</h3>\n" +
                        "    <p style=\"font-size: 14px \"> Obrigado por escolher os nossos plugins</p>\n" +
                        "       <p style=\"font-size: 14px \">Acesse a sua conta clicando <a href=\"https://xg7network.com/home/user/user.jsp?uuid=" + finalModel.getId() + "\">aqui</a></p>\n" +
                        "        <small style=\"font-size: 10px \">Copyright © XG7Plugins Todos os direitos reservados</small>\n" +
                        "   </div>\n" +
                        "</div>")
                .enviarEmail(finalModel.getEmail())).start();

        request.getSession().setAttribute("user", model);

        //Redireciona ao dashboard
        response.sendRedirect("home/dashboard.jsp");


    }

}
