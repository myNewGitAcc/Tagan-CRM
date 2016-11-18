$ ->
  $('.jsoneditor-target').each ->
    target = $ this
    container = $('<div class="jsoneditor-container">')
    .insertAfter target
    editor = new JSONEditor container[0],
      modes: ['code', 'form', 'text', 'tree', 'view']
      change: ->
        target.val editor.get()
    editor.set(
      try
        if $('.jsoneditor-target').val() == ''
          '{\"key\"=>\"value\"}'
        else
          $('.jsoneditor-target').val()
    )
    target.hide()