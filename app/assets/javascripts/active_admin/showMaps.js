$(document).ready(function() {
   showMaps = function(id) {
    $('#maps-modal').modal('show');
    $('#maps-modal').on('shown.bs.modal', function () {
      google.maps.event.trigger(map, 'resize');
      initMap(id);
    });
  };

  function initMap(id) {
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 10
    });
    
    var service = new google.maps.places.PlacesService(map);
    service.getDetails({
      placeId: id
    }, function(place, status) {
      if (status === google.maps.places.PlacesServiceStatus.OK) {
        var marker = new google.maps.Marker({
          map: map,
          position: place.geometry.location
        });
        var lat = place.geometry.location.lat();
        var lng = place.geometry.location.lng();
        map.panTo(new google.maps.LatLng( lat, lng));
      }
    });

  }
});