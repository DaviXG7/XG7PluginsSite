let toggle = false

function toggleMenu(style,sair) {
    var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    if (largura <= 700) {
        document.getElementById("barra").style.left = sair ? "-140px" : "0";
        document.getElementById("tela").style.display = style;
        document.getElementById("barra").classList.add(sair ? "out-barra" : "in-barra");
        document.getElementById("barra").classList.remove(!sair ? "out-barra" : "in-barra");
        document.getElementById("tela").classList.add(sair ? "" : "in-tela");}
}

function getTamanhoDaTela() {
    var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    if (largura > 700) {
        document.getElementById("barra").style.left = "0";
        toggle = true
        document.getElementById("tela").style.display = "none";
    } else {
        if (toggle) {
            document.getElementById("barra").style.left = "-140px";
            document.getElementById("barra").classList.remove("in-barra")
            document.getElementById("barra").classList.remove("out-barra")
            document.getElementById("tela").classList.remove("in-tela")
            document.getElementById("tela").classList.remove("out-tela")
            toggle = false;
        }
    }
}
window.addEventListener("resize", getTamanhoDaTela);

document.getElementById("hamburger").addEventListener("click", function () {toggleMenu("inline", false)});
document.getElementById("sairbarra").addEventListener("click", function () {toggleMenu("none", true)});
document.getElementById("tela").addEventListener("click", function () {toggleMenu("none", true)});