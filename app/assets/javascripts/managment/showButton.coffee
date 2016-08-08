$(document).ready ->
  $('#inventories-list tr').on 'mouseover', (e)->
    $('#inventories-list').find('#delButton').removeClass('hidden')