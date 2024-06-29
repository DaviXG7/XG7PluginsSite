<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="br">
<head>
    <meta charset="UTF-8">
    <title>Faça seu cadastro</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/cadastro.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<a href="index.jsp" class="voltar link link-light link-underline link-underline-opacity-0" style="font-size: 30px">
    <i class="bi bi-arrow-left-short"></i>
    Voltar
</a>
<div class="cadastro">


    <img src="imgs/logo.png" width="133px">
    <form class="d-flex flex-column align-items-center" method="post" action="cadastro">
        <div class="form-group">
            <label for="email">Email:*</label>
            <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Digite seu mail" required>
        </div>
        <div class="form-group">
            <label for="nome">Nome:* <a style="color: #818181" type="button" class="" data-bs-toggle="popover" data-bs-placement="right" title="Integração com o Minecraft" data-bs-content="Colocando seu nome do usuário do Minecraft Java original, a sua foto de perfil será a sua skin! (Você poderá trocar depois)">
                <i class="bi bi-exclamation-circle"></i>
            </a></label>
            <input type="text" class="form-control" id="nome" name="nome" aria-describedby="emailHelp" placeholder="Digite seu nome" required>
        </div>
        <br>
        <div class="form-group">
            <label for="password">Senha:* <a style="color: red" type="button" class="" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="A senha deve conter pelo menos 8 letras, pelo menos uma delas devem ser maiúsculas, não podem conter espaços e as senhas devem ser iguais">
                <i class="bi bi-exclamation-circle"></i>
            </a></label>
            <input type="password" class="form-control" id="password" name="senha" placeholder="Senha" required>
        </div>
        <div class="form-group">
            <label for="confirmarsenha">Confirmar Senha:*</label>
            <input type="password" class="form-control" id="confirmarSenha" name="confirmarSenha" placeholder="Confirmar senha" required>
        </div>
        <br>
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="termos" name="termos" required>
            <label style="font-size: 12px" class="form-check-label" for="termos">Ao continuar você concorda com os <br> <a href="termos.jsp" target="_blank"> Termos de Uso e Política de Privacidade</a></label>
        </div>
        <br>
        <button id="cadsubmit" type="submit" class="btn btn-primary w-100 disabled">Criar conta</button>
        <p style="font-size: 11px">Já tem uma conta? Clique aqui para <a href="login.jsp">entrar na conta.</a></p>
        <p style="font-size: 11px; color: red"><%=request.getAttribute("erromsg") != null ? request.getAttribute("erromsg") : ""%></p>
    </form>





</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="js/cadastro.js"></script>
</body>
</html>
