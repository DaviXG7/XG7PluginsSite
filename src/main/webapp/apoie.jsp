<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.PluginModel" %>
<%@ page import="java.util.List" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %><%--
  Created by IntelliJ IDEA.
  User: davis
  Date: 28/06/2024
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seja apoiador!</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/body.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");

    %>

    <style>
        .caixa-doacao {
            box-shadow: 0 0 10px rgba(0,0,0,.1);
            max-width: 600px;
            width: auto;
            height: auto;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<nav id="nav-principal">
    <div id="nav-c" class="container d-flex justify-content-between">
        <div class="nav-left d-flex justify-content-left align-items-center">
            <a class="navbar-brand" href="index.jsp"><img src="imgs/logo.png" width="100px" alt=""></a>

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
                <a href="" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
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
    <a href="index.jsp#plugins" class="link-dark link-underline link-underline-opacity-0"><i class="bi bi-plug"></i>Plugins</a>
    <a href="" class="link-dark link-underline link-underline-opacity-0"><i class="bi bi-cup-hot"></i>Apioe</a>
    <div class="w-100 pt-2 d-flex justify-content-center  bg-white rounded" id="pesquisa2">
        <button class="btn"><i class="bi bi-search"></i></button>
        <input class="form-control" id="pesquisar2" type="search" placeholder="Buscar plugin..." aria-label="Search">
    </div>
</menu>
<main style="display: flex; align-items: center; justify-content: center">

    <div class="caixa-doacao">
        <img src="imgs/logo.png" alt="" width="200" height="200">

        <h1><strong>Torne-se um apoiador!</strong></h1>

        <p>Com a sua doação, poderemos continuar a melhorar os nossos plugins e, como oferecemos plugin de graça no momento, vai ajudar muito a continuar e melhorá-los.</p>
        <p>Agradeceremos muito a sua doação, isso vai ajudar muito a nossa equipe!</p>
        <p>Entre no discord para receber a <strong>tag apoiador</strong> lá, mostre o comprovante.</p>

        <h3>Faça um pix com o código abaixo</h3>
        <img src="imgs/qrcodepix.png" alt="pix">
        <p>Ou use o email: <a href="mailto:davisonic0102@gmail.com">davisonic0102@gmail.com</a></p>

        <h4>Outros links de doação</h4>
        <p>Entre em contato no <a href="https://discord.gg/JKUgMsF3bH">Discord</a></p>
        <p>Use o paypal no meu <a href="https://ko-fi.com/davixg7">Ko-fi</a></p>

        <small>Veja os termos de doação nos nossos <a href="termos.jsp">Termos de Uso e Política de privacidade</a></small>
        <small>Pela sua humilde doação, entrando em contato no discord talvez você pode ganhar um presente</small>
        <small>Agradecimentos equipe da XG7Plugins</small>
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
