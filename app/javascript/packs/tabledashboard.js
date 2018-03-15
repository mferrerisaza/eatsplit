const collapseMenus = document.querySelectorAll(".panel");

collapseMenus.forEach(function(menu, index){

menu.addEventListener("click", (event) => {
  let toggleSwitch = document.getElementById(`cb${index + 1}`);
  toggleSwitch.checked = !toggleSwitch.checked;
});

});
