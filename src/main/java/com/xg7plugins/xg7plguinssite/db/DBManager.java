package com.xg7plugins.xg7plguinssite.db;

import com.xg7plugins.xg7plguinssite.models.UserModel;
import lombok.Getter;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class DBManager {
    @Getter
    private static Connection connection;

    public static void init() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/xg7plugins","root",""
        );
        connection.setAutoCommit(true);
    }

    public static UserModel getUser(String nome, String senha) throws SQLException {

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE nome = ? AND senha = ?");
        preparedStatement.setString(2, senha);
        preparedStatement.setString(1, nome);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (!resultSet.next()) {
            return null;
        }



        return new UserModel(resultSet.getString("name"), UUID.fromString(resultSet.getString("id")),
                resultSet.getString("avatarpath"),
                resultSet.getString("email"),
                resultSet.getString("senha"));
    }
    public static void addUser(UserModel session) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users(name,id,email,senha,avatarpath) VALUES (?,?,?,?,?)");
        preparedStatement.setString(1, session.getNome());
        preparedStatement.setString(2, session.getId().toString());
        preparedStatement.setString(3, session.getEmail());
        preparedStatement.setString(4, session.getSenha());
        preparedStatement.setString(5, session.getAvatarPath());
        preparedStatement.executeUpdate();
    }
    public static List<UserModel> allUsers() throws SQLException {
        List<UserModel> users = new ArrayList<>();
        ResultSet set = connection.prepareStatement("SELECT * FROM contas").executeQuery();
        while (set.next()) users.add(new UserModel(set.getString("name"), UUID.fromString(set.getString("id")),
                set.getString("avatarpath"),
                set.getString("email"),
                set.getString("senha")));

        return users;

    }


}
