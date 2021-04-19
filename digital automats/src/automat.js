var q = 0
var lamda = 0
const crosses = [[[1, 2, 3], [0, 0, 0]],
[[0, 0, 0], [3, 1, 2]],
[[0, 0, 0], [2, 3, 1]],
[[0, 0, 0], [1, 2, 3]]]
const states = ["Ожидание нового кона", "Камень у И-1", "Ножницы у И-1", , "Бумага у И-1"]
const results = ["Игра не закончена", "Победил И-1", "Победил И-2", "Ничья"]

document.addEventListener("DOMContentLoaded", function () {
    updateUI(q, lamda);
});

function changeState(signal) {
    lamda = crosses[q][1][signal]
    q = crosses[q][0][signal]
    updateUI(q, lamda)
}
function updateUI(p_q, p_lamda) {
    turnInput = document.getElementById("nameInput")
    if (p_q == 0) {
        turnInput.value = "Игрок 1"
    } else {
        turnInput.value = "Игрок 2"
    }
    stateInput = document.getElementById("stateInput")
    stateInput.value = states[p_q]
    resultInput = document.getElementById("resultInput")
    resultInput.value = results[p_lamda]
}
