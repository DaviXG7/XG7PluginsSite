<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.models.extras.Categoria" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Criar Plugin</title>
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
                    <a class="dropdown-item" href="">Criar Plugin</a>
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
                        <form id="form" enctype="multipart/form-data" method="post" action="criarplugin">

                            <div>

                                <h1><strong>Principal</strong></h1>

                                <div class="form-group row">
                                    <div class="col-7">
                                        <label for="nome">Nome*</label>
                                        <input type="text" class="form-control" name="nome" id="nome"
                                            placeholder="Digite o nome do plugin (Um plugin que não exista)" required>
                                    </div>
                                    <div class="col-5">
                                        <label for="versaoPlugin">Versão atual*</label>
                                        <input type="text" class="form-control w-100" style="width: 40%;" name="pluginversion"
                                            id="versaoPlugin" placeholder="Digite a versão" required>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col  d-sm-flex justify-content-between">
                                        <label>Plguin (.jar)*: </label>
                                        <label for="plugin" class="btn btn-outline-primary"><i class="bi bi-upload"></i>
                                            Upload</label>
                                        <div>
                                            <input type="file" class="input-file" accept=".jar" id="plugin"
                                                name="plugin" required>
                                            <span>Nenhum arquivo escolhido</span>
                                        </div>
                                    </div>
                                    <div class="col d-sm-flex justify-content-between">
                                        <label>Pasta config (.zip): </label>
                                        <label for="configs" class="btn btn-outline-primary"><i class="bi bi-upload"></i>
                                            Upload</label>
                                        <div>
                                            <input type="file" class="input-file" accept="application/zip" id="configs"
                                                name="configs">
                                            <span>Nenhum arquivo escolhido</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="description">Descrição do plugin*</label>
                                    <textarea class="form-control" id="description" name="description"
                                        placeholder="Digite a descrição do plugin" rows="3" required></textarea>
                                </div>
                            </div>
                            <div>
                                <h1><strong>Configurações</strong></h1>

                                <div class="form-group">
                                    <label for="categoria">Categoria*</label>
                                    <select class="form-select" id="categoria" name="categoria" required>
                                        <option value="0">Selecione uma categoria...</option>
                                        <%
                                            for (Categoria categoria : Categoria.values()) {
                                        %>
                                        <option value="<%=categoria.getIndex()%>"><%=categoria.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12">
                                        <label for="urlVideo">URL do vídeo</label>
                                        <input class="form-control" type="url" placeholder="Digite a url do vídeo" id="urlVideo"
                                            name="urlVideo">
                                    </div>
                                    <div class="col-12">
                                        <label for="github">URL do github</label>
                                        <input class="form-control" type="url" placeholder="Digite a url do github" id="github"
                                            name="github">
                                    </div>
                                    <div class="col-6">
                                        <label for="compatibilyVersion">Versão compatível*</label>
                                        <input class="form-control" type="text" placeholder="Digite a versão mínima a ser usada"
                                            id="compatibilyVersion" name="compatibilyVersion" required>
                                    </div>
                                    <div class="col-6">
                                        <label for="preco">Preço*</label>
                                        <input class="form-control" type="number" placeholder="Digite o preço" id="preco"
                                            name="preco" required>
                                    </div>
                                    <div class="col-12">
                                        <label for="dependencias">Dependências</label>
                                        <input type="text" class="form-control" placeholder='Digite as dependências do plugin (Separe por " ")'
                                            id="dependencias" name="dependencies">
                                    </div>
                                </div>
                            </div>

                            <div class="p-3">
                                <h1><strong>Recursos</strong></h1>
                                <div class="row d-flex justify-content-between cmd">
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
                                        <button onclick="adicionar('comandos')" class="btn btn-success"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-plus-circle"></i></button>
                                        <button onclick="remover('comandos','caixacomando')" class="btn btn-danger"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-x-circle"></i></button>
                                    </div>
                                </div>
                                <div class="row d-flex justify-content-between cmd">
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
                                        <button onclick="adicionar('permissoes')" class="btn btn-success"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-plus-circle"></i></button>
                                        <button onclick="remover('permissoes','caixapermissao')" class="btn btn-danger"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-x-circle"></i></button>
                                    </div>
                                </div>
                                <div class="row d-flex justify-content-between cmd">
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
                                        <button onclick="adicionar('recursos')" class="btn btn-success"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-plus-circle"></i></button>
                                        <button onclick="remover('recursos','caixarecurso')" class="btn btn-danger"
                                            style="width: 40px; height: 40px; border-radius: 100%" type="button"><i
                                                class="bi bi-x-circle"></i></button>
                                    </div>
                                </div>
                            </div>

                            <div>
                                                    <h2><strong>Insira imagens do plugin</strong></h2>
                                                    <div class="imgs" id="imgs">
                                                        <div id="0"
                                                            class="w-100 d-flex flex-column align-items-center justify-content-center caixa-imagem">
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

                            <input type="submit" class="btn btn-primary w-25" value="Criar"></input>

                        </form>
                    </div>
    </main>


</body>

<script src="../../js/menu.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    let img_index = 0;
</script>
<script src="js/createpl.js"></script>
<script>

    $("form").on("submit", function(event) {
        if ($("categoria").val() === "0") event.preventDefault();
    })

       function getTamanhoDaTela() {
            var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

            if (largura > 700) {
                document.getElementById("barra-lateral").style.display = "flex";
            }
        }
        window.addEventListener("resize", getTamanhoDaTela);
</script>
<script src="../js/dashboard.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>