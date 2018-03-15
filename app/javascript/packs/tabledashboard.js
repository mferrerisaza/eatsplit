const collapseMenus = document.querySelectorAll(".panel");

collapseMenus.forEach(function(menu, index){

menu.addEventListener("click", (event) => {
  document.querySelectorAll(".tgl").forEach(function(toggle) {
      toggle.checked = false
  });
  let toggleSwitch = document.getElementById(`cb${index + 1}`);
  toggleSwitch.checked = !toggleSwitch.checked;
});

});
