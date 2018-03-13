

function autocomplete() {
        console.log("Hello gurlllllll")
  document.addEventListener("DOMContentLoaded", function() {
    const restaurantAddress = document.getElementById('restaurant_address');

    if (restaurantAddress) {
      console.log("Hello gurlllllll")
      const autocomplete = new google.maps.places.Autocomplete(restaurantAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(restaurantAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
