function getUserLocation(){
  navigator.geolocation.getCurrentPosition(function(position){
    const array = [position.coords.latitude,position.coords.longitude];
    console.log(array);
  })
  $.ajax({
         url : `/location?data=${array}`,
     });
}
document.addEventListener("DOMContentLoaded", () => {
  // getUserLocation();
})
