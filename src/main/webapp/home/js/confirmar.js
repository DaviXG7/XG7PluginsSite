function abrirCerteza(link) {
    $("#confirm").removeClass("d-none");
    $("#sim").attr("href", link);
}
function fecharCerteza() {
    $("#confirm").addClass("d-none");
    $("#sim").attr("href", "");
}