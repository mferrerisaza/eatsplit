const links = document.querySelectorAll("a");

const button = document.querySelector(".button3")


document.addEventListener("DOMContentLoaded",(event) => {
  // button.disabled = true
})



// function removeTableSelectedClass() {
//   tableCards.forEach( (card) => {
//           if (card.classList.contains("table-card-selected")) {
//             card.classList.remove("table-card-selected")
//           };
//         });
// };



links.forEach( (link) => {

  link.addEventListener("click", (event) => {
    // removeTableSelectedClass()
    const tableCard = link.querySelector(".table-card");
    tableCard.classList.add("table-card-selected");
        // button.disabled = false
    // button.classList.remove("btn-is-disabled")
    // button.value = "Join table"

  });
  });




