
//= require_tree ./managment

var ready;
ready = (function() {

  $("#inventory_name").autocomplete({
    source: '/inventories/autocomplete.json'
  });
  var ul = $("#ui-id-1")

    $('.test1').append(ul);
});
//
$(document).ready(ready);
$(document).on('page:load', ready);

