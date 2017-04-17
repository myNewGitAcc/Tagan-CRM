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

  $("#fullCalendar").fullCalendar(
    default_options
  )