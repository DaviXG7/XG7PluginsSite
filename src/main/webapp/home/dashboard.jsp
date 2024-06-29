<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.extras.Changelog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.PluginModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.xg7plugins.xg7plguinssite.utils.Pair" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Página principal</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/dashboard.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../imgs/logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        .atualizacoes {
            width: 50%;

        }
        .atualizacao {
            background-color: #eaeaea;
            padding: 10px;
            border-radius: 15px;
            margin: 10px;
            flex-wrap: wrap;
            word-wrap: break-word;
            overflow-wrap: break-word;
            white-space: normal;
        }

        @media screen and (max-width: 600px) {
            .atualizacoes {
                width: 80%;

            }
        }
    </style>

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");

        List<Pair<String, Changelog>> changelogs = new ArrayList<>();

        List<PluginModel> models = null;
        try {
            models = DBManager.getAllPlugins();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        models.forEach(plugin -> plugin.getChangelogList().stream().map(changelog -> new Pair<>(plugin.getName(), changelog)).forEach(changelogs::add));

        changelogs.sort((o1, o2) -> o2.getSecond().getDate().compareTo(o1.getSecond().getDate()));


    %>



</head>

<body>

<div class="barra-lateral" id="barra">
    <a href="../index.jsp">
        <img src="../imgs/logo.png" width="135" alt="">
    </a>

    <hr>

    <!-- Heading -->
    <div class="menus">
        <div class="sidebar-heading side-title">
            INTERFACE
        </div>
        <div class="botoes">
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="https://discord.gg/84rqYVREsY"><i style="color: rgba(255,255,255,.5);" class="bi bi-telephone"></i><p class="textos-botoes"> Suporte</p></a>
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="/apoie.jsp"><i class="bi bi-cup-hot" style="color: rgba(255,255,255,.5);"></i><p class="textos-botoes" > Apioe</p></a>
        </div>
    </div>

    <hr>

    <%
        if (model.getPermission() > 1) {
    %>

    <div class="menus">
        <div class="sidebar-heading side-title">
            ADMIN
        </div>
        <div class="botoes">
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="/home/admin/clientes.jsp"><i style="color: rgba(255,255,255,.5);" class="bi bi-people"></i> <p class="textos-botoes" > Clientes</p></a>
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="/home/admin/plugins.jsp"><i style="color: rgba(255,255,255,.5);" class="bi bi-plug"></i> <p class="textos-botoes" > Plugins</p></a>
        </div>
    </div>

    <hr>
    <%
        }
    %>

    <button id="sairbarra" class="btn" onclick="toggleMenu('barra-lateral','flex','none')">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
        </svg>
    </button>
</div>
<div class="tela" id="tela">
</div>
<main class="w-100 h-100">
    <header>
        <button id="hamburger" class="btn" onclick="toggleMenu('barra-lateral','flex')">
            <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
            </svg>
        </button>
        <div class="h-botoes">
            <%
                if (model.getPermission() != 4 && model.getPermission() > 2) {
            %>
            <div class="dropdown">
                <button style="border: none; background: none" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-plus" style="font-size: 30px; padding: 0 10px 0 10px"></i>
                </button>
                <ul class="dropdown-menu">
                    <a class="dropdown-item" href="plugin/create.jsp">Criar Plugin</a>
                    <a class="dropdown-item" href="plugin/update.jsp">Postar atualização</a>
                </ul>
            </div>
            <%
                }
            %>

            <div class="dropdown">
                <button style="border: none; background-color: white" type="button" data-bs-toggle="dropdown">
                    <img src="<%=model.getImageData() == null ? "alt.png" : model.getImageData()%>" width="60" height="60" style="border: solid black 1px; border-radius: 100%" alt="">
                </button>
                <ul class="dropdown-menu">
                    <p class="dropdown-item"><%=model.getNome()%></p>
                    <div class="dropdown-divider"></div>
                    <a href=<%="/home/user/user.jsp?uuid=" + model.getId().toString()%> class="dropdown-item">
                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                        Configurações
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="/logout" class="dropdown-item" data-toggle="modal" data-target="#logoutModal">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Encerrar seção
                    </a>
                </ul>
            </div>
        </div>
    </header>
    <div class="pag">

        <h1><strong>Bem-vindo ao XG7Plugins, <%=model.getNome()%>!</strong></h1>
        <h4>Em breve terá uma coisa bem legal aqui!</h4>
        <h6>No futuro haverá fóruns e outras coisas, por enquanto não haverá nada demais por aqui.</h6>
        <br>
        <h1>Últimas atualizações</h1>


        <div class="atualizacoes">

            <%
                for (Pair<String, Changelog> log : changelogs) {
            %>
            <div class="atualizacao">
                <div class="d-flex flex-column ">

                    <h1><%=log.getFirst()%></h1>

                    <h2><strong>Versão <%=log.getSecond().getPluginVersion()%></strong></h2>
                    <p style="font-size: 15px"><%=log.getSecond().getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + " ás " + log.getSecond().getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("HH:mm"))%>
                    </p>
                    <ul>
                        <%
                            for (String s : log.getSecond().getChangelogText().split("\n")) {


                        %>
                        <li><%=s%></li>
                        <%
                            }
                        %>
                    </ul>

                </div>
            </div>
            <%
                }
            %>

        </div>


    </div>
</main>


</body>

<script src="../js/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/dashboard.js"></script>

</html>