 $(document).ready(function() {
   $('#new_user').keydown(function(event){
     if(event.keyCode == 13) {
       event.preventDefault();
       return false;
     }
   });

   var autocomplete;

   autocomplete = new google.maps.places.Autocomplete(
       (document.getElementById('user_live_in_city')),
       {types: ['geocode']});


   autocomplete.addListener('place_changed', fillInAddress);


   function fillInAddress() {

     var place = autocomplete.getPlace();
    console.log(place.place_id);
     $('#user_last_name').val(place.place_id)
   }

 });