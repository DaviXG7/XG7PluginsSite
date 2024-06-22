<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Clientes</title>
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="../css/confirmar.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../../imgs/logo.png" />


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
        List<UserModel> allUsers = null;

        try {
            allUsers = DBManager.allUsers();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    %>



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
            <input style="height: 40px" class="form-control" id="pesquisar" type="search" placeholder="Buscar cliente..." aria-label="Search">
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
            <div class="tabela">
                <table class="table table-md ">
                    <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Avatar</th>
                        <th scope="col">Nome</th>
                        <th scope="col">Email</th>
                        <th scope="col">Nível perm</th>
                        <th scope="col">Ações</th>
                    </tr>
                    </thead>
                    <tbody id="tabela">
                    <% for (UserModel item : allUsers) { %>
                    <tr id="<%=item.getNome() + allUsers.indexOf(item)%>">
                        <th scope="row"><%=item.getId().toString()%></th>
                        <td><img src="<%=item.getImageData() != null ? item.getImageData() : ""%>" alt="N/A" width="50" height="auto"></td>
                        <td><%=item.getNome()%></td>
                        <td><%=item.getEmail()%></td>
                        <td><%=item.getPermission()%></td>
                        <td>
                            <a href="../user/user.jsp?uuid=<%=item.getId().toString()%>" class="<%=model.getPermission() < item.getPermission() || model.getPermission() == 3 ? "disabled" : ""%> btn btn-primary">Editar</a>
                            <button class="<%=model.getPermission() < item.getPermission() || model.getPermission() == 3 ? "disabled" : ""%> btn btn-danger" onclick="abrirCerteza('/home/admin/excluirusuario?uuid=<%=item.getId()%>')">Excluir</button>
                        </td>

                    </tr>
                    <% } %>
                    </tbody>
                </table>

            </div>

        </div>

</main>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
    function mostrarPessoas(nome) {


        document.getElementById("tabela").querySelectorAll("*").forEach(function (e) {

            if (!e.id.toLowerCase().includes(nome.toLowerCase())) $("#" + e.id).addClass("d-none");
            else $("#" + e.id).removeClass("d-none");


        })
    }

    $("#pesquisar").on("input", function (event) {
        mostrarPessoas($(this).val());
    })

</script>

<script src="../../js/menu.js"></script>
<script src="/home/js/dashboard.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/confirmar.js"></script>

</html>