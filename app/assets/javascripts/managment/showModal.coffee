$(document).ready ->

  this.addInventories = ->
    $('#inventoriesmodal').modal 'show'
    return

  this.addType = ->
    $('#typemodal').modal 'show'
    return

  $('#createType').on 'click', (e) ->
    e.preventDefault()
    $.ajax '/managment/types',
      type: 'POST'
      data: $('#types_v').serialize()
      success: () ->
        $('#typemodal').modal 'hide'
        optionname = $('#inventory_type_id').find('option').last()
        value = +optionname.val()

        ww ='<option value="' + (value + 1) + '">'+ $('#types_v').val()+ '</option>'
        optionname.after(ww)
        return
      error: (e) ->
        console.log(e)
    return


  $('#createInventories').on 'click', (e) ->
    e.preventDefault()
    $.ajax '/managment/inventories',
      type: 'POST'
      data: $('.inv_form').serialize()
      success: () ->
        $('#inventoriesmodal').modal 'hide'
      error: (e) ->
        console.log(e)
    return
  return