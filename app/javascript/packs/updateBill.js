// document.addEventListener("DOMContentLoaded", () => {
//   currentUserId =
//   fetch(api)
//   .then(function(orders){
//     orders.forEach(function(order){
//       if(order.user_id == currentUserId)
//     })
//   })
//   function()
//   updateYourBills();
//   updateOtherBills();
//   updatePaidBills();
// })

// `<div class='bill-card <%= order.status %>' >
//   <div class="bill-card-user">
//     <%=card_photo_or_generic(order.user)%>
//   </div>
//   <div class="bill-card-details">
//     <div class="center-text-align-left">
//       <p class="bill-card-details-dish"><%= order.dish.name %></p>
//       <p class="bill-card-order-user">Ordered by: <%= order.user.profile.name %></p>
//     </div>
//   </div>
//   <div class='order-status-amount'>
//     <% if order.status == "paid" %>
//       <div class="status-<%= order.status %>">PAID</div>
//     <% else %>
//       <div class='total-price' data-order-id="<%= order.id %>" data-checked=<%= order.user == current_user %>>
//         <%= humanized_money_with_symbol(order.amount) %>
//       </div>
//     <% end %>
//     <p class='total-price-details'>(<%= humanized_money_with_symbol(order.dish.price) %> x <%= order.quantity %>)</p>
//   </div>
// </div>`