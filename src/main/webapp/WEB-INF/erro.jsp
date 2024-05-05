<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Erro</title>
    <link rel="icon" href="../imgs/logo.png">
    <style>
        html {
            height: 100%;
        }
        body {
            height: 100%;
            font-family: Arial sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        a {
            text-decoration: none;
            color: blue;
        }
    </style>
</head>
<body>
<h1>Ocorreu um erro!</h1>
<p>Código de erro: ${pageContext.errorData.statusCode}</p>
<a href="../index.jsp">Voltar ao início</a>
</body>
</html>