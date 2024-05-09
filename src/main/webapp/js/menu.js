function toggleMenu(id, togglevaule1, togglevalue2) {
    let menu = document.getElementById(id);
    if (menu.style.display === togglevaule1 || menu.style.display === "") {
        menu.style.display = togglevalue2;
    } else {
        menu.style.display = togglevaule1;
    }
}