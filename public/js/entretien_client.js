$('#dateEntretien').click(function () {
  if ($('.hiddenDate').is(':visible')) {
    $('.hiddenDate').hide();
    $('.ssc-planification').height(0);
    $('.ssc-planification').css('margin-bottom', 110);
  } else {
    $('.hiddenDate').show();
    $('#datepicker').focus();
    $('.ssc-planification').height(535);
    $('.ssc-planification').css('margin-bottom', 0);
  }
});




$('#dateEntretien1').click(function () {
  if ($('.hiddenDate1').is(':visible')) {
    $('.hiddenDate1').hide();
    $('.ssc-planification1').height(0);
    $('.ssc-planification1').css('margin-bottom', 270);
  } else {
    $('.hiddenDate1').show();
    $('#datepicker').focus();
    $('.ssc-planification1').height(500);
    $('.ssc-planification1').css('margin-bottom', 0);
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
  let dateTime = new Date($('#datepicker').val());
  let datahours = $(this).data().time;
  let times = datahours.split(':');

  dateTime.setHours(times[0]);
  dateTime.setMinutes(times[1]);

  utcDate = moment.utc(dateTime);
  $('#input-time').val(utcDate.hours() + ':' + utcDate.minutes());
  $('#datepicker').val(utcDate.format('YYYY-MM-DD'));

  $('#timeShowOk').html($(this).data().time);
  $('#valid-submit').prop('disabled', false);

  $('.js-hoursTime').css('background-color', 'transparent');
  $('.js-hoursTime').css('border', '2px solid #fff');
  $('.js-hoursTime').css('color', '#fff');

  $(this).css('background-color', '#fff');
  $(this).css('color', '#e3d7bf');
});

$('#js-adresse_name_input').on('input', function () {
  $('#adresseShowOk').html('Adresse : ' + $(this).val());
});

$('#send-data-form').bind('ajax:complete', function () {
  $('#send-data-form-ok-success').show(800);
  $('.ssc-planification').height(535);
  $('#dateEntretien').replaceWith("<div class='ssc-btn ssc-pe ssc-invite'>INVITATION D'ENTRETIEN ENVOYÉE</div>");
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

// close div send entretien
$('.ssc-send-btn').click(function () {
  $('#send-data-form-ok-success').fadeOut(500);
  $('.ssc-planification').fadeOut(500);
});