let $attente = $('#js-show_ca_confirmchoice');
$(document).ready(function () {
  $('#js-ca_confirmchoice').click(function () {
    $attente.show(500);
  });

  $('.js-retour-choice').click(function () {
    $attente.hide(500);
  });
  //window.location.reload();
  // Check if the current URL contains '#'

  if ($('#futureTimeClock')[0]) {
    let dateUTC = moment.utc($('#futureTimeClock').data().times);
    let objectifTime = new Date(dateUTC.local());

    let $dd = $('#js-days');
    let $hh = $('#js-hours');
    let $mm = $('#js-minutes');
    let $ss = $('#js-seconds');
    // ~~~~~~~~~~~~~~~~ Mise à jour de la compte à rebours ~~~~~~~~~~~~~~~~

    function updateTimeNow() {
      var current_time = Date.parse(objectifTime) - Date.parse(new Date());
      var seconds = Math.floor((current_time / 1000) % 60);
      var minutes = Math.floor((current_time / 1000 / 60) % 60);
      var hours = Math.floor((current_time / (1000 * 60 * 60)) % 24);
      var days = Math.floor(current_time / (1000 * 60 * 60 * 24));
      return {
        rest_number_time: current_time,
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      };
    }

    function updateTimeInOneSecond() {
      var current_time = updateTimeNow();
      $dd.html(current_time.days);
      $hh.html(('0' + current_time.hours).slice(-2));
      $mm.html(('0' + current_time.minutes).slice(-2));
      $ss.html(('0' + current_time.seconds).slice(-2));
      if (current_time.rest_number_time <= 0) {
        window.location.reload();
        clearInterval(timeinterval);
      }
    }

    updateTimeInOneSecond();
    var timeinterval = setInterval(updateTimeInOneSecond, 1000);
  }

  var month = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
  var day = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
  let $elementDate = $('.currentDateEntretien');

  $elementDate.each(function () {
    let dateUTC = moment.utc($(this).data().times);
    let dateGet = new Date(dateUTC.local());
    let dateString = day[dateGet.getDay()] + ' ' + dateGet.getDate() + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
    $(this).html(dateString + ' à ' + dateGet.getHours() + 'h00');
  });
});



/*

08/25/2020 09:00

// 	let dateGet = new Date($(this).val())

1. Publication
2. Selection
3. 1er entretien            1
4. 2e entretien             2
5. 3e entretien             3
6. Promesse d'ambauche      4
7. Recrutement              5


*/
