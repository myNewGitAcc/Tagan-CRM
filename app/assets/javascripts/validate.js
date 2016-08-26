/**
 * Created by user on 26.08.16.
 */
$(document).ready(function() {

  $('.rf').each(function(){
    // Объявляем переменные (форма и кнопка отправки)
    var form = $(this);
    // Добавляем каждому проверяемому полю, указание что поле пустое
    form.find('.rfield').addClass('empty_field');
  });

});

// Функция проверки полей формы
function checkInput(){
  $('#form').find('.rfield').each(function(){
    if($(this).val() != ''){
      // Если поле не пустое удаляем класс-указание
      $(this).removeClass('empty_field');
    } else {
      // Если поле пустое добавляем класс-указание
      $(this).addClass('empty_field');
    }
  });
  lightEmpty()
}

// Функция подсветки незаполненных полей
function lightEmpty(){
  $('#form').find('.empty_field').css({'border-color':'#d8512d'});
  //Через 3 сепкунды удаляем подсветку
  setTimeout(function(){
    $('#form').find('.empty_field').removeAttr('style');
  },3000);
}