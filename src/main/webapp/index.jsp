<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.PluginModel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Comparator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>XG7Plugins</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/body.css" rel="stylesheet">
    <link href="css/detalhes.css" rel="stylesheet">
    <link href="css/buttonsair.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />
    <style>
        .pesquisa {
            height: 50px;
            display: flex !important;
            align-items: center;
        }
    </style>

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");

        List<PluginModel> plugins;

        try {
            plugins = DBManager.getAllPlugins();

            String sort = request.getParameter("sort");

            if (sort != null) {
                if (sort.equals("maisRecentes")) plugins.sort((o1, o2) -> o2.getChangelogList().getLast().getDate().compareTo(o1.getChangelogList().getLast().getDate()));
                if (sort.equals("maisPopulares")) plugins.sort((o1, o2) -> Math.max(o2.getDownloads().size(), o1.getDownloads().size()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    %>
</head>

<body>
<div class="detalhes-plugin d-none" id="detalhes">
        <button id="sair" class="btn bg-white position-absolute">
            <i class="bi bi-x-circle bg-white"></i>
        </button>
        <div class="caixa-detalhe" id="caixaDetalhe">
            <div class="detalhes-header">
                <div class="d-flex w-auto">
                    <img src="imgs/logo.png" width="100" height="100" alt="">
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
<nav id="nav-principal">
    <div id="nav-c" class="container d-flex justify-content-between">
        <div class="nav-left d-flex justify-content-left align-items-center">
            <a class="navbar-brand" href=""><img src="imgs/logo.png" width="100px" alt=""></a>

            <div class="d-md-flex bg-white rounded" id="pesquisa">
                <a class="btn"><i class="bi bi-search"></i></a>
                <input class="form-control" id="pesquisar" type="search" placeholder="Buscar plugin..." aria-label="Search">
            </div>
        </div>
        <div class="nav-right d-flex justify-content-right align-items-center">
            <div class="d-md-flex align-items-center" id="items">

                <a href="#plugins" class="linkComum d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-plug"></i>
                    Plugins
                </a>
                <a href="https://discord.gg/GXe8WbZnKa" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-discord"></i>
                    Discord
                </a>
                <a href="apoie.jsp" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-cup-hot"></i>
                    Apoie
                </a>

                <button id="hamburger" class="btn" onclick="toggleMenu()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
                    </svg>
                </button>

            </div>

            <a href="login.jsp" class="btn btn-primary d-flex justify-content-center align-items-center" style="margin-left: 15px">
                <%
                    if (model == null || model.getImageData() == null) {
                %>
                <i class="bi bi-person"></i>
                <%
                    } else {
                %>
                <img src="<%=model.getImageData()%>" width="30" height="30" style="border-radius: 20px" alt="img">
                <%
                    }
                %>
                <%=model == null ? "Fazer login" : model.getNome()%>
            </a>
        </div>




    </div>




</nav>
<menu id="menu">
    <a href="https://discord.gg/JKUgMsF3bH" class="link-dark link-underline link-underline-opacity-0"><i class="bi bi-discord"></i>Discord</a>
    <a href="#plugins" class="link-dark link-underline link-underline-opacity-0"><i class="bi bi-plug"></i>Plugins</a>
    <a href="apoie.jsp" class="link-dark link-underline link-underline-opacity-0"><i class="bi bi-cup-hot"></i>Apioe</a>
    <div class="w-100 pt-2 d-flex justify-content-center  bg-white rounded" id="pesquisa2">
        <button class="btn"><i class="bi bi-search"></i></button>
        <input class="form-control" id="pesquisar2" type="search" placeholder="Buscar plugin..." aria-label="Search">
    </div>
</menu>


<main>

    <div class="banner d-flex justify-content-center container"></div>

    <div class="mt-5">

        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="bi bi-archive-fill"></i>
                <h3 class="m-3">Plugins</h3>
            </div>
            <div class="dropdown" style="position: static !important;">
                <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-bar-chart-fill"></i> <%=request.getParameter("sort") == null ? "Filtrar" : request.getParameter("sort").equals("maisRecentes") ? "Mais recentes" : request.getParameter("sort").equals("maisPopulares") ? "Mais populares" : "Filtrar"%>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="?sort=maisRecentes#plugins">Mais recentes</a></li>
                    <li><a class="dropdown-item" href="?sort=maisPopulares#plugins">Mais populares</a></li>
                </ul>
            </div>
        </div>

        <div id="plugins" class="plugins">
                        <div class="categoria">
                            <h4>Selecione a categoria</h4>
                            <a href="#plugins" onclick="mostrarPlugins(document.getElementById('pesquisar').value, '')" class="link link-dark link-underline-opacity-0" ><i class="bi bi-hash"></i> Todos</a>
                            <a href="#plugins" onclick="mostrarPlugins(document.getElementById('pesquisar').value, 'Gestão')" class="link link-dark link-underline-opacity-0" ><i class="bi bi-hash"></i> Gestão</a>
                            <a href="#plugins" onclick="mostrarPlugins(document.getElementById('pesquisar').value, 'Minigames')" class="link link-dark link-underline-opacity-0" ><i class="bi bi-hash"></i> Minigames</a>
                            <a href="#plugins" onclick="mostrarPlugins(document.getElementById('pesquisar').value, 'Utilidades')" class="link link-dark link-underline-opacity-0"><i class="bi bi-hash"></i> Utilidades</a>
                            <a href="#plugins" onclick="mostrarPlugins(document.getElementById('pesquisar').value, 'Dependencias')" class="link link-dark link-underline-opacity-0"><i class="bi bi-hash"></i> Dependencias</a>
                        </div>
                        <div class="plugins-container" id="plugins-caixas">

                            <%
                                for (PluginModel pluginModel : plugins) {
                            %>

                            <div class="plugin-caixa">
                            <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-plugin" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M1 8a7 7 0 1 1 2.898 5.673c-.167-.121-.216-.406-.002-.62l1.8-1.8a3.5 3.5 0 0 0 4.572-.328l1.414-1.415a.5.5 0 0 0 0-.707l-.707-.707 1.559-1.563a.5.5 0 1 0-.708-.706l-1.559 1.562-1.414-1.414 1.56-1.562a.5.5 0 1 0-.707-.706l-1.56 1.56-.707-.706a.5.5 0 0 0-.707 0L5.318 5.975a3.5 3.5 0 0 0-.328 4.571l-1.8 1.8c-.58.58-.62 1.6.121 2.137A8 8 0 1 0 0 8a.5.5 0 0 0 1 0"/>
                            </svg>
                            <p><%=pluginModel.getCategory().getName()%></p>
                            <h5><%=pluginModel.getName()%></h5>
                            <p><%=pluginModel.getPrice() == 0 ? "Grátis" : "Comprar R$" + pluginModel.getPrice()%></p>
                            <div class="plugin-botoes">
                                <a href="<%=pluginModel.getPrice() == 0 ? "/download?plugin=" + pluginModel.getName() + "&type=" + "plugin": ""%>" class="btn btn-primary"><%=pluginModel.getPrice() == 0 ? "Baixar" : "Comprar R$" + pluginModel.getPrice()%></a>
                                <button onclick="abrirTela('<%=pluginModel.getName()%>')" class="btn btn-primary">Ver detalhes</button>
                                </div>
                            </div>

                            <%
                                }
                            %>


                        </div>
                    </div>



    </div>






</main>

<footer class="bg-light rounded p-0 pt-3 d-flex align-items-center justify-content-between flex-column" style="height: 250px">

    <h1><strong>XG7Plugins</strong></h1>
    <p style="text-align: center">Os melhores plugins para seu servidor de Minecraft!</p>
    <div class="footer-buttons mb-2 d-flex justify-content-around">
        <a href="https://github.com/DaviXG7"><i class="bi bi-github" style="font-size: 35px; color: black"></i><small>Github</small></a>
        <a href="https://discord.gg/2fACbYbBsf" style="display: flex; flex-direction: column"><i class="bi bi-discord" style="font-size: 35px; color: black"></i><small>Discord</small></a>
        <a href=""><i class="bi bi-book" style="font-size: 35px; color: black"></i><small>API</small></a>
        <a href="termos.jsp"><i class="bi bi-laptop" style="font-size: 35px; color: black"></i> <small>Termos</small></a>
    </div>
    <small><a href="easteregg/jogos.html">Easter egg :D</a></small>
    <h6 class="w-100 d-flex align-items-center justify-content-center" style="background-color: rgb(196, 196, 196); height: 3em; text-align: center">
        Copyright © XG7Plugins Todos os direitos reservados <br>
    </h6>


</footer>


<script src="js/jQuery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let plsJSON = <%=PluginJson.getAllPluginsJSON()%>;
    let pls = []
    plsJSON.forEach(function (e) {
        pls.push(JSON.parse(e))
    })

    $("#pesquisar").on("input", function () {
        mostrarPlugins($(this).val(), "")
    })
    $("#pesquisar2").on("input", function () {
        mostrarPlugins($(this).val(), "")
    })

    function mostrarPlugins(nome,categoria) {
        $("#plugins-caixas").children().remove()



        pls.forEach(function (e) {

            if (e.nome.toLowerCase().includes(nome.toLowerCase()) && e.categoria.toUpperCase().includes(categoria.toUpperCase())) {

                const c1 = e.preco === 0 ? "Grátis" : "R$" + e.preco;
                const c2 = e.preco === 0 ? "Baixar" : "Comprar R$" + e.preco;
                const link = e.preco === 0 ? "/download?plugin=" + e.nome + "&type=" + "plugin" : "";
                const html =
                    '<div class="plugin-caixa">' +
                    '<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-plugin" viewBox="0 0 16 16">' +
                    '<path fill-rule="evenodd" d="M1 8a7 7 0 1 1 2.898 5.673c-.167-.121-.216-.406-.002-.62l1.8-1.8a3.5 3.5 0 0 0 4.572-.328l1.414-1.415a.5.5 0 0 0 0-.707l-.707-.707 1.559-1.563a.5.5 0 1 0-.708-.706l-1.559 1.562-1.414-1.414 1.56-1.562a.5.5 0 1 0-.707-.706l-1.56 1.56-.707-.706a.5.5 0 0 0-.707 0L5.318 5.975a3.5 3.5 0 0 0-.328 4.571l-1.8 1.8c-.58.58-.62 1.6.121 2.137A8 8 0 1 0 0 8a.5.5 0 0 0 1 0"/>' +
                    '</svg>' +
                    '</svg>' +
                    '<p>' + e.categoria + '</p>' +
                    '<h5>' + e.nome + '</h5>' +
                    '<p>' + c1 + '</p>' +
                    '<div class="plugin-botoes">' +
                    '<a href="' + link + '" class="btn btn-primary">' + c2 + '</a>' +
                    '<button onclick="abrirTela(\'' + e.nome + '\')" class="btn btn-primary">Ver detalhes</button>' +
                    '</div>' +
                    '</div>'
                $("#plugins-caixas").append(html)
            }
        })
    }


</script>
<script src="js/showplugins.js"></script>

<script>

    function toggleMenu() {
        let menu = document.getElementById("menu");
        if (menu.style.display === "none" || menu.style.display === "") {
            menu.style.display = "flex";
        } else {
            menu.style.display = "none";
        }
    }

    function getTamanhoDaTela() {
        var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

        if (largura > 700) {
            document.getElementById("menu").style.display = "none";
        }
    }
    window.addEventListener("resize", getTamanhoDaTela);

</script>





</body>

</html>