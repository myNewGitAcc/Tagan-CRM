function addScript(src){
  var script = document.createElement('script');
  script.src = src;
  script.async = false;
  document.head.appendChild(script);
}

addScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyB68HxZhd4Pxdsya_JvIT1qLSqzXWpWEI4&signed_in=true&libraries=places');
