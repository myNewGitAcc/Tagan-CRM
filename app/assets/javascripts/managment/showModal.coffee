$(document).ready ->

  this.addType = ->
    $('.modal').modal 'show'
    return

  $('#create').on 'click', (e) ->
    e.preventDefault()
    $.ajax '/managment/types',
      type: 'POST'
      data: $('#types_v').serialize()
      success: (response) ->
        $('.modal').modal 'hide'
        return
      error: (e) ->
        console.log(e)
    return
  return