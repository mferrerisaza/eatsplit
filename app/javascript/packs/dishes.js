function checkBasket(buttons) {
  let numberOfDishes = 0;
  buttons.forEach(function(button) {
    if(button.dataset.addToCart == "true") {
      numberOfDishes += 1;
    }
  })
  if(numberOfDishes>0) {
    const basket = document.getElementById("checkout-basket");
    basket.classList.remove("hidden");
    document.querySelector(".checkout-basket-counter").innerHTML = numberOfDishes
  }
}

function changeDishStatus(button) {
  button.dataset.addToCart = "true";
}

function addButtonListener() {
  const buttons = document.querySelectorAll(".dish-card-btn");
  buttons.forEach(function(button) {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      changeDishStatus(event.currentTarget);
      checkBasket(buttons);
    })
  })
}

document.addEventListener("DOMContentLoaded", () => {
  addButtonListener();
})
