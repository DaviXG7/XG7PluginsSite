<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Termos</title>
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

        </div>
        <div class="nav-right d-flex justify-content-right align-items-center">
            <div class="d-md-flex align-items-center" id="items">

                <a href="index.jsp#plugins" class="linkComum d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-plug"></i>
                    Plugins
                </a>
                <a href="https://discord.gg/GXe8WbZnKa" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
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
                <p id="textocliente" style="align-content: center; display: flex"><%=model == null ? "Área do cliente" : model.getNome()%></p>
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


<main style="padding: 15px; display: flex; align-items: center; justify-content: center">
    <div class="w-75" style="background-color: #eaeaea; padding: 15px; border-radius: 20px">
        <h1><strong>Termos de Serviço da XG7Plugins!</strong></h1>

        <ul>
            <li>Última atualização - 09/06/2024</li>
        </ul>

        Incompleto, iremos fazer ainda. Portanto, não use algum serviço nosso ou entre e contato no discord
    </div>






</main>

<footer class="bg-light rounded p-0 pt-3 d-flex align-items-center justify-content-between flex-column" style="height: 250px">

    <h1><strong>XG7Plugins</strong></h1>
    <p>Os melhores plugins para seu servidor de Minecraft!</p>
    <div class="footer-buttons mb-2 d-flex justify-content-around">
        <a href="https://github.com/DaviXG7"><i class="bi bi-github" style="font-size: 35px; color: black"></i><small>Github</small></a>
        <a href="https://discord.gg/2fACbYbBsf" style="display: flex; flex-direction: column"><i class="bi bi-discord" style="font-size: 35px; color: black"></i><small>Discord</small></a>
        <a href=""><i class="bi bi-book" style="font-size: 35px; color: black"></i><small>API</small></a>
        <a href=""><i class="bi bi-laptop" style="font-size: 35px; color: black"></i> <small>Termos</small></a>
    </div>
    <small><a href="easteregg/jogos.html">Easter egg :D</a></small>
    <h6 class="w-100 d-flex align-items-center justify-content-center" style="background-color: rgb(196, 196, 196); height: 3em;">
        Copyright ₢ XG7Plugins Todos os direitos reservados <br>
    </h6>


</footer>


<script src="js/jQuery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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