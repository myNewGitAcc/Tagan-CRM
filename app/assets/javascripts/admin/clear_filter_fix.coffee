$ ->
  $('.clear_filters_btn').click ->
    location.search = location.search.split('&').filter(
      (s)->
        not s.match(/^(q\[|page|commit|order)/)
        return
    ).join '&'
