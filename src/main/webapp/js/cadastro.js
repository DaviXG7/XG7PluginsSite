function verificar() {
    let input = document.getElementById("password");
    let inputConfirmar = document.getElementById("confirmarSenha");

    let tamanho = document.getElementById("caractere");
    let caixaalta = document.getElementById("caixaalta");
    let caractere = document.getElementById("senhasIguais");

    let inputLenght = input.value.length > 7;
    let inputChar = /[A-Z]/.test(input.value); // Verifica se há pelo menos uma letra maiúscula
    let igual = input.value === inputConfirmar.value;

    tamanho.classList.toggle("bi-check-circle", inputLenght);
    tamanho.classList.toggle("bi-exclamation-circle", !inputLenght);
    tamanho.style.color = inputLenght ? "green" : "red";

    caixaalta.classList.toggle("bi-check-circle", inputChar);
    caixaalta.classList.toggle("bi-exclamation-circle", !inputChar);
    caixaalta.style.color = inputChar ? "green" : "red";

    caractere.classList.toggle("bi-check-circle", igual);
    caractere.classList.toggle("bi-exclamation-circle", !igual);
    caractere.style.color = igual ? "green" : "red";

    return igual && inputChar && inputLenght;
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
$('form').submit(function (event) {
    let txtnome = $('#nome').val();
    let txtsenha = $('#password').val();
    let txtemail = $('#email').val();
    let txtconfirmarSenha = $('#confirmarSenha').val();
    let txttermos = $('#termos').val();

    $(this).find('[type="submit"]').addClass("disabled");
    $.post("cadastro", {
        nome: txtnome,
        senha: txtsenha,
        email: txtemail,
        confirmarSenha: txtconfirmarSenha,
        termos: txttermos
    }).fail(function (error) {
        window.alert(error)
    })
})