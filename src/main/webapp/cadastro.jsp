<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="br">
<head>
    <meta charset="UTF-8">
    <title>XG7Plugins</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
    <form action="cadastro" method="post" class="d-flex flex-column align-items-center">
        <div class="form-group">
            <label for="email">Email:*</label>
            <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Digite seu mail" required>
        </div>
        <div class="form-group">
            <label for="nome">Nome:*</label>
            <input type="text" class="form-control" id="nome" name="nome" aria-describedby="emailHelp" placeholder="Digite seu nome" required>
        </div>
        <br>
        <div class="form-group">
            <label for="password">Senha:*</label>
            <input type="password" class="form-control" id="password" name="senha" placeholder="Senha" required>
        </div>
        <div class="form-group">
            <label for="confirmarsenha">Confirmar Senha:*</label>
            <input type="password" class="form-control" id="confirmarsenha" name="confirmarSenha" placeholder="Confirmar senha" required>
        </div>
        <br>
        <div class="form-check">
            <input type="checkbox" name="termos" class="form-check-input" id="termos" required>
            <label style="font-size: 12px" class="form-check-label" for="termos">Ao continuar você concorda com os <a href=""> Termos e condições</a></label>
        </div>
        <br>
        <button type="submit" class="btn btn-primary w-100">Criar conta</button>
        <p style="font-size: 11px">Já tem uma conta? Clique aqui para <a href="login.jsp">entrar na conta.</a></p>
    </form>





</div>

<%
    String error = (String) request.getAttribute("erromsg");
    if (error != null) {


%>
<div style="
background-color: red;
    border-radius: 10px;
    width: 300px;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50px;
    margin-top: 10px;
    transition: 0.3s;
">
    <h2 class="text-light"><i class="bi bi-exclamation-circle-fill"></i> <%=error%></h2>
</div>
<%
    }
%>

</body>
</html>
