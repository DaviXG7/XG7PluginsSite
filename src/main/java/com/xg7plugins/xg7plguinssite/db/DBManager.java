package com.xg7plugins.xg7plguinssite.db;

import com.xg7plugins.xg7plguinssite.models.PluginsModel;
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
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/xg7plugins","root",""
        );
        connection.setAutoCommit(true);
    }
    public static boolean exists(String email) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    public static UserModel getUser(String email, String senha) throws SQLException {

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE email = ? AND senha = ?");
        preparedStatement.setString(2, senha);
        preparedStatement.setString(1, email);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (!resultSet.next()) {
            return null;
        }

        /*
            CEO 6
            ADMIN 5
            EDITOR SITE 4
            EDITOR PLUGINS 3
            AUXILIAR 2
            CLIENTE 1
         */




        return new UserModel(resultSet.getString("name"), UUID.fromString(resultSet.getString("id")),
                resultSet.getString("avatarpath"),
                resultSet.getString("email"),
                resultSet.getString("senha"),
                resultSet.getInt("perm"));
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

        while (set.next()) {
            List<Integer> permissions = new ArrayList<>();

            users.add(new UserModel(set.getString("name"), UUID.fromString(set.getString("id")),
                set.getString("avatarpath"),
                set.getString("email"),
                set.getString("senha"),
                    set.getInt("perm")));
        }

        return users;

    }

    public static void deleteUser(UUID id) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM users WHERE id = ?");
        preparedStatement.setString(1, id.toString());
        preparedStatement.executeUpdate();
    }

    public static void deletePerm(UUID id, int perm) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM permissions WHERE id_perm = ? AND id_user = ?");
        preparedStatement.setInt(1, perm);
        preparedStatement.setString(2, id.toString());
        preparedStatement.executeUpdate();

    }
    public static void addPerm(UUID id, int perm) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO permissions(id_perm,id_user) VALUES (?,?)");
        preparedStatement.setString(2, id.toString());
        preparedStatement.setInt(1, perm);
        preparedStatement.executeUpdate();
    }

    public static List<Integer> userPermissions(UUID id) throws SQLException {

        /*
            CEO 6
            ADMIN 5
            EDITOR SITE 4
            EDITOR PLUGINS 3
            AUXILIAR 2
            CLIENTE 1
         */


        List<Integer> permissions = new ArrayList<>();

        PreparedStatement statement = connection.prepareStatement("SELECT * FROM permissions WHERE id_user = ?");
        statement.setString(1, id.toString());
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            permissions.add(resultSet.getInt("id_perm"));
        }
        return permissions;

    }





    public static void addPlugin(PluginsModel model) throws SQLException {

        PreparedStatement preparedStatementPlugins = connection.prepareStatement("INSERT INTO plugins(name,category,video,pluginPath,versions,price,resources) VALUES (?,?,?,?,?,?,?)");
        PreparedStatement preparedStatementCommands = connection.prepareStatement("INSERT INTO plugincommands(pluginname,command,description) VALUES (?,?,?)");
        PreparedStatement preparedStatementPerms = connection.prepareStatement("INSERT INTO pluginperms(pluginname,perms,description) VALUES (?,?,?)");
        PreparedStatement preparedStatementChangeLog = connection.prepareStatement("INSERT INTO pluginchangelog(pluginname,changedate,changelog) VALUES (?,?,?)");

        preparedStatementPlugins.setString(1, model.getName());
        preparedStatementPlugins.setInt(2, model.getCategory().ordinal());
        preparedStatementPlugins.setString(3,model.getUrlVideo());
        preparedStatementPlugins.setString(4,model.getPluginPath());
        preparedStatementPlugins.setString(5,model.getVersions());
        preparedStatementPlugins.setDouble(6,model.getPrice());
        preparedStatementPlugins.setString(7,model.getResourses());
        preparedStatementPlugins.executeUpdate();




    }


}
