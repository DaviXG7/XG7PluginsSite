<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="br">
<head>
    <meta charset="UTF-8">
    <title>Faça seu cadastro</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/cadastro.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />

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
            <input type="email" class="form-control" name="email" id="email" aria-describedby="emailHelp" placeholder="Digite seu mail" required>
            <small class="form-text text-muted" id="e" style="display: none">Esse email já existe</small>

        </div>
        <div class="form-group">
            <label for="nome">Nome:*</label>
            <input type="text" class="form-control" id="nome" name="nome" aria-describedby="emailHelp" placeholder="Digite seu nome" required>
            <small class="form-text text-muted">Se você usar o seu nome do Minecraft,<br> a sua foto será tua skin!<br> (Precisa de uma conta original)</small>
        </div>
        <br>
        <div class="form-group">
            <label for="password">Senha:*</label>
            <input type="password" class="form-control" id="password" name="senha" placeholder="Senha" required>
            <small class="form-text text-muted"><i id="caractere" style="color: red" class="bi bi-exclamation-circle"></i> Pelo menos 8 caracteres</small> <br>
            <small class="form-text text-muted"><i id="caixaalta" style="color: red" class="bi bi-exclamation-circle"></i> Pelo menos 1 letra maiúscula</small> <br>
            <small class="form-text text-muted"><i id="senhasIguais" style="color: red" class="bi bi-exclamation-circle"></i> Senhas iguais</small>

        </div>
        <div class="form-group">
            <label for="confirmarsenha">Confirmar Senha:*</label>
            <input type="password" class="form-control" id="confirmarSenha" name="confirmarSenha" placeholder="Confirmar senha" required>
        </div>
        <br>
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="termos" name="termos" required>
            <label style="font-size: 12px" class="form-check-label" for="termos">Ao continuar você concorda com os <a href=""> Termos e condições</a></label>
        </div>
        <br>
        <button id="cadsubmit" type="submit" class="btn btn-primary w-100 disabled">Criar conta</button>
        <p style="font-size: 11px">Já tem uma conta? Clique aqui para <a href="login.jsp">entrar na conta.</a></p>
        <p style="font-size: 11px; color: red"><%=request.getAttribute("erromsg") != null ? request.getAttribute("erromsg") : ""%></p>
    </form>





</div>
<script href="js/jQuery.js"></script>
<script href="js/bootstrap.js.js"></script>
<script src="js/cadastro.js"></script>
</body>
</html>
