$(document).ready(function(){
    $('.datepicker').datepicker({
        dateFormat: 'yy-mm-dd'
    });


    var startDate;
    var endDate;

    var selectCurrentWeek = function() {
      window.setTimeout(function () {
        $('.week-picker').find('.ui-datepicker-current-day a').addClass('ui-state-active')
      }, 1);
    };

    $('.week-picker').datepicker( {
      showOtherMonths: true,
      selectOtherMonths: true,
      onSelect: function(dateText, inst) {
        var date = $(this).datepicker('getDate');
        startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getUTCDay());
        endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 7);
        var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
        $('#startDate').text($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
        $('#endDate').text($.datepicker.formatDate( dateFormat, endDate, inst.settings ));

        selectCurrentWeek();

        $.ajax({
          url: '/admin/project_report/get_tracking_time',
          type: 'POST',
          data: {start_date: startDate, end_date: endDate},
          success: function (data) {
            $('#tracking-time-statistics-current-week_sidebar_section').children().first().text("Tracking Time Statistics " + data.start_data
              + ' - ' + data.end_data);
            for (var key in data.companies) {
              companyId = '#'+ data.companies[key]['id'];
              $('.project_report').find(companyId).children().text(data.companies[key]['time']);
            }

          },
          error: function (data) {
            console.log(data)
          }
        });
      },
      beforeShowDay: function(date) {
        var cssClass = '';
        if(date >= startDate && date <= endDate)
          cssClass = 'ui-datepicker-current-day';
        return [true, cssClass];
      },
      onChangeMonthYear: function(year, month, inst) {
        selectCurrentWeek();
      }
    });
    //
    // $('.week-picker .ui-datepicker-calendar tr').live('mousemove', function() { $(this).find('td a').addClass('ui-state-hover'); });
    // $('.week-picker .ui-datepicker-calendar tr').live('mouseleave', function() { $(this).find('td a').removeClass('ui-state-hover'); });
});