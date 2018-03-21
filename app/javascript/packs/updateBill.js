function updateTick(){

}

function getOrders(){
  const billId = document.getElementById("bill-container").dataset.billId;
  fetch(`/bills/${billId}/orders`).then(response => response.json()).then((data) => {
      data.orders.forEach((order) => {
        updateTick(order.id);
      })
    });
}

document.addEventListener("DOMContentLoaded", () => {
  getOrders();
})
