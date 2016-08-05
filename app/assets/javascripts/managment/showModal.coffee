$(document).ready ->

  $("#inventories-list tr").on "click", (e) ->
    show_url = $(@).attr('href')
    e.preventDefault()
    $.ajax show_url,
      type: 'GET'
      dataType: "json"
      success: (r) ->
        console.log r
        $('#edit_id').val(r.id)
        $('#inventory_type_id').val(r.type.id)
        unless r.user == null
          $('#inventory_user_id').val(r.user.id)
        $('#edit_part').val(r.inventory_id)

        $('#edit_inventories').modal 'show'
      error: (e) ->
        console.log(e)
    return
   

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
    $('#add_img').fileupload
      dataType: 'json'
      add: (e, data) ->
        data.context = $('<button/>').text('Upload').appendTo(document.body).click(->
          data.context = $('<p/>').text('Uploading...').replaceAll($(this))
          data.submit()
          return
        )
        return
      done: (e, data) ->
        data.context.text 'Upload finished.'
        return


#  $('#createInventories').on 'click', (e) ->
#    e.preventDefault()
#    data = $('.inv_form').serialize()
#    $.ajax '/managment/inventories',
#      type: 'POST'
#      dataType: "json"
#      data: data
#      success: () ->
#        $('#inventoriesmodal').modal 'hide'
#      error: (e) ->
#        console.log(e)
#        return

  $('#updateInventories').on 'click', (e) ->
    e.preventDefault()
    console.log('updateInventories')

  return