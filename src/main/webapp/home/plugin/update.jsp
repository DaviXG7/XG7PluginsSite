<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.PluginModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Atualizar plugin</title>
    <link rel="stylesheet" href="../../css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/dashboard.css" rel="stylesheet">
    <link href="css/plugin.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="../../imgs/logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>



</head>

<body>
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
            <a class="d-flex link-offset-2 link-light link-underline link-underline-opacity-0" href="/apoie.jsp"><i class="bi bi-cup-hot" style="color: rgba(255,255,255,.5);"></i><p class="textos-botoes" > Apioe</p></a>
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
                    <a class="dropdown-item" href="">Postar atualização</a>
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
            <form class="w-100" enctype="multipart/form-data" method="post" action="">

                <div>
                    <h1><strong>Postar atualização</strong></h1>

                    <h3><strong>Atualização</strong></h3>

                    <div class="form-group">
                        <label for="plugin">Plugin*</label>
                        <select class="form-select" id="plugin" name="plugin" required>
                            <option selected value="0">Selecione o plugin...</option>
                            <%
                                for (PluginModel modelpl : DBManager.getAllPlugins()) {

                            %>

                            <option value="<%=modelpl.getName()%>"><%=modelpl.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="d-none" id="atualizacao">
                        <div class="row">
                            <div class="col-6">
                                <label for="newVersion">Nova versão*</label>
                                <input class="form-control" type="text" placeholder="Digite a nova versão do plugin"
                                       id="newVersion" name="newVersion" required>
                            </div>
                            <div class="col-6">
                                <label for="changelog">Log*</label>
                                <textarea class="form-control" placeholder="Digite o que você mudou no plugin" id="changelog" name="changelog" rows="2" required></textarea>
                            </div>
                        </div>
                        <div style="display: flex" class="w-100 flex-column align-items-center justify-content-center m-3">
                            <label class="btn-upload"><i class="bi bi-upload"></i>
                                <p id="text-plugin">Novo plugin</p>
                                <input id="plugin-file" name="plugin-novo" type="file" class="input-file" required accept=".jar">
                            </label>

                        </div>
                        <label for="editar" class="d-flex">
                            <input id="editar" type="checkbox" name="editar" class="form-check"> Editar Plugin?
                        </label>
                    </div>
                    <div class="d-none" id="edicao">
                        <h3><strong>Editar</strong></h3>
                        <div style="display: flex" class="row justify-content-between cmd">
                            <h4>Comandos:</h4>
                            <div class="col-9" id="comandos"
                                 style="overflow: auto; scroll-behavior: smooth; height: 160px">
                                <div class="mt-3 mb-3 rounded border row p-2 caixacomando"
                                     style="background-color: rgba(0,255,225,0.37)">
                                    <div class="col-sm-6">
                                        <label class="">Comando</label>
                                        <input name="commandName" class="form-control" type="text"
                                               placeholder="Nome do comando (ex.: pular)" required>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Descrição</label>
                                        <input name="commandDescription" class="form-control" type="text"
                                               placeholder="Descrição do comando" required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-3 d-flex align-items-center justify-content-center">
                                <button onclick="adicionar('comandos','caixacomando')" class="btn btn-success"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-plus-circle"></i></button>
                                <button onclick="remover('comandos','caixacomando')" class="btn btn-danger"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-x-circle"></i></button>
                            </div>
                        </div>
                        <div style="display: flex" class="row justify-content-between cmd">
                            <h4>Permissões:</h4>
                            <div class="col-9" id="permissoes"
                                 style="overflow: auto; scroll-behavior: smooth; height: 160px">
                                <div class="mt-3 mb-3 rounded border row p-2 caixapermissao"
                                     style="background-color: rgba(0,255,225,0.37)">
                                    <div class="col-sm-6">
                                        <label class="">Permissão</label>
                                        <input name="permName" class="form-control" type="text"
                                               placeholder="Nome da permissão (ex.: sua.permissao)" required>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="">Descrição</label>
                                        <input name="permDescription" class="form-control" type="text"
                                               placeholder="Descrição da permissão" required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-3 d-flex align-items-center justify-content-center">
                                <button onclick="adicionar('permissoes','caixapermissao')" class="btn btn-success"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-plus-circle"></i></button>
                                <button onclick="remover('permissoes','caixapermissao')" class="btn btn-danger"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-x-circle"></i></button>
                            </div>
                        </div>
                        <div style="display: flex" class="row justify-content-between cmd">
                            <h4>Recursos:</h4>
                            <div class="col-9" id="recursos"
                                 style="overflow: auto; scroll-behavior: smooth; height: 160px">
                                <div class="mt-3 mb-3 rounded border row p-2 caixarecurso"
                                     style="background-color: rgba(0,255,225,0.37)">
                                    <div class="col-sm-12">
                                        <label class="">Recurso</label>
                                        <input name="resource" class="form-control" type="text"
                                               placeholder="Recurso (Uma das coisas que o plugin faz)" required>
                                    </div>
                                </div>
                            </div>
                            <div class="col-3 d-flex align-items-center justify-content-center">
                                <button onclick="adicionar('recursos','caixarecurso')" class="btn btn-success"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-plus-circle"></i></button>
                                <button onclick="remover('recursos','caixarecurso')" class="btn btn-danger"
                                        style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                        class="bi bi-x-circle"></i></button>
                            </div>
                        </div>
                        <h5><strong>Insira imagens do plugin</strong></h5>
                        <div class="imgs" id="imgs">
                            <div id="0" style="display: flex" class="w-100 flex-column align-items-center justify-content-center caixa-imagem">
                                <label class="btn-upload"><i class="bi bi-upload"></i>
                                    <p>Adicionar imagem</p>
                                    <input name="img0" type="file" class="input-file" accept="image/*">
                                </label>

                            </div>
                        </div>
                        <div class="w-100 mt-3 d-flex align-items-center justify-content-center">
                            <button onclick="adicionarImagem()" class="btn btn-success"
                                    style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                    class="bi bi-plus-circle"></i></button>
                            <button onclick="removerImagem()" class="btn btn-danger"
                                    style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                    class="bi bi-x-circle"></i></button>
                        </div>
                    </div>
                </div>

                <input type="submit" class="btn btn-primary w-25" value="Postar">

            </form>
        </div>
    </main>


</body>

<script src="../js/menu.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    let plsJSON = <%=PluginJson.getAllPluginsJSON()%>;
    let pls = []
    plsJSON.forEach(function (e) {
        pls.push(JSON.parse(e))
    })
</script>
<script src="js/update.js">
</script>
<script src="js/createpl.js"></script>
<script>
    function removerComando(id) {

        let div = $("#" + id);
        let elementos = div.children();

        let startIndex = Math.max(elementos.length - 3, 0);
        elementos.slice(startIndex).remove();
    }

</script>
<script src="../js/dashboard.js"></script>
<script>
    $("#plugin-file").on("change", function () {
        document.getElementById("text-plugin").textContent = document.getElementById("plugin-file").files[0].name
    })
</script>
</html>