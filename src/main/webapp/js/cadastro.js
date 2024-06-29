function verificar() {
    let input = document.getElementById("password");
    let inputConfirmar = document.getElementById("confirmarSenha");

    let tamanho = document.getElementById("caractere");
    let caixaalta = document.getElementById("caixaalta");
    let caractere = document.getElementById("senhasIguais");

    let inputLenght = input.value.length > 7;
    let inputChar = /[A-Z]/.test(input.value); // Verifica se há pelo menos uma letra maiúscula
    let igual = input.value === inputConfirmar.value;
    let espaco = input.value.trim().includes(" ");

    return igual && inputChar && inputLenght && !espaco;
}

window.addEventListener("input", function (event) {
    let verificarSub = verificar() && document.getElementById("termos").checked;
    let submit = document.getElementById("cadsubmit");

    if (verificarSub) {
        submit.classList.remove("disabled");
    } else {
        submit.classList.add("disabled");
    }
});
$('form').submit(function(event) {
    $(this).find('[type="submit"]').addClass("disabled");
});

var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
})