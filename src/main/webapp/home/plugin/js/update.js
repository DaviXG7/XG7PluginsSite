let changed = false;
$("#editar").on("change", function(event) {
    if (!changed) {
        $("#edicao").removeClass("d-none");
        $("#edicao").addClass("d-inline");
        changed = true;
        return;
    }
    $("#edicao").removeClass("d-inline")
    $("#edicao").addClass("d-none")
    changed = false;
})

$("#plugin").on("change", function (event) {
    img_index = 0;

    $("#edicao").removeClass("d-inline")
    $("#edicao").addClass("d-none")
    document.getElementById("editar").checked = false
    changed = false;

    $('#imgs').children().each(function (e) {
        $(this).remove();
    })
    $('#comandos').children().each(function (e) {
        $(this).remove();
    })
    $('#permissoes').children().each(function (e) {
        $(this).remove();
    })
    $('#recursos').children().each(function (e) {
        $(this).remove();
    })



    let plselect = null;

    for (const pl of pls) {
        if (pl.nome === $(this).val()) {
            plselect = pl;
            break;
        }
    }
    if (plselect == null) {
        $("#atualizacao").removeClass("d-inline");
        $("#atualizacao").addClass("d-none");

        $("#postar").addClass("disabled")

        return;
    }
    $("#postar").removeClass("disabled")
    $("#atualizacao").addClass("d-inline");
    $("#atualizacao").removeClass("d-none");

    plselect.comandos.forEach(function (e) {

        $('#comandos').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixacomando\"\n" +
            "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
            "                                            <div class=\"col-sm-6\">\n" +
            "                                                <label class=\"\">Comando</label>\n" +
            "                                                <input name=\"commandName\" class=\"form-control\" type=\"text\" value='" + e.nome + "' \n" +
            "                                                    placeholder=\"Nome do comando (ex.: pular)\" required>\n" +
            "                                            </div>\n" +
            "                                            <div class=\"col-sm-6\">\n" +
            "                                                <label class=\"\">Descrição</label>\n" +
            "                                                <input name=\"commandDescription\" class=\"form-control\" type=\"text\" value='" + e.descricao + "'\n"  +
            "                                                    placeholder=\"Descrição do comando\" required>\n" +
            "                                            </div>\n" +
            "                                        </div>")
    })

    plselect.perms.forEach(function (e) {
        $('#permissoes').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixapermissao\"\n" +
            "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
            "                                            <div class=\"col-sm-6\">\n" +
            "                                                <label class=\"\">Permissão</label>\n" +
            "                                                <input name=\"permName\" class=\"form-control\" type=\"text\"\n value='" + e.nome + "'" +
            "                                                    placeholder=\"Nome da permissão (ex.: sua.permissao)\" required>\n" +
            "                                            </div>\n" +
            "                                            <div class=\"col-sm-6\">\n" +
            "                                                <label class=\"\">Descrição</label>\n" +
            "                                                <input name=\"permDescription\" class=\"form-control\" type=\"text\"\n value='" + e.descricao + "'" +
            "                                                    placeholder=\"Descrição da permissão\" required>\n" +
            "                                            </div>\n" +
            "                                        </div>")
    })
    plselect.recursos.forEach(function (e) {
        $('#recursos').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixarecurso\"\n" +
            "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
            "                                            <div class=\"col-sm-12\">\n" +
            "                                                <label class=\"\">Recurso</label>\n" +
            "                                                <input name=\"resource\" class=\"form-control\" type=\"text\"\n value='" + e + "'" +
            "                                                    placeholder=\"Recurso (Uma das coisas que o plugin faz)\" required>\n" +
            "                                            </div>\n" +
            "                                        </div>")
    })

    plselect.imagens64.forEach(function (e) {
        $("#imgs").append(
            "<div id=\"" + img_index + "\" class=\"w-100 d-flex flex-column align-items-center justify-content-center caixa-imagem\">\n" +
            "                                    <label class=\"\">\n" +
            "                                        \n" +
            "                                        <input name=\"img" + img_index + "\" type=\"file\" class=\"input-file\" accept=\"image/*\">\n" +
            "                                    <img src=\"" + e.imagem64 + "\">\n" +
            " </label>" +
            "                                <label class=\"w-50\"> Título: <input class=\"form-control\" value='" + e.titulo +"' type=\"text\" placeholder=\"Digite um título\" name=\"img-titulo0\"></label><label class=\"w-50\">Descrição:<input class=\"form-control\" type=\"text\" value='" + e.descricao + "' placeholder=\"Digite uma breve descrição\" name=\"img-desc0\"></label></div>"
        )
        img_index++;
    });








})

$("form").submit(function (event) {
    let plselect = null;

    for (const pl of pls) {
        if (pl.nome === $("#plugin").val()) {
            plselect = pl;
            break;
        }
    }
    if (plselect == null ) {
        event.preventDefault();
        return;
    }
        $('form').attr("action", "atualizarpl?plugin=" + $("#plugin").val())
    }
)