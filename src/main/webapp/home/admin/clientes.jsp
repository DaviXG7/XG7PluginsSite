<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
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
    <link href="../css/confirmar.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../imgs/logo.png" />


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
        List<UserModel> allUsers = null;

        try {
            allUsers = DBManager.allUsers();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        int paginaAtual = Integer.parseInt(request.getParameter("page"));

        int indiceInicial = (paginaAtual - 1) * 15;
        int indiceFinal = Math.min(indiceInicial + 15, allUsers.size());

        List<UserModel> itensPagina = allUsers.subList(indiceInicial, indiceFinal);

    %>



</head>

<body>
<div class="confirmar" id="confirmar">
    <div class="d-flex flex-column justify-content-around bg-white rounded align-items-center" style="width: 300px; height: 250px;">
        <h2>Tem certeza que quer exluir este usuário???</h2>
        <div class="d-flex">
            <button class="btn btn-primary" onclick="confirmar()">Sim</button>
            <button class="btn btn-primary" onclick="toggleMenu('confirmar', 'none', 'flex')">Não</button>

        </div>

    </div>
</div>
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
                <a>
                    <i class="bi bi-plus" style="font-size: 30px; padding: 0 10px 0 10px"></i>
                </a>
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


    <div class="tabela">
        <table class="table table-md ">
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Avatar</th>
                <th scope="col">Nome</th>
                <th scope="col">Email</th>
                <th scope="col">Senha</th>
                <th scope="col">Nível perm</th>
                <th scope="col">Ações</th>
            </tr>
            </thead>
            <tbody>
            <% for (UserModel item : itensPagina) { %>
            <tr>
                <th scope="row"><%=item.getId().toString()%></th>
                <td><img src="<%=item.getImageData() != null ? item.getImageData() : ""%>" alt="N/A" width="50" height="auto"></td>
                <td><%=item.getNome()%></td>
                <td><%=item.getEmail()%></td>
                <td><%=item.getSenha()%></td>
                <td><%=item.getPermission()%></td>
                <td>
                    <a href="../user/user.jsp?uuid=<%=item.getId().toString()%>" class="<%=model.getPermission() < 5 ? "disabled" : ""%> btn btn-primary">Editar</a>
                    <button class="<%=model.getPermission() < 5 ? "disabled" : ""%> btn btn-primary" onclick="solicitar('confirmar','none','flex','<%=item.getId().toString()%>')">Excluir</button>
                </td>

            </tr>
            <% } %>
            </tbody>
        </table>

    </div>
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-end">
            <li class="page-item <%=paginaAtual > 1 ? "" : "disabled"%>">
                <a class="page-link" href="?page=<%= paginaAtual - 1 %>" tabindex="-1">Anterior</a>
            </li>
            <%
                for (int i = Math.max(1, paginaAtual - 1); i <= Math.max(allUsers.size() / 15, paginaAtual / 15 + 3); i++) {
            %>
            <li class="page-item"><a class="page-link" href="?page=<%= i %>"><%=i%></a></li>
            <%
                }
            %>
            <li class="page-item <%=paginaAtual > 1 ? "" : "disabled"%>">
                <a class="page-link" href="?page=<%= paginaAtual + 1 %>">Próxima</a>
            </li>
        </ul>
    </nav>

</main>
</div>

</body>

<script src="../../js/menu.js"></script>
<script>
    let itemAtual = "";
    function cancelar() {
        itemAtual = "";
    }
    function solicitar(id,toggle1,toggle2,item) {

        toggleMenu(id,toggle1,toggle2);
        itemAtual = item;

    }

    function confirmar() {
        window.location.href = "excluirusuario?uuid=" + itemAtual;
    }

    function getTamanhoDaTela() {
        var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

        if (largura > 700) {
            document.getElementById("barra-lateral").style.display = "flex";
        }
    }
    window.addEventListener("resize", getTamanhoDaTela);
</script>

</html>