<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>XG7Plugins</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/body.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>
</head>

<body>
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
                <img src="<%=model.getImageData()%>" width="70" height="70" alt="img">
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
        <p style="color: white; padding: 50px">
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
            <div class="dropdown">
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
            <div class="plugins-container">

                <div class="plugin-caixa">

                    <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" fill="currentColor" class="bi bi-plugin" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M1 8a7 7 0 1 1 2.898 5.673c-.167-.121-.216-.406-.002-.62l1.8-1.8a3.5 3.5 0 0 0 4.572-.328l1.414-1.415a.5.5 0 0 0 0-.707l-.707-.707 1.559-1.563a.5.5 0 1 0-.708-.706l-1.559 1.562-1.414-1.414 1.56-1.562a.5.5 0 1 0-.707-.706l-1.56 1.56-.707-.706a.5.5 0 0 0-.707 0L5.318 5.975a3.5 3.5 0 0 0-.328 4.571l-1.8 1.8c-.58.58-.62 1.6.121 2.137A8 8 0 1 0 0 8a.5.5 0 0 0 1 0"/>
                    </svg>
                    <p>Categoria</p>
                    <h5>Nome</h5>
                    <p>Preço</p>
                    <div class="plugin-botoes">
                        <button class="btn btn-secondary" >Baixar</button>
                        <button class="btn btn-secondary" >Ver detalhes</button>
                    </div>

                </div>
            </div>
        </div>



    </div>






</main>

<footer class="text-center text-lg-start text-white" style="background-color:#919191">

    <div class="container p-4 pb-0">

        <div class="row">

            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3 ">
                <h6 class="text-uppercase mb-4 font-weight-bold">XG7 Plugins</h6>
                <p> Melhores plugins para seu servidor de Minecraft! </p>
            </div>

            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">


                <a class="btn btn-floating m-1" href="#!" role="button">API para desenvolvedores
                </a>

                <a class="btn btn-floating m-1" href="#!" role="button">Sobre
                </a>

                <a class="btn btn-floating m-1" href="#!" role="button">Discord
                </a>
            </div>

            <div class="text-center p-3">
                Copyright © 2024 XG7Plugins Todos os direitos reservadors
            </div>
            <div class="text-center text-dark p-1">
                Este site não possui nenhum vínculo com MojangAB
            </div>
        </div>
    </div>

</footer>



<script src="js/bootstrap.js"></script>

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