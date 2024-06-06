

    function imageInput(event, label, input, index) {
        if (!(event.target && event.target.files && event.target.files.length > 0)) {
            return;
        }


        var r = new FileReader();

        if ($(label).find("img").attr('src') === undefined) {
            $(input).parent().parent().append('<label class="w-50"> Título: <input class="form-control" type="text" placeholder="Digite um título" name="img-titulo' + index + '"></label><label class="w-50">Descrição:<input class="form-control" type="text" placeholder="Digite uma breve descrição" name="img-desc' + index + '"></label>');
            $(label).children().slice(0, 2).remove();
        }

        $(label).find("img").remove();

        $(label).removeClass("btn-upload")
        $(label).append('<img src="" alt="">')
        r.onload = function () {
            $(label).find("img").attr("src", r.result)
        }

        r.readAsDataURL(event.target.files[0])
    }

    function adicionarImagem() {
        img_index++;

        $("#imgs").append('<div id="' + img_index + '"" class="w-100 d-flex flex-column align-items-center justify-content-center caixa-imagem"><label class="btn-upload"><i class="bi bi-upload"></i> <p>Adicionar imagem</p> <input name="img' + img_index + '"" type="file" class="input-file" accept="image/*"></label></div>').find("label").first().find("input");
        $(".caixa-imagem input").on("change", function (event) {

            imageInput(event, $(this).parent(), $(this), img_index)
        });
    }

    function removerImagem() {
        if (img_index === 0) return;

        $("#imgs").find('div').last().remove();

        img_index--;
    }

    $(".caixa-imagem input").on("change", function (event) {

        imageInput(event, $(this).parent(), $(this), 0)
    });

    $("#form").submit(function (event) {
        if (parseInt($("#preco").val()) < 0) {
            event.preventDefault();
            window.alert("O valor do plugin não pode ser menor que 0");
        }
    }
    )
    document.getElementById("plugin").addEventListener('change', function (e) {
        var nextSibling = e.target.nextElementSibling;
        nextSibling.innerText = document.getElementById("plugin").files.length + " arquivo selecionado";
    });
    document.getElementById("configs").addEventListener('change', function (e) {
        var nextSibling = e.target.nextElementSibling;
        nextSibling.innerText = document.getElementById("configs").files.length + " arquivo selecionado";
    });

    function adicionar(id) {
        switch (id) {
            case "comandos":
                $('#comandos').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixacomando\"\n" +
                    "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
                    "                                            <div class=\"col-sm-6\">\n" +
                    "                                                <label class=\"\">Comando</label>\n" +
                    "                                                <input name=\"commandName\" class=\"form-control\" type=\"text\"\n" +
                    "                                                    placeholder=\"Nome do comando (ex.: pular)\" required>\n" +
                    "                                            </div>\n" +
                    "                                            <div class=\"col-sm-6\">\n" +
                    "                                                <label class=\"\">Descrição</label>\n" +
                    "                                                <input name=\"commandDescription\" class=\"form-control\" type=\"text\"\n" +
                    "                                                    placeholder=\"Descrição do comando\" required>\n" +
                    "                                            </div>\n" +
                    "                                        </div>")
                return;
            case "recursos":
                $('#recursos').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixarecurso\"\n" +
                    "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
                    "                                            <div class=\"col-sm-12\">\n" +
                    "                                                <label class=\"\">Recurso</label>\n" +
                    "                                                <input name=\"resource\" class=\"form-control\" type=\"text\"\n" +
                    "                                                    placeholder=\"Recurso (Uma das coisas que o plugin faz)\" required>\n" +
                    "                                            </div>\n" +
                    "                                        </div>")
                return;
            case "permissoes":
                $('#permissoes').append("<div class=\"mt-3 mb-3 rounded border row p-2 caixapermissao\"\n" +
                    "                                            style=\"background-color: rgba(0,255,225,0.37)\">\n" +
                    "                                            <div class=\"col-sm-6\">\n" +
                    "                                                <label class=\"\">Permissão</label>\n" +
                    "                                                <input name=\"permName\" class=\"form-control\" type=\"text\"\n" +
                    "                                                    placeholder=\"Nome da permissão (ex.: sua.permissao)\" required>\n" +
                    "                                            </div>\n" +
                    "                                            <div class=\"col-sm-6\">\n" +
                    "                                                <label class=\"\">Descrição</label>\n" +
                    "                                                <input name=\"permDescription\" class=\"form-control\" type=\"text\"\n" +
                    "                                                    placeholder=\"Descrição da permissão\" required>\n" +
                    "                                            </div>\n" +
                    "                                        </div>")
                return;
        }
    }
    function remover(id, classe) {
        if ($("#" + id).children().length > 1) $("." + classe + ":last").remove();
    }