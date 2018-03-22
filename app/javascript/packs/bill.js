
function addListenerToCheckboxes(){
  const orderItems = document.querySelectorAll(".bill-order-card:not(.paid)");
  if (orderItems) {
    orderItems.forEach(function(orderItem){
      orderItem.addEventListener("click", (event) => {

        const totalPriceElt = event.currentTarget.querySelector(".total-price");
        toggleCheckedStatus(totalPriceElt);
        updateBill();
      })
    })
  }
}

function toggleCheckedStatus(totalPriceElt){
  totalPriceElt.dataset.checked = (totalPriceElt.dataset.checked == "false" ? "true" : "false");
}

function updateBill() {
  let val = document.querySelectorAll(".order-status-amount");
  let counter = 0;
  val.forEach(function(element) {
    const priceTotalElt = element.querySelector(".total-price");
    if (priceTotalElt) {
      let priceVal = parseFloat(priceTotalElt.innerText.slice(1));
      console.log(priceVal)
      let checkedStatus = priceTotalElt.dataset.checked;
      console.log(checkedStatus)
      if (checkedStatus == "true") {
        counter += priceVal;
        let border = element.parentElement;
        border.classList.add("borderstyle");
      } else {
        let border = element.parentElement;
        border.classList.remove("borderstyle");
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
    addListenerToCheckboxes();
  }
})



