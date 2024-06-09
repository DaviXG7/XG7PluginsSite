
function mostrarAba(nomeAba, link) {
    const abas = document.getElementById("abas");
    for (let i = 0; i < abas.children.length; i++) {
        abas.children[i].classList.remove("active");
    }

    const links = document.getElementsByClassName("link");
    for (let i = 0; i < links.length; i++) {
        links[i].classList.remove("link-primary");
        links[i].classList.add("link-dark");
    }

    const linkAtual = document.getElementById(link);
    linkAtual.classList.remove("link-dark");
    linkAtual.classList.add("link-primary");

    const abaSelecionada = document.getElementById(nomeAba);
    abaSelecionada.classList.add("active")
}


function abrirTela(NomePlugin) {

    let plselect = null;

    for (const pl of pls) {
        if (pl.nome === NomePlugin) {
            plselect = pl;
            break;
        }
    }
    if (plselect == null) return;
    const link = plselect.preco === 0 ? "/download?plugin=" + plselect.nome + "&type=" + "plugin": "";
    let nomelabel = $("#nomePlugin");
    let downloads = $("#downloads");
    let descricao = $("#description");
    let linkBaixar = $("#baixar");
    let linkGithub = $("#github");
    let linkVideo = $("#urlVideo");
    let versao = $("#versao");
    let dependencias = $("#dependencias");
    let recursos = $("#recursos");
    let comandos = $("#comandosL");
    let perms = $("#perms");
    let changelog = $("#changelog");
    let indicadores = $("#indicators")
    let imagens = $("#imgs");
    let config = $("#a5");

    nomelabel.text(plselect.nome);
    downloads.text(plselect.downloads);
    descricao.text(plselect.descricao);
    versao.text(plselect.versao);

    //Provisório!
    linkBaixar.text("Comprar R$" + plselect.preco)
    if (plselect.preco === 0) {
        linkBaixar.attr("href", "/download?plugin=" + plselect.nome + "&type=plugin");
        linkBaixar.text("Baixar");
    }

    if (plselect.github !== "") linkGithub.attr("href", plselect.github);
    else linkGithub.addClass("d-none");

    if (plselect.config !== "") config.attr("href", "/download?plugin=" + plselect.nome + "&type=config");
    else config.addClass("d-none");

    if (plselect.linkYoutube !== "") linkVideo.html("<h5><strong>Demostração:</strong></h5> <iframe width=\"100%\" height=\"250" +
        "" +
        "" +
        "\" src=\"" + plselect.linkYoutube + "\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe>");
    else linkVideo.addClass("d-none");

    if (plselect.imagens64.length === 0) $("#imagens").addClass("d-none");
    else plselect.imagens64.forEach(function (e, i) {

        let html = '<div class="carousel-item';

        if (i === 0) {
            html += ' active'
        }
        html += '"> <img class="d-block w-100" src=' + e.imagem64 + ' " alt="Imagem não carregada">'

        if (e.titulo !== "" || e.descricao !== "") {

            html += '<div class="carousel-caption">'

            if (e.titulo !== "" || e.titulo !== undefined) {
                html += '<h3 style="color: #ffffff;' +
                    'text-shadow: ' +
                    '     -1px -1px 0px #000000,' +
                    '      -1px 1px 0px #000000,  ' +
                    '        1px -1px 0px #000000,  ' +
                    '         1px 0px 0px #000000;">' + e.titulo + '</h3> '
            }
            if (e.descricao !== "" || e.descricao !== undefined) {
                html += '<p style="color: #ffffff; ' +
                    'text-shadow: ' +
                    '         -1px -1px 0px #000000, ' +
                    '          -1px 1px 0px #000000,   ' +
                    '            1px -1px 0px #000000,   ' +
                    '             1px 0px 0px #000000;">' + e.descricao + '</p> '
            }


            html += '</div> ';

        }

        html += '</div> ';
        console.log("html")

        imagens.append(html)



        if (i === 0) {
            indicadores.append('<button type=\"button\" data-bs-target=\"#imagens\" class=\"active\" data-bs-slide-to=\"0\"></button>')
            return;
        }

        indicadores.append('<button type=\"button\" data-bs-target=\"#imagens\" data-bs-slide-to=\"' + i + '\"></button>')

    })
    if (plselect.dependencias.length === 0) $("#caixa-dependencia").addClass("d-none");
    else plselect.dependencias.forEach(function (e) {
        dependencias.append("<p class=\"visao-geral-dependencia-item\">" + e + "</p>")
    })
    plselect.recursos.forEach(function (e) {
        recursos.append("<li>" + e + "</li>")
    })
    plselect.comandos.forEach(function (e) {
        comandos.append("<li><strong>" + e.nome + "</strong> - " + e.descricao + "</li>")
    })
    plselect.perms.forEach(function (e) {
        perms.append("<li><strong>" + e.nome + "</strong> - " + e.descricao + "</li>")
    })
    plselect.changelog.forEach(function (el,i) {
        let e = plselect.changelog[(plselect.changelog.length - 1) - i];
        let html = "<div class=\"atualizacao\">\n" +
            "                    <div style=\"border-left: 1px solid black; padding: 5px 5px 5px 10px; width: 100%; height: auto\">\n" +
            "\n" +
            "                        <h2><strong>Versão " + e.versao + "</strong></h2>\n" +
            "                        <p style=\"font-size: 15px\">" + e.data + "</p>\n" +
            "                        <ul>\n";

        e.logs.split("\n").forEach(function (el) {
            html += "<li>" + el + "</li>"
        })
        html += "                        </ul>\n" +
            "\n" +
            "                    </div>\n" +
            "                </div>";

        changelog.append(html)
    })

    $("#detalhes").removeClass("d-none")


}

function sair() {
    $("#nomePlugin").text("");
    $("#downloads").text("")
    $("#baixar").attr("href", "");
    $("#github").attr("href", "");
    $("#urlVideo").attr("src", "");
    $("#versoes").html("");
    $("#dependencias").html("");
    $("#recursos").html("");
    $("#comandosL").html("");
    $("#perms").html("");
    $("#changelog").html("");
    $("#a5").attr("href", "");
    $("#imgs").html("");
    $("#indicators").html("");

    $("#a5").removeClass("d-none");
    $("#caixa-dependencia").removeClass("d-none");
    $("#github").removeClass("d-none");
    $("#imagens").removeClass("d-none");
    $("#urlVideo").removeClass("d-none");


    $("#detalhes").addClass("d-none");
    document.getElementById("sair").classList.remove("out")
    document.getElementById("sair").classList.remove("in")

}

$("#detalhes").on("click", function (event) {
    if (event.target.id === "detalhes") {
        sair();

    }
})

$("#sair").on("click", sair)

document.addEventListener('mousemove', function (event) {
    const mouseY = event.clientY;

    const threshold = window.innerHeight * 0.75;

    if (!$("#detalhes").hasClass("d-none")) {
        if (mouseY > threshold || window.innerWidth <= 600) {
            document.getElementById("sair").classList.remove("out")
            document.getElementById("sair").classList.add("in")
            document.getElementById("sair").style.bottom = "15%";
        } else if (document.getElementById("sair").classList.contains("in")) {
            document.getElementById("sair").classList.remove("in")
            document.getElementById("sair").classList.add("out")
            document.getElementById("sair").style.bottom = "-10%";
        }
    }
});