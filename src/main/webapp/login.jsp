<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>XG7Plugins</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link href="css/login.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


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
        <a href="">Esqueci minha senha</a>
        <br>
        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="exampleCheck1">
            <label class="form-check-label" for="exampleCheck1">Continuar conectado?</label>
        </div>
        <br>
        <button type="submit" class="btn btn-primary w-100">Iniciar seçao</button>
        <p style="font-size: 11px">Não tem uma conta? Clique aqui para <a href="cadastro.jsp">criar uma conta</a></p>
        <%=request.getAttribute("erromsg")
        %>
    </form>





</div>

</body>
</html>