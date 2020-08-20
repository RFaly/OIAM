var month = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
var day = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];

$('#datepicker').datepicker({
  dateFormat: 'yy-mm-dd',
  inline: true,
  minDate: 0,
  showOtherMonths: true,
  dayNamesMin: ['', '', '', '', '', '', ''],
  monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
  monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
  onSelect: function (date) {
    // Your CSS changes, just in case you still need them
    let items_id = $('.input-date-js-me').data().items;
    var date = $('#datepicker').datepicker('getDate');
    let dateGet = new Date($.datepicker.formatDate('yy-mm-dd', date));
    let dateString = day[dateGet.getDay()] + ' ' + dateGet.getDate() + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
    $('#showDateLong-' + items_id).html(dateString);
    $('#choseTime-' + items_id).show();
    $('#js-hide-input-date' + items_id).hide();
  },
  beforeShow: function (input, inst) {
    // Handle calendar position before showing it.
    // It's not supported by Datepicker itself (for now) so we need to use its internal variables.
    var calendar = inst.dpDiv;

    // Dirty hack, but we can't do anything without it (for now, in jQuery UI 1.8.20)
    setTimeout(function () {
      calendar.position({
        my: 'left top',
        at: 'left bottom',
        collision: 'none',
        of: input,
      });
    }, 1);
  },
});

$('#dateEntretien').click(function () {
  let $current_dom = $('#js-form-show-' + $(this).data().items);
  if ($current_dom.is(':visible')) {
    $current_dom.hide();
    $('.date-picker-f').height(0);
    $('.date-picker-f').css('margin-bottom', 90);
  } else {
    $current_dom.show();
    $('#datepicker').focus();
    $('.date-picker-f').height(500);
    $('.date-picker-f').css('margin-bottom', 0);
  }
});

$('.dateShowGo').each(function () {
  let dateGet = new Date($(this).data().time);
  let dateString = day[dateGet.getDay()] + ' ' + dateGet.getDate() + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
  $(this).html(dateString + ', ' + $(this).data().hours);
});

$('.js-reditDate').click(function () {
  let items_id = $(this).data().items;
  $('#js-hide-input-date' + items_id).show();
  $('#choseTime-' + items_id).hide();

  $('#datepicker').focus();
});

$('.js-hoursTime').click(function () {
  let items_id = $(this).data().items;
  $('#input-time-js-' + items_id).val($(this).data().time);
  $('#valid-submit-' + items_id).prop('disabled', false);
  $('.js-hoursTime[data-items=' + items_id + ']').css('background-color', 'transparent');
  $('.js-hoursTime[data-items=' + items_id + ']').css('border', '2px solid #fff');
  $('.js-hoursTime[data-items=' + items_id + ']').css('color', '#fff');
  $(this).css('background-color', '#fff');
  $(this).css('color', '#e3d7bf');
  $('#valid-submit-' + items_id).click(function () {
    $('.date-picker-f').height(0);
  });
});

$('.send-data-form').bind('ajax:beforeSend', function () {
  let items_id = $(this).data().items;
  $('#js-form-show-' + items_id).hide(200);
});

$('.send-data-form').bind('ajax:complete', function () {
  let items_id = $(this).data().items;
  $('#agenda-' + items_id + '-yes').replaceWith("<div class='btn btn-primary'>VOTRE RÉPONSE EST ENVOYER AVEC SUCCESS</div>");
});

$('.js-repons-send-post').bind('ajax:beforeSend', function () {
  let items_id = $(this).data().items;
  $('#agenda-' + items_id + '-yes').hide(200);
});

$('.js-repons-send-post').bind('ajax:complete', function () {
  let items_id = $(this).data().items;
  $('#agenda-' + items_id + '-yes').replaceWith("<div class='btn btn-primary'>VOTRE RÉPONSE EST ENVOYER AVEC SUCCESS</div>");
});

$('.alternatives').hide();

$('.alternative').click(function () {
  if ($('.alternatives').hide()) {
    $('.alternatives').show();
  }
});
