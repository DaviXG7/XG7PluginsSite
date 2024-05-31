<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Atualizar plugin</title>
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../imgs/logo.png" />


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>



</head>

<body>
<div class="wrapper">
    <div id="barra-lateral" class="barra-lateral sidebar">


        <a href="../index.jsp">
            <img src="../imgs/logo.png" width="135" alt="">
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
                <a class="d-flex link-offset-2 link-dark link-underline link-underline-opacity-0" href="admin/clientes.jsp?page=1"><i style="color: rgba(255,255,255,.5);" class="bi bi-people"></i> <p class="textos-botoes" > Clientes</p></a>
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
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="pluginDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="bi bi-plus" style="font-size: 30px; padding: 0 10px 0 10px"></i>
                    </button>
                    <div class="dropdown-menu" aria-labelledby="pluginDropdown">
                        <a class="dropdown-item" href="create.jsp">Criar Plugin</a>
                        <a class="dropdown-item" href="">Postar atualização</a>
                    </div>
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
                        <a href=<%="../user/user.jsp?uuid=" + model.getId().toString()%> class="dropdown-item">
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
            <form enctype="multipart/form-data" method="post" action="criarplugin">
                <input type="file" accept=".zip" id="config" name="configs">
                <br>
                <input type="text" id="nomePlugin" name="name" placeholder="Edite o nome do plugin" required>
                <br>
                <select required id="categoria" name="categoria">
                    <option value="0">Editar categoria</option>
                    <option value="1">Gestão</option>
                    <option value="2">Utilidades</option>
                    <option value="3">Minigames</option>
                </select>
                <br>
                <input type="url" placeholder="Digite a url do vídeo" id="urlVideo" name="urlVideo">
                <br>
                <input type="number" placeholder="Digite o preço do plugin" id="preco" name="preco" required>
                <br>
                <input type="url" placeholder="Digite o github do plugin" id="urlGithub" name="github">
                <br>
                <input type="text" placeholder="Digite as versões do plugin" id="versoes" name="versions" required>
                <br>
                <input type="text" placeholder="Digite as dependências do plugin" id="dependencias" name="dependencies">
                <br>
                <div>
                    <button onclick="adicionarComando('comandos','nome do comando','commandValue','commandDescription',true)" type="button">Adicionar +</button>
                    <button onclick="removerComando('comandos')" type="button">Remover -</button> <br>
                    <div id="comandos" style="overflow: auto; scroll-behavior: smooth; height: 100px">
                        <input type="text" placeholder="nome do comando" name="commandValue" required > <input type="text" placeholder="descrição" name="commandDescription" required> <br>
                    </div>
                </div>
                <br>
                <div>
                    <button onclick="adicionarComando('perm','nome da perm','permValue','permDescription', true)" type="button">Adicionar +</button>
                    <button onclick="removerComando('perm')" type="button">Remover -</button> <br>
                    <div id="perm" style="overflow: auto; scroll-behavior: smooth; height: 100px">
                        <input type="text" placeholder="nome da perm" name="permValue" required> <input type="text" placeholder="descrição" name="permDescription" required> <br>

                    </div>
                </div>
                <br>
                <div>
                    <button onclick="adicionarComando('recursos','recurso','resourceValue','',false)" type="button">Adicionar +</button>
                    <button onclick="removerComando('recursos')" type="button">Remover -</button> <br>
                    <div id="recursos" style="overflow: auto; scroll-behavior: smooth; height: 100px">
                        <input type="text" placeholder="recurso" name="resourceValue" required> <p></p><br>
                    </div>
                </div>
                <br>
                <input type="submit" class="btn btn-primary" value="Atualizar"></input>

            </form>
        </div>
    </main>
</div>


</body>

<script src="../js/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    function adicionarComando(id, placeholder, nome, nome2, aparecer) {


        $('#' + id).append("<input type=\"text\" placeholder=\"" + placeholder +"\" name=" + nome + " required>").append(aparecer ? "<input type=\"text\" placeholder=\"descrição\" name="+ nome2 +" required>" : "").append("<br>")
    }
    function removerComando(id) {

        let div = $("#" + id);
        let elementos = div.children();

        let startIndex = Math.max(elementos.length - 3, 0);
        elementos.slice(startIndex).remove();
    }

</script>
<script src="../../js/dashboard.js"></script>

</html>