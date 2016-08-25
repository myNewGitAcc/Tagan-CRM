/**
 * Created by user on 03.08.16.
 */
$(document).ready(function() {

  newInvertory = function () {
    $('.newModal').modal('show');
  };

  deleteInvertory = function () {
    $('.deleteModal').modal('show');
    
  };

  $('#createInventories').on('click', function (e) {
    $('#quantity_of_free').attr("value", $('#quantity_in_stock').val());
    e.preventDefault();
    $.ajax('/inventories/create', {
      type: 'POST',
      datatype: 'json',
      contenType: 'application/json',
      data: $('#form').serialize(),
      success: function (data) {
        var number_id = +$('tbody').find('tr').last().find('td').first().text();
        if (data.result == 'create') {
          var tr = $('<tr><td>' + (data.id) + '</td><td>' +
            $('#inventory_name').val() + '</td><td>' +
            $('#quantity_in_stock').val() + '</td><td>' +
            (data.quantity_in_stock - data.quantity) + '</td></tr>');
          $('tbody').append(tr);
        }
        else {
          $('tbody').find('td:contains(' + $('#inventory_name').val() + ')').each(function () {
            if ($(this).html() == $('#inventory_name').val()) {
              var currentValue = +$(this).next().text();
              $(this).next().text(+data.quantity + currentValue);
            }
          });
        }
        toastr.success('New inventory added');
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

  $('tbody').on( 'click', '#selected', function () {
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

  $('#deleteInventory').click( function (e) {
    var pos = $('.selected')
    var id = $('.selected').find('td').first().text();
    e.preventDefault();
    $.ajax('/inventories/destroy_inventory', {
      type: 'DELETE',
      datatype: 'json',
      contenType: 'application/json',
      data:{ "id": id },
      success: function() {
        pos.remove();
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

  $('#deleteQuantity').click( function (e) {
    var pos = $('.selected')
    var id = $('.selected').find('td').first().text();
    e.preventDefault();
    $.ajax('/inventories/destroy_quantity', {
      type: 'DELETE',
      datatype: 'json',
      contenType: 'application/json',
      data:{ "id": id, "quantity": $('#quantity').val() },
      success: function(data) {
        var free = +pos.find('td').last().text();
        var qtt  = +pos.find('td').last().prev().text()
        pos.find('td').last().prev().text(qtt - data.free);
        pos.find('td').last().text(free - data.free);
        toastr("")
        $('.modal').modal('hide');
      },
      error: function (e) {
        console.log(e);
      }
    });
  });

});