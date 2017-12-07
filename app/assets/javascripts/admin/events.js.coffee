$(document).ready ->

  default_options = {
    lang: 'ru',
    header: {
      center: "title",
      right: "prev today next",
      left: "listWeek, agendaWeek, month",
      defaultView: "month",
    },
    events: 'calendars.json'
  }

  default_options_user_calendar = {
    lang: 'ru',
    header: {
      center: "title",
      right: "prev today next",
      left: "agendaWeek, month, listYear, addEvent",
      defaultView: "listYear",
    },
    customButtons: addEvent:
      text: 'Добавить событие'
      click: ->
        url = document.URL
        userId = url.match(/\/admin\/users\/(\d*)/)
        window.location.href = '/admin/user_events/new?user_id='+ userId[1]

    eventAfterAllRender: ->
      addAndRemoveHeader()

    events: 'calendars.json'
  }

  if $('.full-calendar').length > 0
    $("#fullCalendar").fullCalendar(
      default_options
    )
  else if $('.user-calendar').length > 0
    $("#fullCalendar").fullCalendar(
      default_options_user_calendar
    )

  addAndRemoveHeader= () ->
    $('.fc-right').find('.m-t-none').remove()
    $('.fc-right').find('.line').remove()
    $('.fc-prev-button').before(
      '<h3 class="m-t-none">отпуск</h3><span class="line line-red"></span>'+
        '<h3 class="m-t-none">отгул</h3><span class="line line-blue"></span>' +
        '<h3 class="m-t-none">прогул</h3><span class="line line-green"></span>'
    )


