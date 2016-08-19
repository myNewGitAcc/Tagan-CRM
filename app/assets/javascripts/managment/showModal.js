/**
 * Created by user on 03.08.16.
 */
$(document).ready(function() {
  
  newInvertory = function () {
    $('.newModal').modal('show');
    destroy();
  };

  deleteInvertory = function () {
    $('.deleteModal').modal('show');
    destroy();
  };

  function destroy() {
    document.getElementById('form').reset();
  }

  $('#create').on('click', function (e) {
    $('#quantity_of_free').attr("value", $('#quantity_in_stock').val());
    e.preventDefault();
    $.ajax('/managment/inventories', {
     type: 'POST',
     datatype: 'json',
     contenType: 'application/json',
     data: $('#form').serialize(),
     success: function (data) {
       console.log(data);
      var number_id =+ $('tbody').find('tr').last().find('td').first().text();
      if (data.result == 'create')
      {
        var tr = $('<tr><td>'+(data.id)+'</td><td>'+
                 $('#inventory_name').val()+ '</td><td>'+
                 $('#quantity_in_stock').val()+'</td><td>'+
                 (data.quantity_in_stock - data.quantity)+'</td></tr>');
        $('tbody').append(tr);
      }
      else
      {
        $('tbody').find('td:contains(' + $('#inventory_name').val() + ')').each(function () {
        if ($(this).html() == $('#inventory_name').val())
        {
          var currentValue = +$(this).next().text();
          $(this).next().text(+data.quantity + currentValue);
        }
        });
      }
      $('.modal').modal('hide');
     },
     error: function (e) {
       console.log(e);
     }
    });
  });

  $('tbody').on( 'click', 'tr', function () {
    if ( $(this).hasClass('selected') ) {
      $(this).removeClass('selected');
      $('#removeInv').addClass('disabled');
    }
    else {
      $('tr.selected').removeClass('selected');
      $(this).addClass('selected');
      $('#removeInv').removeClass('disabled');
    }
  });

  $('#delete_button').click( function (e) {
    var deleteStr = $('.selected').find('td').first().text();
    Delete(deleteStr,e);
  });

  function Delete(deleteStr, e){
    
    e.preventDefault();
    $.ajax('/managment/inventories', {
      type: 'DELETE',
      datatype: 'json',
      contenType: 'application/json',
      data:{ "id": deleteStr
      },
      success: function(data) {
        console.log(pos);
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  }

});