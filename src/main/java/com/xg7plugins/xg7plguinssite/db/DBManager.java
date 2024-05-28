package com.xg7plugins.xg7plguinssite.db;

import com.xg7plugins.xg7plguinssite.models.PluginModel;
import com.xg7plugins.xg7plguinssite.models.UserModel;
import com.xg7plugins.xg7plguinssite.models.extras.Categoria;
import com.xg7plugins.xg7plguinssite.models.extras.Changelog;
import com.xg7plugins.xg7plguinssite.utils.Pair;
import lombok.Getter;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class DBManager {
    @Getter
    private static Connection connection;

    //Iniciar Database
    public static void init() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/xg7plugins","root",""
        );
        connection.setAutoCommit(true);
    }

    //Desconectar database
    public static void discconect() throws SQLException {
        connection.close();
        connection = null;
    }

    //Verificar se o usuário existe
    public static boolean exists(String email) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM users WHERE email = ?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    //Usuários
    public static void updateUserImage(UserModel user) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("UPDATE users SET avatarimg = ? WHERE id = ?");
        statement.setBlob(1, user.getAvatarImg());
        statement.setString(2, user.getId().toString());
        statement.executeUpdate();

    }
    public static void updateUserPermission(UserModel userModel) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("UPDATE users SET perm = ? WHERE id = ?");
        statement.setInt(1, userModel.getPermission());
        statement.setString(2, userModel.getId().toString());
        statement.executeUpdate();
    }

    public static void updateUser(UserModel user) throws SQLException {
        PreparedStatement statement = connection.prepareStatement("UPDATE users SET name = ?, senha = ? WHERE id = ?");
        statement.setString(1, user.getNome());
        statement.setString(2, user.getSenha());
        statement.setString(3, user.getId().toString());
        statement.executeUpdate();
    }

    public static UserModel getUser(String email, String senha) throws SQLException {

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE email = ? AND senha = ?");
        preparedStatement.setString(2, senha);
        preparedStatement.setString(1, email);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (!resultSet.next()) {
            return null;
        }

        return new UserModel(resultSet.getString("name"), UUID.fromString(resultSet.getString("id")),
                resultSet.getBlob("avatarimg"),
                resultSet.getString("email"),
                resultSet.getString("senha"),
                resultSet.getInt("perm"));
    }
    public static UserModel getUserById(String id) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM users WHERE id = ?");
        preparedStatement.setString(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (!resultSet.next()) {
            return null;
        }

        return new UserModel(resultSet.getString("name"), UUID.fromString(resultSet.getString("id")),
                resultSet.getBlob("avatarimg"),
                resultSet.getString("email"),
                resultSet.getString("senha"),
                resultSet.getInt("perm"));
    }
    public static void addUser(UserModel session) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO users(name,id,email,senha,perm,avatarimg) VALUES (?,?,?,?,?,?)");
        preparedStatement.setString(1, session.getNome());
        preparedStatement.setString(2, session.getId().toString());
        preparedStatement.setString(3, session.getEmail());
        preparedStatement.setString(4, session.getSenha());
        preparedStatement.setInt(5, session.getPermission());
        preparedStatement.setBlob(6, session.getAvatarImg());
        preparedStatement.executeUpdate();
    }
    public static List<UserModel> allUsers() throws SQLException {
        List<UserModel> users = new ArrayList<>();
        ResultSet set = connection.prepareStatement("SELECT * FROM users").executeQuery();

        while (set.next()) {
            List<Integer> permissions = new ArrayList<>();

            users.add(new UserModel(set.getString("name"), UUID.fromString(set.getString("id")),
                set.getBlob("avatarimg"),
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

    //Add a plugin
    public static void addPlugin(PluginModel model) throws SQLException {
        PreparedStatement preparedStatementPlugins = connection.prepareStatement("INSERT INTO plugins(name,category,video,pluginPath,versions,price,resources,github,dependencies,configpath) VALUES (?,?,?,?,?,?,?,?,?,?)");
        PreparedStatement preparedStatementCommands = connection.prepareStatement("INSERT INTO plugincommands(pluginname,command,description) VALUES (?,?,?)");
        PreparedStatement preparedStatementPerms = connection.prepareStatement("INSERT INTO pluginperms(pluginname,perm,description) VALUES (?,?,?)");

        preparedStatementPlugins.setString(1, model.getName());
        preparedStatementPlugins.setInt(2, model.getCategory().getIndex());
        preparedStatementPlugins.setString(3,model.getUrlVideo());
        preparedStatementPlugins.setString(4, model.getPluginPath());
        preparedStatementPlugins.setString(5, model.getVersion());
        preparedStatementPlugins.setDouble(6, model.getPrice());
        preparedStatementPlugins.setString(7, model.getResourses());
        preparedStatementPlugins.setString(8, model.getGithub());
        preparedStatementPlugins.setString(9, model.getDependencies());
        preparedStatementPlugins.setString(10,model.getConfigPath());
        preparedStatementPlugins.executeUpdate();

        for (Pair<String, String> commands : model.getCommands()) {
            preparedStatementCommands.setString(1, model.getName());
            preparedStatementCommands.setString(2, commands.getFirst());
            preparedStatementCommands.setString(3, commands.getSecond());
            preparedStatementCommands.executeUpdate();
        }
        for (Pair<String, String> perms : model.getPermissions()) {
            preparedStatementPerms.setString(1, model.getName());
            preparedStatementPerms.setString(2, perms.getFirst());
            preparedStatementPerms.setString(3, perms.getSecond());
            preparedStatementPerms.executeUpdate();
        }

    }

    public PluginModel getPlugin(String pluginName) throws SQLException {
        PreparedStatement ps = connection.prepareStatement("SELECT * FROM plugins WHERE name = ?");
        ps.setString(1, pluginName);
        ResultSet resultSet = ps.executeQuery();
        if (!resultSet.next()) {
            return null;
        }
        PreparedStatement cs = connection.prepareStatement("SELECT * FROM plugincommands WHERE pluginname = ?");
        cs.setString(1, pluginName);
        ResultSet cr = cs.executeQuery();

        PreparedStatement pes = connection.prepareStatement("SELECT * FROM pluginperms WHERE pluginname = ?");
        pes.setString(1, pluginName);
        ResultSet per = cs.executeQuery();

        PreparedStatement pcs = connection.prepareStatement("SELECT * FROM pluginchangelog WHERE pluginname = ?");
        pcs.setString(1, pluginName);
        ResultSet pcr = pcs.executeQuery();

        PreparedStatement pds = connection.prepareStatement("SELECT * FROM plugindownloads WHERE pluginname = ?");
        pds.setString(1, pluginName);
        ResultSet pdr = pds.executeQuery();

        List<Pair<String,String>> commands = new ArrayList<>();
        while (cr.next()) commands.add(new Pair<>(cr.getString("command"), cr.getString("description")));

        List<Pair<String,String>> perms = new ArrayList<>();
        while (cr.next()) perms.add(new Pair<>(per.getString("perm"), per.getString("description")));

        List<UUID> downloads = new ArrayList<>();
        while (pdr.next()) downloads.add(UUID.fromString(pdr.getString("userid")));

        List<Changelog> changelogs = new ArrayList<>();
        while (pcr.next()) changelogs.add(new Changelog(pcr.getDate("changedate"), pcr.getString("changelog"), pcr.getString("pluginversion")));

        return null;
    }


}
