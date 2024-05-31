<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="../css/user.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../imgs/logo.png" />


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
        if (model == null) response.sendRedirect("../webapp/login.jsp");
        UserModel userModel = null;
        try {
            userModel = DBManager.getUserById((String) request.getParameter("uuid"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (userModel == null) throw new RemoteException("User nor found");
        if (model.getPermission() < 5 && !userModel.getId().equals(model.getId())) {
            throw new RemoteException("You don't have permission");
        }


    %>

    <title>Usuário: <%=userModel.getNome()%></title>



</head>

<body>
<div class="wrapper">
    <div id="barra-lateral" class="barra-lateral sidebar">


        <a href="../../index.jsp">
            <img src="../../imgs/logo.png" width="135" alt="">
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
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="../admin/clientes.jsp?page=1"><i style="color: rgba(255,255,255,.5);" class="bi bi-people"></i> <p class="textos-botoes" > Clientes</p></a>
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
                        <a class="dropdown-item" href="../plugin/create.jsp">Criar Plugin</a>
                        <a class="dropdown-item" href="../plugin/update.jsp">Postar atualização</a>
                    </ul>
                </div>
                <%
                    }
                %>

                <div class="dropdown">
                    <button style="border: none; background-color: white" type="button" data-bs-toggle="dropdown">
                        <img src="<%=model.getImageData() == null ? "alt.png" : model.getImageData()%>" width="60" style="border: solid black 1px; border-radius: 100%" alt="">
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
        <form class="configs usuario" id="usuario" method="post" action="<%="editarusuario?uuid=" + model.getId().toString()%>">
            <h4>Configurações</h4>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Nome: </label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="nome" placeholder="Novo nome" value="<%=userModel.getNome()%>">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Email: </label>
                <div class="col-sm-10">
                    <p class="disabled form-control-plaintext"><%=userModel.getEmail()%></p>
                </div>
            </div>
            <% if (model.getPermission() < 5 || userModel.getId().equals(model.getId())) { %>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Senha*: </label>
                <div class="col-sm-10">
                    <input type="password" id="senha" class="form-control" placeholder="Senha" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Nova senha: </label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="novasenha" placeholder="Nova senha">
                    <small class="form-text text-muted"><i id="caractere" style="color: red" class="bi bi-exclamation-circle"></i> Pelo menos 8 caracteres</small> <br>
                    <small class="form-text text-muted"><i id="caixaalta" style="color: red" class="bi bi-exclamation-circle"></i> Pelo menos 1 letra maiúscula</small> <br>
                </div>
            </div>
            <%}%>

            <input id="cadsubmit" type="submit" class="btn btn-primary" value="Atualizar">
            <p id="erro" style="font-size: 11px; color: red"><%=request.getAttribute("errormsg") != null ? request.getAttribute("errormsg") : ""%></p>
        </form>
        <form enctype="multipart/form-data" class="configs imagem" method="post" action=<%="editarimagem?uuid=" + userModel.getId().toString()%>>
            <h4>Alterar imagem</h4>
            <img alt="Você não tem uma imagem" src="<%=userModel.getImageData()%>" width="100" height="100">
            <p>Imagem atual</p>

            <div class="form-group">
                <label for="exampleFormControlFile1">Enviar imagem</label>
                <input type="file" class="form-control-file" name="imagem" id="exampleFormControlFile1" required accept="image/*">
            </div>

            <input type="submit" class="btn btn-primary" value="Enviar"></input>
        </form>

        <%
            if (model.getPermission() >= 5) {
        %>

        <form class="configs usuario" id="permissao" action="<%="editarpermissao?uuid=" + model.getId().toString()%>" method="post">
            <h4>Permissão</h4>

            <div class="form-group row">
                <label for="exampleFormControlSelect2">Escolha a permissão</label>
                <select class="form-control" name="permissions" id="exampleFormControlSelect2">
                    <option value="0">Selecione uma permissão...</option>
                    <option value="6">CEO</option>
                    <option value="5">Administrador</option>
                    <option value="4">Editor site</option>
                    <option value="3">Editor plugin</option>
                    <option value="2">Auxiliar</option>
                    <option value="1">Cliente</option>
                </select>
                <div class="col">
                    Nível de permissão atual: <%=userModel.getPermission()%>
                </div>
            </div>

            <input type="submit" class="btn btn-primary" value="Atualizar"></input>
            <p id="erroPermissao" style="font-size: 11px; color: red"></p>

        </form>
        <%
            }
        %>

    </div>


</main>
</div>


</body>

<script src="../../js/menu.js"></script>
<script src="../../js/bootstrap.js"></script>
<script src="../../js/user.js"></script>
<script src="../../js/dashboard.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $('#usuario').submit(function (event) {
        let txtnome = $('#nome').val();
        if (txtnome === "" && txtnovaSenha === "") {
            let erro = document.getElementById("erro");
            erro.textContent = "Você precisa preencher pelo menos um dos campos não obrigatórios!"
            event.preventDefault();
        }
    })
</script>

</html>