/**
 * Created by user on 03.08.16.
 */
$(document).ready(function() {
  
  newInvertory = function () {
    $('.modal').modal('show');
    destroy();
  };

  editInvertory = function (ok) {
    $('.modal').modal('show');
    user_id.value = ok;

  };

 function destroy() {

    document.getElementById('form').reset();

 }
$('#create').on('click', function (e) {
 e.preventDefault();
  $.ajax('/managment/inventories', {
    type: 'POST',
    data: $('form').serialize(),
    success: function () {
      $('.modal').modal('hide');
    }
  });
})
});