let jogo = {
    isRunning: false,
    type: "bot",
    turn: "x",
    malha: [
        "","","",
        "","","",
        "","",""
    ]
}

let vitoriaX = 0;
let vitoriaO = 0;
function toggle(id) {
    document.getElementById(id).checked = false;
}

$('#inicio').submit(function (event) {
    event.preventDefault();
    let botInput = document.getElementById("bot");
    let defaultInput = document.getElementById("default");
    if (!botInput.checked && !defaultInput.checked) {
        document.getElementById("error").style.display = "inline";
        return;
    }
    comecarJogo(botInput.checked ? "bot" : "default")

})

$('#malha').children().each(function () {
    let child = this;
    $(child).mouseover(function () {
        if (jogo.isRunning) {
            if (jogo.malha.at(parseInt(child.id) - 1) === "") {
                child.classList.add("span-hover");
            } else {
                child.classList.remove("span-hover");
            }
        }
    })
    $(child).mouseout(function () {
        child.classList.remove("span-hover");
    })

    $(child).on("click", function (event) {
        if (jogo.isRunning) {
            if (jogo.malha.at(parseInt(child.id) - 1) === "") {

                jogar(child,false)

                return;
            }
            event.preventDefault();
        }
    })
})

$("#parar").on("click", function (event) {
    if (jogo.isRunning) {
        acabarJogo();
    }
})
$("#jogarDeNovo").on("click", function (event) {
    if (!jogo.isRunning) {
        comecarJogo()
    }
})
$("#voltar").on("click", function (event) {
    atualizarV();
    document.getElementById("jogo").style.display = "none";
    document.getElementById("inicio").style.display = "flex";
})

function verificarVitoria() {
    const winPatterns = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ];

    for (const pattern of winPatterns) {
        const [a, b, c] = pattern;
        if (jogo.malha[a] === jogo.malha[b] && jogo.malha[a] === jogo.malha[c] &&
            jogo.malha[a] !== "" && jogo.malha[a] !== "") {
            return true;
        }
    }

    return false;
}
function jogarBot() {
    let id = Math.floor(Math.random() * 8);
    if (jogo.malha[id] === "") {
        jogar(document.getElementById(id + 1 + ""), true);
        return;
    }
    jogarBot();
}
function jogar(child, bot) {
    jogo.malha[parseInt(child.id) - 1] = jogo.turn;
    child.innerHTML = jogo.turn === "x" ? "<img src='imgs/x.png' height='80%'>" : "<img src='imgs/o.png' height='80%'>"

    if (verificarVitoria()) {
        window.alert("Vitória do " + jogo.turn.toUpperCase());
        document.getElementById("vez").textContent = "Vitória de: " + jogo.turn.toUpperCase();
        acabarJogo();
        if (jogo.turn === "x") {
          vitoriaX++;
          return;
        }
        if (jogo.type !== "bot") vitoriaO++;
        return;
    }
    if (!jogo.malha.includes("")) {
        window.alert("Deu velha!");
        document.getElementById("vez").textContent = "Vitória de ninguém!";

        acabarJogo();
        return;
    }

    jogo.turn = jogo.turn === "x" ? "o" : "x";
    document.getElementById("vez").textContent = "Vez de: " + jogo.turn.toUpperCase();
    if (jogo.type === "bot" && !bot) jogarBot();
}
function comecarJogo(type) {

    jogo.type = type;
    jogo.turn = "x";
    jogo.isRunning = true;

    $('#malha').children().each(function () {
        this.innerHTML = "";
    })

    document.getElementById("parar").classList.add("d-flex");
    document.getElementById("parar").classList.remove("d-none");
    document.getElementById("inicio").style.display = "none"
    document.getElementById("error").style.display = "none";
    document.getElementById("jogo").style.display = "flex"
    document.getElementById("parar").style.display = "inline"
    document.getElementById("acabou").style.display = "none"
    document.getElementById("jogarDeNovo").classList.add("d-none");
    document.getElementById("jogarDeNovo").classList.remove("d-flex");
    document.getElementById("voltar").classList.add("d-none");
    document.getElementById("voltar").classList.remove("d-flex");
    document.getElementById("vez").textContent = "Vez de: " + jogo.turn.toUpperCase();


}
function acabarJogo() {
    jogo.isRunning = false;
    jogo.malha = [
        "","","",
        "","","",
        "","",""
    ]
    document.getElementById("parar").classList.remove("d-flex");
    document.getElementById("parar").classList.add("d-none");
    document.getElementById("acabou").display = "flex";
    document.getElementById("jogarDeNovo").classList.remove("d-none");
    document.getElementById("jogarDeNovo").classList.add("d-flex");
    document.getElementById("voltar").classList.remove("d-none");
    document.getElementById("voltar").classList.add("d-flex");
}

function atualizarV() {
    document.getElementById("vX").textContent = "Vitórias X: " + vitoriaX;
    document.getElementById("vO").textContent = "Vitórias O: " + vitoriaO;
}
atualizarV();