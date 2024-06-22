<%@ page import="com.xg7plugins.xg7plguinssite.models.UserModel" %>
<%@ page import="com.xg7plugins.xg7plguinssite.db.DBManager" %>
<%@ page import="com.xg7plugins.xg7plguinssite.servlets.plugin.PluginJson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Termos</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="css/body.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="imgs/logo.png" />

    <%
        UserModel model = (UserModel) request.getSession().getAttribute("user");
    %>
</head>

<body>
<nav id="nav-principal">
    <div id="nav-c" class="container d-flex justify-content-between">
        <div class="nav-left d-flex justify-content-left align-items-center">
            <a class="navbar-brand" href=""><img src="imgs/logo.png" width="100px" alt=""></a>

        </div>
        <div class="nav-right d-flex justify-content-right align-items-center">
            <div class="d-md-flex align-items-center" id="items">

                <a href="index.jsp#plugins" class="linkComum d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-plug"></i>
                    Plugins
                </a>
                <a href="https://discord.gg/GXe8WbZnKa" class="linkComum  d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
                    <i class="bi bi-discord"></i>
                    Discord
                </a>

                <button id="hamburger" class="btn" onclick="toggleMenu()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="27" height="27" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
                    </svg>
                </button>

            </div>

            <a href="login.jsp" class="btn btn-primary d-md-flex justify-content-center align-items-center" style="margin-left: 15px">
                <%
                    if (model == null || model.getImageData() == null) {
                %>
                <i class="bi bi-person"></i>
                <%
                } else {
                %>
                <img src="<%=model.getImageData()%>" width="50" height="50" style="border-radius: 20px" alt="img">
                <%
                    }
                %>
                <p id="textocliente" style="align-content: center; display: flex"><%=model == null ? "Área do cliente" : model.getNome()%></p>
            </a>
        </div>




    </div>




</nav>
<menu id="menu">

    <div class="d-flex flex-column" style="padding: 0 10px 0 10px" id="itemsMenu">

        <a href="#plugins" class="menu-items d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
            <i class="bi bi-plug"></i>
            Plugins
        </a>
        <a href="" class="menu-items d-md-flex link-underline link-underline-opacity-0" style="color: #646464">
            <i class="bi bi-discord"></i>
            Discord
        </a>

    </div>

</menu>


<main style="display: flex; align-items: center; justify-content: center">
    <div class="w-75" style="background-color: #eaeaea; padding: 15px; border-radius: 20px">
        <h1><strong>Termos de Serviço e política de privacidade da XG7Plugins!</strong></h1>

        <ul>
            <li>Última atualização - 15/06/2024</li>
        </ul>

        <strong>
            Esse site se encontra em desenvolvimento, os termos não estão teminados ainda!
        </strong>
        <br><br>

        Esses termos são necessários manter a originalidade dos plugins e a segurança do usuário. Com os termos concordados e aceitados, você terá acesso a se cadastrar no site e futuramente acesso a fóruns e outros.
        <br><br>
        Nós da XG7Plugins precisamos que as nossas regras sejam seguidas.

        <br><br>
        Caso haja alguma dúvida, entre em contato com <a href="xg7mails@gmail.com">xg7mails@gmail.com</a>

        <h2><strong>1. Acordo com a XG7PPlugins</strong></h2>
        <strong>1.1</strong> Para usar os Serviços da XG7Plugins, primeiro você deve concordar com os Termos.
        Você pode concordar com os Termos usando efetivamente os Serviços da XG7Plugins.
        Você entende e concorda que a XG7Plugins considerará o uso dos Serviços da XG7Plugins como
        uma aceitação dos Termos a partir desse ponto em diante.
        <br><br>

        <strong>1.2</strong> Você não poderá usar os Serviços da XG7Plugins se você for uma pessoa impedida de receber os Serviços da XG7Plugins
        sob as leis de qualquer país, incluindo o país onde o usuário é residente ou a partir do qual usa os Serviços da XG7Plugins.

        <br><br>
        <strong>1.3</strong> Para usar os Serviços da XG7Plugins você precisa seguir, aceitar e concordar com nossas Políticas de uso, caso contrario está impedido de usar o serviço.

        <br><br>
        <h2><strong>2. Uso de dados</strong></h2>
        A XG7Plugins usa os dados coletados para vários fins:
        <br><br>
        Para fornecer e manter o nosso Serviço;
        <br>
        Para fornecer a você avisos sobre a sua conta via email;
        <br>
        Para fornecer suporte ao cliente;
        <br>
        Para monitorar o uso do nosso Serviço;
        <br>
        Para dados estatísticos sobre os nossos plugins;
        <br>
        Para qualquer outra finalidade com o seu consentimento.
        <br><br>
        <h2><strong>3. Políticas de Serviços e Privacidade</strong></h2>
        <strong>3.1</strong> Você concorda em cumprir com a Política de Uso, que é aqui incorporada por esta referência e que pode ser atualizada de tempos em tempos.
        <br><br>
        <strong>3.2</strong> Os Serviços da XG7Pluigns estarão sujeitos à política de privacidade e você concorda com a utilização de seus dados de acordo com as Políticas de Privacidade da XG7Pluigns, que é aqui incorporada por esta referência e que pode ser atualizada de tempos em tempos.
        <br><br>
        <strong>3.3</strong> Você concorda que irá proteger a privacidade e os direitos legais dos usuários finais de sua aplicação (“Usuários finais”). Você deve fornecer aviso de privacidade legalmente adequado e proteção para usuários finais. Se os usuários finais lhe fornecerem os nomes de usuário, senhas ou outras informações de login ou informações pessoais, você deve tornar os usuários cientes de que a informação estará disponível para sua aplicação e consequentemente para XG7Pluigns.
        <br><br>
        <h2><strong>4. Licença da XG7Pluigns e Restrições</strong></h2>
        <strong>4.1</strong> XG7Pluigns dá-lhe uma licença pessoal, não atribuível e não exclusiva para utilizar o plugin fornecido. Esta licença tem como único objetivo permitir-lhe usar e gozar os benefícios dos Serviços da XG7Plugins, como previsto nos Termos.
        <br><br>
        <strong>4.2</strong> Você não pode (e não pode permitir a mais ninguém): (a) copiar, modificar, criar uma obra derivada de engenharia reversa, decompor ou de outro modo tentar extrair o código-fonte dos Serviços da XG7Plugins ou qualquer parte dele, a menos que que seja expressamente permitido ou exigido por lei, ou a menos que lhe tenha sido especificamente dito que você pode fazê-lo pela XG7Pluigns, por escrito (por exemplo, através de uma fonte aberta licença de plugin); ou (b) tentar desativar ou contornar qualquer mecanismo de segurança usados ​​pelos Serviços da XG7Pluigns.
        <br><br>
        <strong>4.3</strong> Licenças de plugin  para componentes dos Serviços da XG7Pluigns. Na medida em que as licenças de plugin expressamente estes Termos, as licenças de código aberto regem o seu contrato com a XG7Plugins para a utilização dos componentes dos Serviços da XG7Plugins.
        <br><br>
        <strong>4.4</strong> XG7Pluigns concede a você uma licença limitada, não exclusiva, com o direito de sub-licença, para exibir as marcas XG7Plugins e / ou logotipos, tal como previsto aqui ("Marcas") para o único propósito de promoção ou publicidade que você usar os Serviços da XG7Plugins. Você concorda que todo ágio gerado através de seu uso das Marcas XG7Pluign.
        <br><br>
        <strong>4.5</strong> XG7Plugins permite que você faça plugins com a finalidade e recursos parecidos, desde que seja indicado em alguma parte do código que foi inspirado nos nossos plugins.
        <h2><strong>5. Manutenções</strong></h2>
        <strong>5.1</strong> As manutenções dos serviços da XG7Plugins serão realizadas sempre que necessário, podendo ocasionar instabilidade e indisponibilidade parcial ou total no site. Toda manutenção nos serviços da XG7Plugins, será previamente comunicada através do nosso discord.
        <br><br>
        <h2><strong>6. Limitação de Responsabilidade</strong></h2>
        <strong>6.1</strong> ACIMA, O USUÁRIO ENTENDE E CONCORDA QUE A XG7PLUGINS NÃO SERA RESPONSÁVEL POR QUALQUER DANO DIRETO, INDIRETO, ACIDENTAL, OU CONSEQUÊNCIA DE DANOS ESPECIAIS QUE POSSAM SER SOFRIDOS POR VOCÊ, NO ENTANTO CAUSADOS E SOB QUALQUER TEORIA DE RESPONSABILIDADE. ESTA INFORMAÇÃO DEVE INCLUIR MAS NÃO SE LIMITANDO A, QUALQUER PERDA DE LUCROS (INCORRIDA DIRETA OU INDIRETAMENTE), QUALQUER PERDA DE BOA VONTADE OU REPUTAÇÃO DE NEGÓCIOS, SOFRER PERDA DE DADOS, CUSTOS DE AQUISIÇÃO DE BENS OU SERVIÇOS OU OUTRA PERDA INTANGÍVEL.
        <br><br>
        <strong>6.2</strong> AS LIMITAÇÕES DE RESPONSABILIDADE DA XG7PLUGINS PARA VOCÊ NO PARÁGRAFO 10.1 ACIMA, SERÃO APLICÁVEIS OU NÃO CASO A XG7Plugins TENHA SIDO AVISADO DE OU DEVERIA TER CONHECIMENTO DA POSSIBILIDADE DE OCORRÊNCIA DE TAIS PERDAS.
        <br><br>
        <h2><strong>7. Indenização</strong></h2>
        <strong>7.1</strong> Você concorda em isentar e indenizar A XG7Plugins,  diretores, funcionários, fornecedores ou parceiros (coletivamente "XG7Plugins e Parceiros") de e contra qualquer reivindicação de terceiros decorrentes ou de qualquer forma relacionada com (a) a sua violação dos Termos, (b) o uso dos Serviços da XG7Plugins, (c) violação de leis, normas ou regulamentos em conexão com os Serviços da XG7Plugins, ou (d) o seu conteúdo ou a sua aplicação, incluindo qualquer responsabilidade ou despesa proveniente de reclamações, perdas, danos (diretos e consequenciais), ações judiciais, sentenças, despesas processuais e honorários advocatícios, de qualquer tipo e natureza. Em tal caso, XG7Plugins irá fornecer-lhe um aviso por escrito de tal reclamação, processo ou ação.
        <br><br>
        <h2><strong>8. Política de Direitos Autorais</strong></h2>
        <strong>8.1</strong> Você concorda em estabelecer um processo para responder a acusações de supostas infrações. É política da XG7Plugins responder às notificações de qualquer origem ou outras leis de direitos autorais aplicáveis ​​e encerrar as contas de infratores reincidentes. Reservamo-nos o direito de remover conteúdo em sua aplicação ou, se necessário, o próprio aplicativo após o recebimento de uma notificação válida.
        <br><br>
        <h2><strong>9. Outros conteúdos</strong></h2>
        <strong>9.1</strong> O usuário reconhece e concorda que XG7Plugins não é responsável pela disponibilidade de qualquer um desses sites ou recursos externos e não endossa qualquer publicidade, produtos ou outros materiais presentes ou disponíveis em tais bots ou recursos.
        <br><br>
        <strong>9.2</strong> O usuário reconhece e concorda que XG7Plugins não se responsabiliza por qualquer perda ou dano em que possa incorrer por você ou seus usuários finais como resultado da disponibilidade de tais sites ou recursos externos, ou como resultado da confiança depositada por você na integridade, precisão ou existência de quaisquer anúncios, produtos ou outros materiais presentes ou disponíveis a partir de tais sites ou recursos.
        <br><br>
        <h2><strong>10. Alterações nos Termos</strong></h2>
        <strong>10.1</strong> XG7Plugins pode fazer alterações nos Termos de tempos em tempos. Se mudarmos os Termos de nenhuma forma substantiva, damos-lhe, pelo menos, sete (7) dias de aviso antes que as alterações entrem em vigor, período de tempo que você pode rejeitar as alterações encerrando sua conta.
        <br><br>
        <strong>10.2</strong> Você compreende e concorda que, se utilizar os Serviços da XG7Plugins após a data em que os Termos foram alterados, XG7Plugins tomará o seu uso como uma aceitação dos Termos atualizados.
        <br><br>
        <h2><strong>11. Termos jurídicos gerais</strong></h2>
        <strong>11.1</strong> Os Termos constituem o contrato integral entre você e a XG7Plugins e regulam a utilização dos Serviços da XG7Plugins (excluindo quaisquer serviços que possam eventualmente ser fornecidos com um contrato escrito em separado), e substituem na íntegra quaisquer contratos anteriores entre você e a XG7Plugins em relação aos Serviços da XG7Plugins.
        <br><br>
        <strong>11.2</strong> Se XG7Plugins fornece-lhe uma tradução da versão destes Termos, a versão destes Termos no idioma Português irá controlar qualquer conflito.
        <br><br>
        <strong>11.3</strong> Você concorda que XG7Plugins pode lhe enviar avisos, incluindo aqueles sobre alterações feitas aos Termos, por e-mail, ou publicações nos Serviços da XG7Plugins. Ao fornecer o seu endereço de e-mail XG7Plugins, você concorda em utilizarmos o endereço de e-mail para enviar-lhe quaisquer avisos exigidos por lei.
        <br><br>
        <strong>11.4</strong> Você concorda que se XG7Plugins não exercer ou utilizar qualquer direito legal ou direito reconhecido contido nos Termos (ou ao qual XG7Plugins tem direito nos termos de qualquer lei aplicável), isso não será considerado como uma renúncia formal aos direitos da XG7Plugins e que esses direitos ou recursos ainda estarão disponíveis para XG7Plugins.
    </div>






</main>

<footer class="bg-light rounded p-0 pt-3 d-flex align-items-center justify-content-between flex-column" style="height: 250px">

    <h1><strong>XG7Plugins</strong></h1>
    <p>Os melhores plugins para seu servidor de Minecraft!</p>
    <div class="footer-buttons mb-2 d-flex justify-content-around">
        <a href="https://github.com/DaviXG7"><i class="bi bi-github" style="font-size: 35px; color: black"></i><small>Github</small></a>
        <a href="https://discord.gg/2fACbYbBsf" style="display: flex; flex-direction: column"><i class="bi bi-discord" style="font-size: 35px; color: black"></i><small>Discord</small></a>
        <a href=""><i class="bi bi-book" style="font-size: 35px; color: black"></i><small>API</small></a>
        <a href=""><i class="bi bi-laptop" style="font-size: 35px; color: black"></i> <small>Termos</small></a>
    </div>
    <small><a href="easteregg/jogos.html">Easter egg :D</a></small>
    <h6 class="w-100 d-flex align-items-center justify-content-center" style="background-color: rgb(196, 196, 196); height: 3em;">
        Copyright ₢ XG7Plugins Todos os direitos reservados <br>
    </h6>


</footer>


<script src="js/jQuery.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

    function toggleMenu() {
        let menu = document.getElementById("menu");
        if (menu.style.display === "none" || menu.style.display === "") {
            menu.style.display = "inline";
        } else {
            menu.style.display = "none";
        }
    }

    function getTamanhoDaTela() {
        var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

        if (largura > 700) {
            document.getElementById("menu").style.display = "none";
        }
    }
    window.addEventListener("resize", getTamanhoDaTela);

</script>





</body>

</html>