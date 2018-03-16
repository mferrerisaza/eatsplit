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
      event.currentTarget.classList.toggle("hidden")
      event.currentTarget.parentNode.parentNode.classList.add("dish-added")
      changeDishStatus(event.currentTarget);
      checkBasket(buttons);
    })
  })
}

function removeActiveClass(links){
  links.forEach(function(link){
    link.classList.remove("active-category");
  })
}

function addActiveClass(link){
  link.classList.add("active-category")
}

function addLinkListener() {
  const links = document.querySelectorAll(".menu-category-link");
  links.forEach(function(link) {
    link.addEventListener("click", (event) => {
      removeActiveClass(links);
      addActiveClass(event.currentTarget);
    })
  })
}

document.addEventListener("DOMContentLoaded", () => {
  addButtonListener();
  addLinkListener();
})
