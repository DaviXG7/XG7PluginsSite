<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>XG7Plugins</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../imgs/logo.png" />


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>



</head>

<body>
<div id="barra-lateral" class="barra-lateral sidebar">


    <a>
        <img src="../imgs/logo.png" width="135" alt="">
    </a>

    <hr>

    <!-- Heading -->
    <div class="menus">
        <div class="sidebar-heading side-title">
            INTERFACE
        </div>
        <div class="botoes">
            <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href=""><i style="color: rgba(255,255,255,.5);" class="bi bi-telephone"></i><p class="textos-botoes"> Suporte</p></a>
            <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href=""><i style="color: rgba(255,255,255,.5);" class="bi bi-cash"></i><p class="textos-botoes" > Doação</p></a>
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
            <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href=""><i style="color: rgba(255,255,255,.5);" class="bi bi-people"></i> <p class="textos-botoes" > Clientes</p></a>
            <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="../index.html"><i style="color: rgba(255,255,255,.5);" class="bi bi-plug"></i> <p class="textos-botoes" > Plugins</p></a>
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
            <a>
                <i class="bi bi-plus" style="font-size: 30px; padding: 0 10px 0 10px"></i>
            </a>
            <a>
                <i class="bi bi-box-arrow-left" style="font-size: 30px; padding: 0 10px 0 10px"></i>
            </a>

            <div class="dropdown">
                <button style="border: none; background-color: white" type="button" data-bs-toggle="dropdown">
                    <img src="../imgs/logo.png" width="80" alt="">
                </button>
                <ul class="dropdown-menu">
                    <a class="dropdown-item" href="#">
                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                        Perfil
                    </a>
                    <a class="dropdown-item" href="#">
                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                        Configurações
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Logout
                    </a>
                </ul>
            </div>
        </div>
    </header>

    <div class="pag">
        <form class ="configs usuario" method="post" action="editarusuario">
            <h4>Configurações</h4>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Nome: </label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" placeholder="Novo nome" value="DaviXG7">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Email: </label>
                <div class="col-sm-10">
                    <input type="text" readonly class="form-control-plaintext" value="email@example.com">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Senha*: </label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" placeholder="Senha">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Nova senha: </label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" placeholder="Nova senha">
                </div>
            </div>

            <input type="submit" class="btn btn-primary" value="Atualizar"></input>
        </form>
        <form class ="configs imagem" method="post" action="editarimagem">
            <h4>Alterar imagem</h4>
            <img src=<%=model.getAvatarPath()%>>
            <p>Imagem atual</p>

            <div class="form-group">
                <label for="exampleFormControlFile1">Enviar imagem</label>
                <input type="file" class="form-control-file" id="exampleFormControlFile1">
            </div>

            <input type="submit" class="btn btn-primary" value="Enviar"></input>
        </form>

        <%
            if (model.getPermission() >= 8) {
        %>

        <form class ="configs usuario" method="post" action="editarpermissao">
            <h4>Permissão</h4>

            <div class="form-group row">
                <label for="exampleFormControlSelect2">Escolha a permissão</label>
                <select multiple class="form-control" id="exampleFormControlSelect2">
                    <option>CEO</option>
                    <option>Administrador</option>
                    <option>Editor site</option>
                    <option>Editor plugin</option>
                    <option>Auxiliar</option>
                    <option>Cliente</option>
                </select>
                <div class="col">
                    Permissão atual:
                </div>
            </div>

            <input type="submit" class="btn btn-primary" value="Atualizar"></input>
        </form>
        <%
            }
        %>

    </div>


</main>


</body>

<script src="js/menu.js"></script>
<script>
    function getTamanhoDaTela() {
        var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

        if (largura > 700) {
            document.getElementById("barra-lateral").style.display = "flex";
        }
    }
    window.addEventListener("resize", getTamanhoDaTela);
</script>

</html>