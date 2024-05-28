let img_index = 0

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
            console.log(r.result)
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

    $("form").submit(function (event) {
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

    function adicionar(id, classe) {
        $('#' + id).append($("." + classe)[0].outerHTML)
    }
    function remover(id, classe) {
        if ($("#" + id).children().length > 1) $("." + classe + ":last").remove();
    }