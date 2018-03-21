const tableCards = document.querySelectorAll(".table-card");
const button = document.querySelector(".button3")


document.addEventListener("DOMContentLoaded",(event) => {
  button.disabled = true
})



function removeTableSelectedClass() {
  tableCards.forEach( (card) => {
          if (card.classList.contains("table-card-selected")) {
            card.classList.remove("table-card-selected")
          };
        });
};



tableCards.forEach( (card) => {
  card.addEventListener("click", (event) => {
    removeTableSelectedClass()
    card.classList.add("table-card-selected")
    button.disabled = false
    button.classList.remove("btn-is-disabled")
    button.value = "Join table"

  });
})



