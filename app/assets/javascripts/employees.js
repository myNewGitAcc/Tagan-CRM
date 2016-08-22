/**
 * Created by user on 10.08.16.
 */
$(document).ready(function() {

  newEmployee = function () {
    $('.newModal').modal('show');
    destroy();
  };

  deleteEmployee = function () {
    $('.deleteModal').modal('show');
    destroy();
    option();
  };

  function destroy() {
    document.getElementById('form').reset();
    var option = $('#employee_inventory').find('option');
    option.remove();
  }

  $('#createEmployees').on('click', function (e) {
    e.preventDefault();
    $.ajax('/employees/create', {
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

  $(document).on('click', '.active', function () {
    $(this).closest('tr').next('.inventory').remove();
    $(this).removeClass('active');
    $(this).addClass('spoiler');
  });

  $(document).on('click','.spoiler', function (e) {
    e.preventDefault();
    var id = +$(this).closest('td').text();
    var pos = $(this);
    $.ajax('/employees/insert_data', {
      type: 'GET',
      datatype: 'json',
      contenType: 'application/json',
      data: {"user_id": id},
      success: function (data) {
        var table = $('<tr class="inventory"><td class="fistTd"></td><td colspan="2"><table class="table-bordered col-md-12">' +
          '<thead><th>Inventory</th><th>Data of Receipt</th><th>Quantity</th></thead><tbody></tbody></table></td></tr>');
        pos.closest('tr').after(table);
        $(data.result).each(function (i) {
          var insertInventory = $('<tr><td>'+(data.result[i].inventory_name)+
            '</td><td>'+(data.result[i].date_of_receipt)+'</td><td>'+
            (data.result[i].quantity)+'</td></tr>');
          pos.closest('tr').next('.inventory').find('tbody').append(insertInventory)
        });
        pos.removeClass('spoiler');
        pos.addClass('active');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

   function option() {
     var id = +$('.selected').find('td').first().text();
     $.ajax('/employees/select', {
       type: 'GET',
       datatype: 'json',
       contenType: 'application/json',
       data: {"user_id": id},
       success: function (data) {
         $('select').append($('<option></option>'));
         $(data.result).each(function (i) {
           $('select').append($('<option>' + data.result[i].inventory_name + '</option>'));
         });
       },
       error: function (e) {
         console.log(e);
       }
     });
   };

  $('#deleteEmployee').click( function (e) {
    var pos = $('.selected')
    var user_id = +$('.selected').find('td').first().text();
    e.preventDefault();
    $.ajax('/employees/destroy_employee', {
      type: 'DELETE',
      datatype: 'json',
      contenType: 'application/json',
      data:{ "user_id": user_id },
      success: function() {
        // pos.remove();
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

  $('#deleteQtt').click( function (e) {
    var pos = $('.selected')
    var id = $('.selected').find('td').first().text();
    e.preventDefault();
    $.ajax('/employees/destroy_quantity', {
      type: 'DELETE',
      datatype: 'json',
      contenType: 'application/json',
      data:{ "id": id, "quantity": $('#quantity').val() },
      success: function(data) {

        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });
  
});
