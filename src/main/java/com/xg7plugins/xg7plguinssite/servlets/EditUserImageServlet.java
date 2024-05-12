package com.xg7plugins.xg7plguinssite.servlets;

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

@MultipartConfig
@WebServlet(name = "editarimagem", value = "/home/user/editarimagem")
public class EditUserImageServlet extends HttpServlet {


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel userRequest = (UserModel) request.getSession().getAttribute("user");
        UserModel userEdit = null;
        try {
            userEdit = DBManager.getUserById(request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userEdit == null) throw new RuntimeException();
        if (userRequest.getPermission() < 5 && !userEdit.getId().equals(userRequest.getId())) throw new RuntimeException();

        Part part = request.getPart("imagem");

        if (!isImage(part)) throw new RuntimeException();

        InputStream inputStream = part.getInputStream();
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
        response.sendRedirect("/home/user/user.jsp?uuid=" + userEdit.getId());
    }

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
