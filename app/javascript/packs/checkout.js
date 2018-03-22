function addCheckoutListener() {
  const basket = document.getElementById("checkout-basket");
  if (basket) {
    basket.addEventListener("click", (event) => {
      event.currentTarget.classList.add("hidden");
      document.querySelector(".checkout-page-container").classList.remove("hidden");
      document.querySelector(".navbar-eatsplit").setAttribute("style", "z-index: auto;");
      console.log("HIIII");
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
      document.querySelector("navbar-eatsplit").setAttribute("style", "z-index: 1;");
      console.log("BYYYE");
    })
  }
}

document.addEventListener("DOMContentLoaded", () => {
  addCheckoutListener();
  addCloseCheckoutListener();
})
