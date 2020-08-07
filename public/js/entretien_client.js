$('#dateEntretien').click(function () {
  if ($('.hiddenDate').is(':visible')) {
    $('.hiddenDate').hide();
  } else {
    $('.hiddenDate').show();
    $('#datepicker').focus();
  }
});

$('.js-input-adresse').click(function () {
  let $input = $('#js-adresse_name_input');
  if ($(this).data().value == 'autre') {
    $input.show();
    $input.prop('disabled', false);
    $input.prop('required', true);
  } else {
    $('#adresseShowOk').html('Adresse : ' + $(this).val());
    $input.hide();
    $input.prop('disabled', true);
    $input.prop('required', false);
  }
});

$('.js-input-name').click(function () {
  let $input = $('#client_name_input');
  if ($(this).val() == '1') {
    $input.show();
    $input.prop('disabled', false);
    $input.prop('required', true);
  } else {
    $('#nameShowOk').html('Recruteur : ' + $(this).val());
    $input.hide();
    $input.prop('disabled', true);
    $input.prop('required', false);
  }
});

var month = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
var day = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];

$('#reditDate').click(function () {
  $('#datepicker').show();
  $('.js-timeContainer').hide();
  $('#datepicker').focus();
});

$('.js-hoursTime').click(function () {
  $('#input-time').val($(this).data().time);
  $('#timeShowOk').html($(this).data().time);
  $('#valid-submit').prop('disabled', false);

  $('.js-hoursTime').css('background-color', '#e3b465');
  $('.js-hoursTime').css('border', '2px solid #fff');
  $('.js-hoursTime').css('color', '#fff');

  $(this).css('background-color', '#fff');
  $(this).css('border', '2px solid #e3b465');
  $(this).css('color', '#e3b465');
});

$('#js-adresse_name_input').on('input', function () {
  $('#adresseShowOk').html('Adresse : ' + $(this).val());
});

$('#send-data-form').bind('ajax:complete', function () {
  $('#send-data-form-ok-success').show(800);
  $('#dateEntretien').replaceWith("<div class='btn btn-primary'>INVITATION ENTRETIEN ENVOYER</div>");
});

$('#js-valid-first').click(function () {
  $('#send-data-form-ok-success').show(800);
});

$('#client_name_input').on('input', function () {
  $('#nameShowOk').html('Recruteur : ' + $(this).val());
});

// event for send data in app
$('#send-data-form').bind('ajax:beforeSend', function () {
  $('#js-form-show').hide(200);
});
