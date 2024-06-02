<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>XG7Plugins</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/body.css" rel="stylesheet">
    <link href="css/detalhes.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
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
<nav>
    <div id="nav-c" class="container d-flex justify-content-between">
        <div class="nav-left d-flex justify-content-left align-items-center">
            <a class="navbar-brand" href=""><img src="imgs/logo.png" width="100px" alt=""></a>

            <form id="pesquisa" class="d-md-flex bg-white rounded">
                <a class="btn"><i class="bi bi-search"></i></a>
                <input class="form-control" type="search" placeholder="Buscar plugin..." aria-label="Search">
            </form>
        </div>
        <div class="nav-right d-flex justify-content-right align-items-center">
            <div class="d-md-flex align-items-center" id="items">

                <a href="#plugins" class="linkComum d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-plug"></i>
                    Plugins
                </a>
                <a href="" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-discord"></i>
                    Discord
                </a>

                <button id="hamburger" class="btn" onclick="toggleMenu()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
                    </svg>
                </button>

            </div>

            <a href="login.jsp" class="btn btn-primary d-md-flex justify-content-center align-items-center" style="margin-left: 15px">
                <%
                    if (model == null || model.getImageData() == null) {
                %>
                <i class="bi bi-person"></i>
                <%
                    } else {
                %>
                <img src="<%=model.getImageData()%>" width="50" height="50" style="border-radius: 20px" alt="img">
                <%
                    }
                %>
                <p id="textocliente"><%=model == null ? "Área do cliente" : model.getNome()%></p>
            </a>
        </div>




    </div>




</nav>
<menu id="menu">

    <div class="d-flex flex-column" style="padding: 0 10px 0 10px" id="itemsMenu">

        <a href="#plugins" class="menu-items d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
            <i class="bi bi-plug"></i>
            Plugins
        </a>
        <a href="" class="menu-items d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
            <i class="bi bi-discord"></i>
            Discord
        </a>

    </div>

</menu>


<main style="padding: 15px;">

    <div class="banner d-flex justify-content-center container">
                    <p style="font-size: 25px; color: white; padding: 50px">
                        Deixe seu servidor mais profissional com os melhores plugins do Brasil!
                    </p>
                    <a href="#plugins" class="btn btn-outline-light">
                        Conheça agora os melhores plugins!
                    </a>
                    <a href="" class="btn btn-outline-light" >
                        Quem somos?
                    </a>
            </div>

    <div class="mt-5">

        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <i class="bi bi-archive-fill"></i>
                <h3 class="m-3">Plugins</h3>
            </div>
            <div class="dropdown" style="position: static !important;">
                <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-bar-chart-fill"></i> Mais recentes
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="?sort=maisRecentes">Mais recentes</a></li>
                    <li><a class="dropdown-item" href="?sort=maisPopulares">Mais populares</a></li>
                </ul>
            </div>
        </div>

        <div id="plugins" class="plugins">
                        <div class="categoria">
                            <h4>Selecione a categoria</h4>
                            <a class="link link-dark link-underline-opacity-0" href=""><i class="bi bi-hash"></i> Gestão</a>
                            <a class="link link-dark link-underline-opacity-0" href=""><i class="bi bi-hash"></i> Minigames</a>
                            <a class="link link-dark link-underline-opacity-0" href=""><i class="bi bi-hash"></i> Utilidades</a>
                        </div>
                        <div class="plugins-container" id="plugins-caixas">


                        </div>
                    </div>



    </div>






</main>

<footer class="bg-light rounded pt-3 d-flex align-items-center justify-content-between flex-column" style="height: 250px">

    <h1><strong>XG7Plugins</strong></h1>
    <p>Os melhores plugins para seu servidor de Minecraft!</p>
    <div class="footer-buttons mb-2 w-25 d-flex justify-content-around">
        <a href="https://github.com/DaviXG7"><i class="bi bi-github" style="font-size: 40px; color: black"></i></a>
        <a href="https://discord.gg/2fACbYbBsf"><i class="bi bi-discord" style="font-size: 40px; color: black"></i></a>
    </div> 
    <h6 class="w-100 d-flex align-items-center justify-content-center" style="background-color: rgb(196, 196, 196); height: 3em;">
        Copyright ₢ XG7Plugins Todos os direitos reservados
    </h6>
</div>


</footer>


<script src="js/jQuery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let plsJSON = <%=PluginJson.getAllPluginsJSON()%>;
    let pls = []
    plsJSON.forEach(function (e) {
        pls.push(JSON.parse(e))
    })

</script>
<script src="js/showplugins.js"></script>

<script>

    function toggleMenu() {
        let menu = document.getElementById("menu");
        if (menu.style.display === "none" || menu.style.display === "") {
            menu.style.display = "inline";
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