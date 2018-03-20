function addCheckoutListener() {
  const basket = document.getElementById("checkout-basket");
  if (basket) {
    basket.addEventListener("click", (event) => {
      event.currentTarget.classList.add("hidden");
      document.querySelector(".checkout-page-container").classList.remove("hidden");
    });
  }
}
function addCloseCheckoutListener() {
  const basket = document.getElementById("checkout-basket");
  const times = document.getElementById("checkout-closing");
  const buttons = document.querySelectorAll(".dish-card-btn");
  if (times) {
    times.addEventListener("click", (event) => {
      basket.classList.remove("hidden");
      document.querySelector(".checkout-page-container").classList.add("hidden");
      checkBasket(buttons);
    })
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addCheckoutListener();
  addCloseCheckoutListener();
})
