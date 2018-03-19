const array = []
function getUserLocation(){
  navigator.geolocation.getCurrentPosition(function(position){
    const array = [position.coords.latitude, position.coords.longitude];
    const url_data = `/location?data=${array}`;


    $.ajax({
           url : url_data,
       });
  })
}





// fetch(`/location?data="hello`, {
//   method: 'GET',
//   credentials: 'same-origin'
// }).then((response) => {
//   console.log(response)
// });

document.addEventListener("DOMContentLoaded", () => {
  getUserLocation();
})

