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

function addListenerToCheckbox(){
  document.querySelectorAll(".checker").forEach(function(checkbox){
    checkbox.addEventListener("click", (event) => {
      updateBill();
    })
  })
}

function updateBill() {
  let val = document.querySelectorAll(".avatar-checkbox");
  let counter = 0;
  val.forEach(function(element) {
    let priceVal = parseFloat(element.querySelector(".total-price").innerText.slice(1));
    let checkedStatus = element.querySelector(".check-container").firstElementChild.checked;
    if (checkedStatus == true) {
      counter += priceVal;
    }
  });

  let total = document.getElementById("total");
  total.innerText = counter.toFixed(2);
}

document.addEventListener("DOMContentLoaded",()=>{
  updateBill();
  addListenerToCheckbox();
})
