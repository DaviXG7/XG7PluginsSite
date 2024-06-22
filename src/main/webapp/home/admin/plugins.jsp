<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.PluginModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.extras.Changelog" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Plugins</title>
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="../css/confirmar.css" rel="stylesheet">
    <link href="../../css/detalhes.css" rel="stylesheet">
    <link href="../../css/buttonsair.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../../imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");


    %>

    <style>
        .plugins {
            width: 100%;
            height: auto;
            display: flex;
            flex-wrap: wrap;

        }

        .plugin {
            width: 550px;
            height: 300px;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }
        svg {
            max-height: 100px;
        }
        .plugin-caixa {
            background: #eaeaea;
            padding: 15px;
            border-radius: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .change-log {
            width: 250px;
            height: 100%;
            max-height: 100%;
            overflow: auto;
            scroll-behavior: smooth;
        }

        .atualizacao2 {
            margin: 10px 0 10px 0;
            padding: 10px;
            width: 100%;
            background: #eaeaea;
            border-radius: 20px;
            flex-wrap: wrap;
            word-wrap: break-word;
            overflow-wrap: break-word;
            white-space: normal;
        }

        @media screen and (max-width: 700px){

            .plugin {
                height: 550px;
                width: 300px;
                flex-direction: column;
            }
        }
    </style>



</head>

<body>
<div id="confirm" class="d-none certeza">
    <div class="certeza-caixa">

        <h1>Tem Certeza que quer fazer isso?</h1>
        <div>
            <a id="sim" href="" class="btn btn-danger">Sim</a>
            <button class="btn btn-success" onclick="fecharCerteza()">Não</button>
        </div>

    </div>
</div>
<div class="detalhes-plugin d-none" id="detalhes">
    <button id="sair" class="btn bg-white position-absolute">
        <i class="bi bi-x-circle bg-white"></i>
    </button>
    <div class="caixa-detalhe" id="caixaDetalhe">
        <div class="detalhes-header">
            <div class="d-flex w-auto">
                <img src="../../imgs/logo.png" width="100" height="100" alt="">
                <div class="d-flex flex-column justify-content-between mt-2">
                    <h5><strong id="nomePlugin"></strong></h5>
                    <p style="font-size: 14px"><strong id="downloads"></strong> Downloads</p>
                </div>

            </div>

            <div class="d-flex flex-column w-auto">
                <a id="baixar" href="" class="btn btn-outline-primary mt-1 mb-1">Baixar</a>
                <a id="github" href="" class="btn btn-outline-primary mt-1 mb-1">Github</a>
            </div>
        </div>
        <nav class="detalhes-nav">

            <a id="a1" class="link link-primary" onclick="mostrarAba('visao-geral', 'a1')">Visão geral</a>
            <a id="a2" class="link link-dark" onclick="mostrarAba('comandos', 'a2')">Comandos</a>
            <a id="a3" class="link link-dark" onclick="mostrarAba('permissions', 'a3')">Permissões</a>
            <a id="a4" class="link link-dark" onclick="mostrarAba('atualizacoes', 'a4')">Atualizações</a>
            <a id="a5" class="link link-dark">Configs</a>

        </nav>
        <div id="abas">
            <div id="visao-geral" class="active">
                <div class="content">
                    <div class="plugin-content">
                        <p id="description" style="max-width: 350px;">

                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                            incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                            exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
                            dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
                            mollit anim id est laborum."

                        </p>
                        <div class="d-flex">
                            <h5><strong>Versão compatível:</strong></h5>
                            <p id="versao" class="visao-geral-versão-item"></p>
                        </div>
                        <div class="visao-geral-dependencias" id="caixa-dependencia">
                            <h5><strong>Dependências:</strong></h5>
                            <div id="dependencias" class="d-flex w-100" style="padding-left: 15px; flex-wrap: wrap">
                            </div>
                        </div>
                        <div class="visao-geral-recursos">
                            <h5><strong>Recursos:</strong></h5>
                            <ol id="recursos">

                            </ol>
                        </div>
                        <div id="imagens" class="carousel slide" data-bs-ride="carousel">
                            <h5><strong>Imagens</strong></h5>

                            <div class="carousel-indicators" id="indicators">
                            </div>

                            <div class="carousel-inner" id="imgs">

                            </div>

                            <button class="carousel-control-prev" type="button" data-bs-target="#imagens"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#imagens"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </button>
                        </div>
                        <div id="urlVideo">

                        </div>
                    </div>
                </div>
            </div>
            <div id="comandos" class="">
                <div class="content">
                    <div class="plugin-content">
                        <ul class="no-decoration-list" id="comandosL">
                        </ul>
                    </div>
                </div>
            </div>
            <div id="permissions" class="">
                <div class="content">
                    <div class="plugin-content">
                        <ul class="no-decoration-list" id="perms">
                        </ul>
                    </div>
                </div>
            </div>
            <div id="atualizacoes" class="">
                <div class="content">
                    <div id="changelog" class="plugin-content" style="background-color: #eaeaea !important;">

                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
<div class="barra-lateral" id="barra">
    <a href="/home/dashboard.jsp">
        <img src="../../imgs/logo.png" width="135" alt="">
    </a>

    <hr>

    <!-- Heading -->
    <div class="menus">
        <div class="sidebar-heading side-title">
            INTERFACE
        </div>
        <div class="botoes">
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="https://discord.gg/84rqYVREsY"><i style="color: rgba(255,255,255,.5);" class="bi bi-telephone"></i><p class="textos-botoes"> Suporte</p></a>
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="https://ko-fi.com/davixg7"><i style="color: rgba(255,255,255,.5);" class="bi bi-cash"></i><p class="textos-botoes" > Doação</p></a>
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
        <div class="pesquisa bg-white rounded d-flex align-items-center">
            <a class="btn"><i class="bi bi-search"></i></a>
            <input style="height: 40px" class="form-control" id="pesquisar" type="search" placeholder="Buscar plugin..." aria-label="Search">
        </div>
        <div class="h-botoes">
            <%
                if (model.getPermission() != 4 && model.getPermission() > 2) {
            %>
            <div class="dropdown">
                <button style="border: none; background: none" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-plus" style="font-size: 30px; padding: 0 10px 0 10px"></i>
                </button>
                <ul class="dropdown-menu">
                    <a class="dropdown-item" href="/home/plugin/create.jsp">Criar Plugin</a>
                    <a class="dropdown-item" href="/home/plugin/update.jsp">Postar atualização</a>
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

            <div class="plugins">
                <%
                    List<PluginModel> models = new ArrayList<>();
                    try {
                        models = DBManager.getAllPlugins();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    for (PluginModel plugin : models) {
                %>
                <div class="plugin" id=<%=plugin.getName()%>>
                    <div class="plugin-caixa">
                        <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-plugin" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1 8a7 7 0 1 1 2.898 5.673c-.167-.121-.216-.406-.002-.62l1.8-1.8a3.5 3.5 0 0 0 4.572-.328l1.414-1.415a.5.5 0 0 0 0-.707l-.707-.707 1.559-1.563a.5.5 0 1 0-.708-.706l-1.559 1.562-1.414-1.414 1.56-1.562a.5.5 0 1 0-.707-.706l-1.56 1.56-.707-.706a.5.5 0 0 0-.707 0L5.318 5.975a3.5 3.5 0 0 0-.328 4.571l-1.8 1.8c-.58.58-.62 1.6.121 2.137A8 8 0 1 0 0 8a.5.5 0 0 0 1 0"></path>
                        </svg>
                        <p><%=plugin.getCategory().getName()%></p>
                        <h5><%=plugin.getName()%></h5>
                        <div class="plugin-botoes">
                            <a href="/home/plugin/edit.jsp?plugin=<%=plugin.getName()%>" class="<%=model.getPermission() == 4 || model.getPermission() < 3 ? "disabled" : ""%> btn btn-success">Editar</a>
                            <button class="<%=model.getPermission() == 4 || model.getPermission() < 3 ? "disabled" : ""%> btn btn-danger" onclick="abrirCerteza('deletarpl?plugin=<%=plugin.getName()%>')">Excluir</button>
                            <button onclick="abrirTela('<%=plugin.getName()%>')" class="btn btn-primary">Ver detalhes</button>
                        </div>
                    </div>
                    <div class="change-log">

                        <%
                            for (int i = plugin.getChangelogList().size() - 1; i >= 0; i--) {
                        %>

                        <div class="atualizacao2">
                            <div class="d-flex flex-column ">

                                <h2><strong>Versão <%=plugin.getChangelogList().get(i).getPluginVersion()%></strong></h2>
                                <p style="font-size: 15px"><%=plugin.getChangelogList().get(i).getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) + " ás " + plugin.getChangelogList().get(i).getDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("HH:mm"))%>
                                </p>
                                <ul>
                                    <%
                                        for (String s : plugin.getChangelogList().get(i).getChangelogText().split("\n")) {
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
                <%
                    }
                %>
            </div>


        </div>
    </main>


</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/menu.js"></script>
<script>
    let plsJSON = <%=PluginJson.getAllPluginsJSON()%>;
    let pls = []
    plsJSON.forEach(function (e) {
        pls.push(JSON.parse(e))
    })

    function mostrarPlugins(nome) {


        pls.forEach(function (e) {

            if (!e.nome.toLowerCase().includes(nome.toLowerCase())) $("#" + e.nome).addClass("d-none");
            else $("#" + e.nome).removeClass("d-none");


        })
    }

    $("#pesquisar").on("input", function (event) {
        mostrarPlugins($(this).val());
    })

</script>
<script src="../../js/showplugins.js"></script>
<script src="../js/dashboard.js"></script>
<script src="../js/confirmar.js"></script>

</html>