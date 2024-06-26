<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faça seu login</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/login.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">



</head>
<body>
<a href="index.jsp" class="voltar link link-light link-underline link-underline-opacity-0" style="font-size: 30px">
    <i class="bi bi-arrow-left-short"></i>
    Voltar
</a>
<div class="login">

    <img src="imgs/logo.png" width="133px">
    <form action="login" method="post" class="d-flex flex-column align-items-center">
        <div class="form-group">
            <label for="exampleInputEmail1">Email:*</label>
            <input type="email" class="form-control" name="email" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Digite seu mail" required>
        </div>
        <br>
        <div class="form-group">
            <label for="exampleInputPassword1">Senha:*</label>
            <input type="password" name="senha" class="form-control" id="exampleInputPassword1" placeholder="Senha">
        </div>
        <a style="font-size: 9px" href="">Esqueci minha senha <br>(Indisponível, entre em contato com xg7mails@gmail.com
            <br> ou no discord)</a>
        <br>
        <button type="submit" class="btn btn-primary w-100">Iniciar sessão</button>
        <p style="font-size: 11px">Não tem uma conta? Clique aqui para <a href="cadastro.jsp">criar uma conta</a></p>
        <p style="font-size: 11px; color: red"><%=request.getAttribute("erromsg") != null ? request.getAttribute("erromsg") : ""%></p>


    </form>





</div>

</body>
</html>