
function addListenerToCheckboxes(){
  const checkboxes = document.querySelectorAll(".order-checkbox");
  if (checkboxes) {
    checkboxes.forEach(function(checkbox){
      checkbox.addEventListener("change", (event) => {
        Rails.fire(document.querySelector(".edit_bill"), 'submit');
        updateBill();
      })
    })
  }
}

let val = document.querySelectorAll(".avatar-checkbox");
function updateBill() {
  let counter = 0;
  val.forEach(function(element) {
    const priceTotalElt = element.querySelector(".total-price");
    if (priceTotalElt) {
      let priceVal = parseFloat(priceTotalElt.innerText.slice(1));
      // let checkedStatus = element.querySelector(".check-container").firstElementChild.checked;
      let checkedStatus = element.parentElement.parentElement.parentElement.previousElementSibling.querySelector("label input").checked;
      if (checkedStatus == true) {
        counter += priceVal;
        let border = element.parentElement.parentElement;
        border.classList.add("borderstyle");
      } else {
        let border = element.parentElement.parentElement;
        border.setAttribute("class", "billy3");
      }
    }
  });

  let total = document.getElementById("total");
  total.innerText = counter.toFixed(2);
  document.getElementById("stripe-amount").value = counter * 100;
}

document.addEventListener("DOMContentLoaded",()=>{
  if (document.getElementById("bill-total-display")) {
    updateBill();
    // addListenerToBillies();
    addListenerToCheckboxes();
  }
})



