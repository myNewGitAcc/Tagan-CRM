/**
 * Created by user on 10.08.16.
 */
$(document).ready(function() {

  $('#employee').on('click', function (e) {
    e.preventDefault();
    $.ajax('/managment/employees', {
      type: 'POST',
      datatype: 'json',
      contenType: 'application/json',
      data: $('#form').serialize(),
      success: function () {
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

  $('.spoiler').prepend('<img class="plus" src="http://www.iconsearch.ru/ajax/download.php?icon_id=24753&size=1&format=png"> ');

  $(document).on('click', '.active', function () {
    $(this).closest('#tbody').find('.insert').slideToggle(300);
    $(this).removeClass('active');
    $(this).addClass('spoiler');
  });

  $(document).on('click','.spoiler', function (e) {
    e.preventDefault();
    var id = +$(this).next().text();
    var pos = $(this);

    $.ajax('/managment/insert_data', {
      type: 'GET',
      datatype: 'json',
      contenType: 'application/json',
      data: {"user_id": id},
      success: function (data) {
        console.log(pos.closest('#tbody').find('.insert').remove());
          $(data.result).each(function (i) {
            var x = $('<tr class="insert"><td>'+(data.result[i].inventory_id)+
              '</td><td>'+(data.result[i].date_of_receipt)+'</td><td>'+
              (data.result[i].quantity)+'</td></tr>');
            pos.closest('tr').after(x);
          });
        pos.removeClass('spoiler');
        pos.addClass('active');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });
  
});