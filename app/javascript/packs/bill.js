
var cloudinary = require('cloudinary');
document.addEventListener("DOMContentLoaded", () => {

  let billId;
  let currentUserId;
  let yourOrdersContainer;
  let otherOrdersContainer;
  let paidOrdersContainer;

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
        let checkedStatus = priceTotalElt.dataset.checked;
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


  function clearTheDom(){
    yourOrdersContainer.innerHTML = "";
    otherOrdersContainer.innerHTML = "";
    paidOrdersContainer.innerHTML = "";
  }

  function cardPhotoOrGeneric(profile){
    if (profile.photo.url){
      return cloudinary.image(profile.photo.url, {height: 300, width: 300, crop: "fill", gravity: "face", class: "bill-card-user-avatar"})
    } else{
      return cloudinary.image("http://res.cloudinary.com/dnf96fubu/image/upload/v1520418809/facebook-profile-picture-no-pic-avatar.jpg",
       {height: 300, width: 300, crop: "fill", gravity: "face", class: "bill-card-user-avatar"})
    }
  }

  function buildPaidOrders(order){
    if (paidOrdersContainer.childNodes.length === 0){
      paidOrdersContainer.insertAdjacentHTML("afterbegin",
        `<h4 class="bill-category">
          <i class="fas fa-check-square"></i>
          Paid orders
        </h4>`
      )
    }
    paidOrdersContainer.insertAdjacentHTML("beforeend",
      `<div class='bill-card ${order.status} %>'>
        <div class="bill-card-user">
          ${cardPhotoOrGeneric(order.user_profile)}
        </div>
        <div class="bill-card-details">
          <div class="center-text-align-left">
            <p class="bill-card-details-dish">${order.dish.name}</p>
            <p class="bill-card-order-user">Ordered by: ${order.user_profile.name}</p>
          </div>
        </div>
        <div class='order-status-amount'>
          <div class="status-${order.status} %>">PAID</div>
          <p class='total-price-details'> (€${parseFloat((order.dish.price_cents)/100).toFixed(0)} x ${order.quantity})</p>
        </div>
      </div>`
    )
  }

  function buildYourOrders(order){
    if (yourOrdersContainer.childNodes.length === 0){
      yourOrdersContainer.insertAdjacentHTML("afterbegin",
        `<h4 class="bill-category">
          <i class="fas fa-user"></i>
          Your unpaid orders
        </h4>`
      )
    }
    yourOrdersContainer.insertAdjacentHTML("beforeend",
    `<a class="bill-order-card" data-remote="true" rel="nofollow" data-method="put" href="/orders/${order.id}?update=toggle_check">
      <div class='bill-card ${order.status}'>
        <div class="bill-card-user">
          ${cardPhotoOrGeneric(order.user_profile)}
        </div>
        <div class="bill-card-details">
          <div class="center-text-align-left">
            <p class="bill-card-details-dish">${order.dish.name}</p>
            <p class="bill-card-order-user">Ordered by: ${order.user_profile.name}</p>
          </div>
        </div>
        <div class='order-status-amount'>
          <div class='total-price' data-order-id="${order.id}" data-checked=${order.user_id === currentUserId}>
            €${parseFloat((order.amount_cents)/100).toFixed(0)}
          </div>
          <p class='total-price-details'> (€${parseFloat((order.dish.price_cents)/100).toFixed(0)} x ${order.quantity})</p>
        </div>
      </div>
    </a>`
    )
  }
  function buildOtherOrders(order){
    if (otherOrdersContainer.childNodes.length === 0){
      otherOrdersContainer.insertAdjacentHTML("afterbegin",
        `<h4 class="bill-category">
          <i class="fas fa-users"></i>
          Other unpaid orders
        </h4>`
      )
    }
    otherOrdersContainer.insertAdjacentHTML("beforeend",
    `<a class="bill-order-card" data-remote="true" rel="nofollow" data-method="put" href="/orders/${order.id}?update=toggle_check">
      <div class='bill-card ${order.status}'>
        <div class="bill-card-user">
          ${cardPhotoOrGeneric(order.user_profile)}
        </div>
        <div class="bill-card-details">
          <div class="center-text-align-left">
            <p class="bill-card-details-dish">${order.dish.name}</p>
            <p class="bill-card-order-user">Ordered by: ${order.user_profile.name}</p>
          </div>
        </div>
        <div class='order-status-amount'>
          <div class='total-price' data-order-id="${order.id}" data-checked=${order.user_id === currentUserId}>
            €${parseFloat((order.amount_cents)/100).toFixed(0)}
          </div>
          <p class='total-price-details'> (€${parseFloat((order.dish.price_cents)/100).toFixed(0)} x ${order.quantity})</p>
        </div>
      </div>
    </a>`
    )
  }


  function getOrders(){
    clearTheDom();
    fetch(`/bills/${billId}/orders`).then(response => response.json()).then((data) => {
      data.orders.forEach((order) => {
          if (order.status === "paid"){
            buildPaidOrders(order);
          } else if (order.user_id === currentUserId){
            buildYourOrders(order);
          } else {
            buildOtherOrders(order);
          }
        });
        updateBill();
        addListenerToCheckboxes();
      })
  }

  if (document.getElementById("bill-total-display")) {

     billId = document.getElementById("bill-container").dataset.billId;
     currentUserId = parseInt(document.getElementById("bill-container").dataset.currentUserId,10);
     yourOrdersContainer = document.querySelector(".your-orders-container");
     otherOrdersContainer = document.querySelector(".other-orders-container");
     paidOrdersContainer = document.querySelector(".paid-orders-container");
    getOrders();
  }
})

