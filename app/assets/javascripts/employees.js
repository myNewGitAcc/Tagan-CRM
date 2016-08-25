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
  };

  function destroy() {
    document.getElementById('form').reset();
    var option = $('#employee_inventory').find('option');
    option.remove();
  }

  $('#createEmployees').on('click', function (e) {
    $('#employee_inventory_name').attr("value", $('#employee_inventory_id option:selected').text());
    e.preventDefault();
    $.ajax('/employees/create', {
      type: 'POST',
      datatype: 'json',
      contenType: 'application/json',
      data: $('#form').serialize(),
      success: function () {
        toastr.success('Inventory is added to the user')
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
    // e.preventDefault();
    var id = +$(this).closest('td').text();
    var pos = $(this);
    $.ajax('/employees/insert_data', {
      type: 'GET',
      datatype: 'json',
      contenType: 'application/json',
      data: {"user_id": id},
      success: function (data) {
        if(data.result.length > 0){
        var table = $('<tr class="inventory"><td class="fistTd"></td><td colspan="2"><table class="table-bordered col-md-12 table-hover">' +
          '<thead><th>#</th><th>Inventory</th><th>Data of Receipt</th><th>Quantity</th></thead><tbody></tbody></table></td></tr>');
        pos.closest('tr').after(table);
        $(data.result).each(function (i) {
          var insertInventory = $('<tr  id="selected"><td>'+(data.result[i].id)+'</td><td>'+(data.result[i].inventory_name)+
            '</td><td>'+(data.result[i].date_of_receipt)+'</td><td>'+
            (data.result[i].quantity)+'</td></tr>');
          pos.closest('tr').next('.inventory').find('tbody').append(insertInventory)
        });
        } else {
          var table = $('<tr class="inventory"><td class="fistTd"></td><td colspan="2"><table class="table-bordered col-md-12   ">' +
            '<thead><th>Inventories not found for user</th></thead>');
          pos.closest('tr').after(table);
        }
        pos.removeClass('spoiler');
        pos.addClass('active');
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
      data:{ "id": id, "quantity": $('#quantityDelete').val() },
      success: function(data) {
        console.log(data);
        if (data.qtt > 0) {
          var x = +pos.find('td').last().text();
          pos.find('td').last().text(x - data.quantity);
          $('.modal').modal('hide');
        }else{
          $('.modal').modal('hide');
          pos.remove(); 
        }
      },
      error: function (e) {
        console.log(e);
      }
    });
  });
  
});
