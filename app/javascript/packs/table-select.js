const tableCards = document.querySelectorAll(".table-card");

tableCards.forEach( (card) => {
  card.addEventListener("click", (event) => {
    removeSelectedClass()
    card.classList.add("table-card-selected")
  });
})



function removeSelectedClass() {
  tableCards.forEach( (card) => {
          if (card.classList.contains("table-card-selected")) {
            card.classList.remove("table-card-selected")
          };
        });
};
// Listen to the click
// Remove the active class whereever present
// Add it to where is clicked
