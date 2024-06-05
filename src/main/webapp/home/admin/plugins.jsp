<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Plugins</title>
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../../imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>

    <style>
        .plugin {
            width: 500px;
            height: 350px;
            display: flex;
            align-items: center;
            padding: 10px 0 10px 0;
            border-radius: 10px;
            justify-content: space-between;
        }
        .plugins {
            width: 100%;
            padding: 10px;
            flex-wrap: wrap;
        }
        .change-log {
            height: 350px;
            max-height: 350px;
            overflow-y: auto;
            scroll-behavior: smooth;
        }
        .plugin-caixa {
            width: 200px;
            background-color: #f5f5f5;
            height: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 10px 0 10px 0;
            border-radius: 10px;
        }
        .atualizacao {
            width: 100%;
            background-color: #f5f5f5;
            height: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2px;
            border-radius: 10px;
            flex-wrap: wrap;
        }
        .change-log {
            padding: 10px 0 10px 0;
            margin: 6px;
            width: 350px;
            overflow-y: auto;
        }
    </style>



</head>

<body>
<div class="wrapper">
    <div id="barra-lateral" class="barra-lateral sidebar">


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
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="https://discord.gg/84rqYVREsY"><i style="color: rgba(255,255,255,.5);" class="bi bi-telephone"></i><p class="textos-botoes"> Suporte</p></a>
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="https://ko-fi.com/davixg7"><i style="color: rgba(255,255,255,.5);" class="bi bi-cash"></i><p class="textos-botoes" > Doação</p></a>
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
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="admin/clientes.jsp?page=1"><i style="color: rgba(255,255,255,.5);" class="bi bi-people"></i> <p class="textos-botoes" > Clientes</p></a>
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href=""><i style="color: rgba(255,255,255,.5);" class="bi bi-plug"></i> <p class="textos-botoes" > Plugins</p></a>
            </div>
        </div>

        <hr>
        <%
            }
        %>





    </div>


    <main>

        <header>
            <button id="hamburger" class="btn" onclick="toggleMenu('barra-lateral','flex','none')">
                <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
                </svg>
            </button>
            <div class="h-botoes">
                <%
                    if (model.getPermission() > 1) {
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
                        <a href=<%="user/user.jsp?uuid=" + model.getId().toString()%> class="dropdown-item">
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

            <div class="plugins">
                <div class="plugin">
                    <div class="plugin-caixa">
                        <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-plugin" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1 8a7 7 0 1 1 2.898 5.673c-.167-.121-.216-.406-.002-.62l1.8-1.8a3.5 3.5 0 0 0 4.572-.328l1.414-1.415a.5.5 0 0 0 0-.707l-.707-.707 1.559-1.563a.5.5 0 1 0-.708-.706l-1.559 1.562-1.414-1.414 1.56-1.562a.5.5 0 1 0-.707-.706l-1.56 1.56-.707-.706a.5.5 0 0 0-.707 0L5.318 5.975a3.5 3.5 0 0 0-.328 4.571l-1.8 1.8c-.58.58-.62 1.6.121 2.137A8 8 0 1 0 0 8a.5.5 0 0 0 1 0"></path>
                        </svg>
                        <p>Utilidades</p>
                        <h5>XG7Lobby</h5>
                        <p>Grátis</p>
                        <div class="plugin-botoes">
                            <button class="btn btn-success">Editar</button>
                            <button class="btn btn-danger">Excluir</button>
                            <button onclick="abrirTela('XG7Lobby')" class="btn btn-primary">Ver detalhes</button>
                        </div>
                    </div>
                    <div class="change-log">

                        <div class="atualizacao">
                            <div style="border-left: 1px solid black; padding: 3px 0 3px 1px; flex-wrap: wrap; height: auto">

                                <h2><strong>Versão 1.2.3_03</strong></h2>
                                <p style="font-size: 15px">04/06/2024 ás 00:00
                                </p>
                                <ul>
                                    <li>asddssasadasddasadsadsasd</li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </main>
</div>


</body>

<script src="../js/menu.js"></script>
<script>
    let plsJSON = <%=PluginJson.getAllPluginsJSON()%>;
    let pls = []
    plsJSON.forEach(function (e) {
        pls.push(JSON.parse(e))
    })

</script>
<script src="../../js/showplugins.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/dashboard.js"></script>

</html>