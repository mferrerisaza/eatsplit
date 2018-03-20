// window.updateBill = function updateBill(event) {
//   console.log(event.target);
//   let val = document.getElementById("price-" + event.target.id).innerText;
//   let val2 = parseFloat(val.slice(1));
//   let total = document.getElementById("total");
//   let totalnum = parseFloat(total.innerText);
//   total.innerText = (totalnum + val2).toFixed(2);
//   console.log(totalnum);
// }


// On a click of one of the checkboxes

// Loop over the innerHTML's of the prices QuerySelectorAll
// if statement, to see if checked,
// outside of the loop, you have a counter
// In the end, counter is the total


function addListenerToBillies(){
  const billies = document.querySelectorAll(".billy3:not(.paid)");
  if (billies) {
    billies.forEach(function(billy){
      billy.addEventListener("click", (event) => {
        setInterval(updateBill, 300);
        // submit the form remotely with ajax
      })
    })
  }
}

function addListenerToCheckboxes(){
  const checkboxes = document.querySelectorAll(".order-checkbox");
  if (checkboxes) {
    checkboxes.forEach(function(checkbox){
      checkbox.addEventListener("change", (event) => {
        Rails.fire(document.querySelector(".edit_bill"), 'submit');
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



// }

// function updatePaid(){
//   if (document.getElementById('check').checked) {

//   } else {

//   }
// }



document.addEventListener("DOMContentLoaded",()=>{
  if (document.getElementById("bill-total-display")) {
    updateBill();
    addListenerToBillies();
    addListenerToCheckboxes();
  }
})



