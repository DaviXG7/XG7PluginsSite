package com.xg7plugins.xg7plguinssite.servlets.userservlet;

import com.xg7plugins.xg7plguinssite.db.DBManager;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.imageio.ImageIO;
import javax.sql.rowset.serial.SerialBlob;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

//Edita a imagem do usuário

@MultipartConfig
@WebServlet(name = "editarimagem", urlPatterns = "/home/user/editarimagem")
public class EditUserImageServlet extends HttpServlet {


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Pega o usuário que edita e o usuário que está sendo editado
        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5 && (!userEdit.getId().equals(userRequest.getId()))) throw new RuntimeException("Você não tem permissão para executar isto!");

        //Pega a imagem na página
        Part part = request.getPart("imagem");

        if (!isImage(part)) throw new RuntimeException();

        InputStream inputStream = part.getInputStream();

        //Bota a imagem e manda para o banco de dados
        try {
            userEdit.setAvatarImg(new SerialBlob(inputStream.readAllBytes()));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            DBManager.updateUserImage(userEdit);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        //Manda o usuário para a página de edição
        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());
    }

    /**
     * Verifica se a Part é uma imagem
     *
     * @param part A Part da imagem
     * @return se é uma imagem ou não
     */
    private boolean isImage(Part part) {
        try (InputStream input = part.getInputStream()) {
            BufferedImage image = ImageIO.read(input);
            return image != null;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }


}
