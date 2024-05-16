function getTamanhoDaTela() {
    var largura = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    if (largura > 700) {
        document.getElementById("barra-lateral").style.display = "flex";
    }
}
window.addEventListener("resize", getTamanhoDaTela);