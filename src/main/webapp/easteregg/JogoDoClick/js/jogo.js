let sorrisos = 0;

let pegados =[];

let jogo = {
    isRunning: false,
    segundos: 0,
    malha: []
}

function comecar() {
    document.getElementById("error").textContent = "";
    document.getElementById("inicio").classList.add("d-none")
    document.getElementById("jogo").classList.remove("d-none")
    document.getElementById("parar").classList.add("d-flex");
    document.getElementById("parar").classList.remove("d-none");
    document.getElementById("parar").style.display = "inline"
    document.getElementById("acabou").style.display = "none"
    document.getElementById("jogarDeNovo").classList.add("d-none");
    document.getElementById("jogarDeNovo").classList.remove("d-flex");
    document.getElementById("voltar").classList.add("d-none");
    document.getElementById("voltar").classList.remove("d-flex");
}

function atualizarV() {
    document.getElementById("cS").textContent = "Sorrisos capturados: " + sorrisos;
    document.getElementById("jcS").textContent = "Sorrisos capturados: " + sorrisos;
}

$("#inicio").submit(function (event) {

    event.preventDefault();

    let dificuldade = $("#dificuldade");
    let tamanho = $("#tamanho");

    if (dificuldade.val() === "0" || tamanho.val() === "0") {
        document.getElementById("error").textContent = "Selecione pelo menos uma opção dos dois seletores!";
        return;
    }

    if ((dificuldade.val() === "4" && $("#ipdif").val() === "") || (tamanho.val() === "4" && $("#ipm").val() === "")) {
        document.getElementById("error").textContent = "Preencha o campo personalizado!";
        return;
    }



    switch (dificuldade.val()) {
        case "1":
            jogo.segundos = 2;
            break;
        case "2":
            jogo.segundos = 1;
            break
        case "3":
            jogo.segundos = 0.5;
            break;
        case "4":
            jogo.segundos = parseFloat($("#ipdif").val())
            break;
        default:
            document.getElementById("error").textContent = "Coloque um número nos campos personalizados";
            return;
    }


    switch (tamanho.val()) {
        case "1":
            for (let i = 0; i < 3**2; i++) {
                jogo.malha.push("");
                const span = document.createElement('span');
                span.id = i + "";
                document.getElementById("malha").appendChild(span);
            }
            break;
        case "2":
            for (let i = 0; i < 5**2; i++) {
                jogo.malha.push("");
                const span = document.createElement('span');
                span.id = i + "";
                document.getElementById("malha").appendChild(span);
            }
            break
        case "3":
            for (let i = 0; i < 10**2; i++) {
                jogo.malha.push("");
                const span = document.createElement('span');
                span.id = i + "";
                document.getElementById("malha").appendChild(span);
            }
            break;
        case "4":
            let tam = parseInt($("#ipm").val())
            if (tam <= 0) {
                document.getElementById("error").textContent = "Coloque um número natural nos campos personalizados!";
                return;
            }
            if (tam > 10) {
                document.getElementById("error").textContent = "Coloque um tamanho menor na malha!";
                return;
            }
            for (let i = 0; i < tam**2; i++) {
                jogo.malha.push("");
                const span = document.createElement('span');
                span.id = i + "";
                document.getElementById("malha").appendChild(span);
            }
            break;

    }


    const malha = document.getElementById('malha');
    const spans = document.querySelectorAll('span');
    const totalSquares = spans.length;

    const gridSize = Math.sqrt(totalSquares);
    malha.style.gridTemplateColumns = `repeat(${gridSize}, 1fr)`;
    malha.style.gridTemplateRows = `repeat(${gridSize}, 1fr)`;


    $('#malha').children().each( function (event) {

        let child = this;

        $(child).on("click", function (event) {
            if (jogo.isRunning) {
                if (jogo.malha[parseInt(child.id)] !== "") {
                    if (!pegados.includes(child.id)) {
                        child.textContent = ":("
                        pegados.push(child.id)
                        sorrisos++;
                    }
                    setTimeout(function () {
                            pegados.splice(pegados.indexOf(child.id), 1)
                        }, 2000
                    )
                    atualizarV();
                }
            }
        })
    })

    comecar();

    jogo.isRunning = true;
    rodar();


})


$("#dificuldade").on("change", function (event) {
    if (this.value === "4") {
        $("#persdif").removeClass("d-none");
        return;
    }
    $("#persdif").addClass("d-none");
})
$("#tamanho").on("change", function (event) {
    if (this.value === "4") {
        $("#persm").removeClass("d-none");
        return;
    }
    $("#persm").addClass("d-none");
})

let randomAgora = 0

function rodar() {

    setTimeout( function () {
        if (!jogo.isRunning || randomAgora === -1) return;

        jogo.malha[randomAgora] = ""
        if (!pegados.includes(randomAgora)) {
            document.getElementById("malha").children[randomAgora].textContent = ""
            document.getElementById("malha").children[randomAgora].classList.remove("span-bixo")
        }
        let random = Math.random() * 100
        if (random <= 60) {
            randomAgora = Math.floor(Math.random() * (jogo.malha.length - 1));

            if (!pegados.includes(randomAgora)) {

                jogo.malha[randomAgora] = ":D"
                document.getElementById("malha").children[randomAgora].classList.add("span-bixo")
                document.getElementById("malha").children[randomAgora].textContent = ":D"
            }
        }

        rodar();
    }, jogo.segundos * 1000)
}

$("#parar").on("click", function (event) {
    if (jogo.isRunning) {
        acabarJogo();
    }
})
$("#jogarDeNovo").on("click", function () {
    jogo.isRunning = true
    comecar();
    rodar();
})

$("#voltar").on("click", function (event) {
    document.getElementById("jogo").classList.remove("d-flex");
    document.getElementById("jogo").classList.add("d-none");
    document.getElementById("inicio").classList.remove("d-none");
    document.getElementById("inicio").classList.add("d-flex");
    jogo.malha = []
    jogo.segundos = 0
    $("#malha").html("");
})

function acabarJogo() {
    jogo.isRunning = false;
    document.getElementById("parar").classList.remove("d-flex");
    document.getElementById("parar").classList.add("d-none");
    document.getElementById("acabou").display = "flex !important";
    document.getElementById("jogarDeNovo").classList.remove("d-none");
    document.getElementById("jogarDeNovo").classList.add("d-flex");
    document.getElementById("voltar").classList.remove("d-none");
    document.getElementById("voltar").classList.add("d-flex");
}


atualizarV();