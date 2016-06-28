'use strict';

class worldtimeController {
  constructor($http, $interval, $window) {

    var key = 'AIzaSyD-WiMcT6mKg0Fs-YOymfUFNP0RFi7wOD0';
    this.markers = [];
    var date =  new Date();
    this.selectedTime = moment(date).format('MMMM Do YYYY, HH:mm:ss');
    this.localTime = moment(date).format('MMMM Do YYYY, HH:mm:ss');
    var timerStart;
    var controllerThis = this;

    this.start = ()=> {
      this.localTime = moment(new Date()).format('MMMM Do YYYY, HH:mm:ss');
    }

    this.stop = ()=>{
      $interval.cancel(timerStart);
    }

    this.timeUpdate = ()=>{
      timerStart = $interval(this.start, 1000);
    }
    this.timeUpdate();

    this.map = new google.maps.Map(document.getElementById('map'), {
      center: {
        lat: 0,
        lng: 0
      },
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      navigationControl: false,
      mapTypeControl: false,
      scaleControl: false,
      draggable: false,
      zoom: 2,
      panControl: false,
      streetViewControl: false,
      zoomControl: false,
      scrollwheel:  false,
      disableDoubleClickZoom: true
    });
    this.map.addListener('click', (event)=>{
      this.addMarker(event);
      this.getTimeZone(event);
    });

    this.addMarker = (location) => {
      this.setMapOnAll(null);
      var marker = new google.maps.Marker({
        position:{
          lat: location.latLng.lat(),
          lng: location.latLng.lng()
        },
        map: this.map
      });
      this.markers.push(marker);
    }

    this.setMapOnAll = (map)=> {
      for (var i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(map);
      }
    }

    this.getTimeZone = (location)=> {
      $http.get('https://maps.googleapis.com/maps/api/timezone/json?location='
                 + location.latLng.lat() + ',' + location.latLng.lng()
                 + '&timestamp=1331766000&language=es&key=' + key)
      .then((response)=>{
        var timeZoneId = response.data.timeZoneId;
        this.stop();
        this.timeUpdate();
        this.selectedTime = moment(new Date()).tz(timeZoneId).format('MMMM Do YYYY, HH:mm:ss');

      });
    }

    controllerThis.boolChangeClass = false;

    angular.element($window).bind("scroll", function() {
      if (this.pageYOffset >= 27) {
        controllerThis.boolChangeClass = true;
        console.log(this.pageYOffset);
      } else {
        controllerThis.boolChangeClass = false;
        console.log(this.pageYOffset);
      }
    });




  }

}

angular.module('ngSpaApp')
  .controller('worldtimeController', worldtimeController);