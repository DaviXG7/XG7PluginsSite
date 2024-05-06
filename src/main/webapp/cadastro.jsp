<%--
  Created by IntelliJ IDEA.
  User: davis
  Date: 30/04/2024
  Time: 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link href="css/cadastro.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<form action="cadastro" method='post'>
    <img src=imgs/logo.png alt="Logo" />

    <input type="text" name="nome" placeholder='Nome de usuário*' required/>

    <input type="text" name="login" placeholder='Email*' required/>

    <input type="text" name="senha" placeholder='Senha*' required/>

    <input type="password" name="confirmarSenha" placeholder='Confirmar senha*' required/>
    <input type="checkbox" name="aceitarTermos" placeholder="concordar termos" required>

    <input type="submit" />

</form>

</body>
</html>
