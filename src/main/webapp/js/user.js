function verificar() {
    let input = document.getElementById("novasenha");

    let tamanho = document.getElementById("caractere");
    let caixaalta = document.getElementById("caixaalta");

    let inputLenght = input.value.length > 7;
    let inputChar = /[A-Z]/.test(input.value); // Verifica se há pelo menos uma letra maiúscula

    tamanho.classList.toggle("bi-check-circle", inputLenght);
    tamanho.classList.toggle("bi-exclamation-circle", !inputLenght);
    tamanho.style.color = inputLenght ? "green" : "red";

    caixaalta.classList.toggle("bi-check-circle", inputChar);
    caixaalta.classList.toggle("bi-exclamation-circle", !inputChar);
    caixaalta.style.color = inputChar ? "green" : "red";

    return inputChar && inputLenght;
}

window.addEventListener("input", function (event) {verificar()});