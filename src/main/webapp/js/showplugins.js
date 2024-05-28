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

    let pls = [{
        nome: "Plugin1",
        downloads: 2,
        github: "",
        baixar: "",
        linkYoutube: "https://www.youtube.com/embed/VFvSylJUJNg?si=BBn8yL8B9Vl5ME2V",
        versao: "1.8+",
        dependencias: [
            "1",
            "2"
        ],
        recursos: [
            "1",
            "2"
        ],
        comandos: [
            {nome: "comandos",descricao: "descrição"},
            {nome: "comandos",descricao: "descrição"}
        ],
        perms: [
            {nome: "perm",descricao: "descrição"},
            {nome: "perm",descricao: "descrição"}
        ],
        changelog: [
            {
                versao: "a",
                data: "20/02/2002",
                logs: [
                    "a",
                    "b"
                ]
            }
        ]
    },

        {
            nome: "Plugin2",
            downloads: 2,
            github: "",
            baixar: "",
            linkYoutube: "https://www.youtube.com/embed/VFvSylJUJNg?si=BBn8yL8B9Vl5ME2V",
            versao: "1.16+",
            dependencias: [
                "1",
                "2asdasdas"
            ],
            recursos: [
                "1asdasdasdasd",
                "2"
            ],
            comandos: [
                {nome: "comaadssadadsndos",descricao: "descrição"},
                {nome: "comandos",descricao: "descrição"}
            ],
            perms: [
                {nome: "perm",descricao: "descrição"},
                {nome: "perasdsadsadasdadsasdm",descricao: "descrição"}
            ],
            changelog: [
                {
                    versao: "asasdsaasasdadsa",
                    data: "20/02/20202",
                    logs: [
                        "asadasdasdasd",
                        "b"
                    ]
                }
            ]
        }]

    function abrirTela(NomePlugin) {

        let plselect = null;

        for (const pl of pls) {
            if (pl.nome === NomePlugin) {
                plselect = pl;
                break;
            }
        }
        if (plselect == null) return;

        let nomelabel = $("#nomePlugin");
        let downloads = $("#downloads")
        let linkBaixar = $("#baixar");
        let linkGithub = $("#github");
        let linkVideo = $("#urlVideo");
        let versao = $("#versao");
        let dependencias = $("#dependencias");
        let recursos = $("#recursos");
        let comandos = $("#comandosL");
        let perms = $("#perms");
        let changelog = $("#changelog");

        nomelabel.text(plselect.nome);
        downloads.text(plselect.downloads);
        versao.text(plselect.versao);
        linkBaixar.attr("href", plselect.baixar);
        linkGithub.attr("href", plselect.github);
        linkVideo.html("<h5><strong>Demostração:</strong></h5> <iframe width=\"200\" height=\"135" +
            "" +
            "" +
            "\" src=\"" + plselect.linkYoutube + "\" title=\"YouTube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe>");
        plselect.dependencias.forEach(function (e) {
            dependencias.append("<p class=\"visao-geral-dependencia-item\">" + e + "</p>")
        })
        plselect.recursos.forEach(function (e) {
            recursos.append("<li>" + e +"</li>")
        })
        plselect.comandos.forEach(function (e) {
            comandos.append("<li><strong>" + e.nome + "</strong> - " + e.descricao + "</li>")
        })
        plselect.perms.forEach(function (e) {
            perms.append("<li><strong>" + e.nome + "</strong> - " + e.descricao + "</li>")
        })
        plselect.changelog.forEach(function (e) {
            let html = "<div class=\"atualizacao\">\n" +
                "                    <div style=\"border-left: 1px solid black; padding: 5px 5px 5px 10px; width: 100%; height: auto\">\n" +
                "\n" +
                "                        <h2><strong>Versão " + e.versao + "</strong></h2>\n" +
                "                        <p style=\"font-size: 15px\">" + e.data + "</p>\n" +
                "                        <ul>\n";

            e.logs.forEach(function (el) {
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

    $("#detalhes").on("click", function (event) {
        if (event.target.id === "detalhes") {

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


            $("#detalhes").addClass("d-none");
        }
    })