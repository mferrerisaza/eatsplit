const collapseMenus = document.querySelectorAll(".panel");

collapseMenus.forEach(function(menu, index){

menu.addEventListener("click", (event) => {
  let toggleSwitch = document.getElementById(`cb${index + 1}`);
  toggleSwitch.checked = !toggleSwitch.checked;
  document.querySelectorAll(".tgl").forEach(function(toggle) {
      if (toggle !== toggleSwitch) {
      toggle.checked = false
      }
  });
});

});




// const collapseMenuText = document.querySelectorAll(".toggle-text-container");

// collapseMenuText.forEach(function(menu, index){

// menu.addEventListener("click", (event) => {
//   let toggleSwitch = document.getElementById(`cb${index + 1}`);
//   toggleSwitch.checked = !toggleSwitch.checked;
//   document.querySelectorAll(".tgl").forEach(function(toggle) {
//       if (toggle !== toggleSwitch) {
//       toggle.checked = false
//       }
//   });
// });

// });
