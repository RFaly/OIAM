if (document.URL.indexOf('#') == -1) {
  url = document.URL + '#';
  location = '#';
  location.reload(true);
}
var month = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
var day = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
let $elementDate = $('.currentDateEntretien');

$elementDate.each(function () {
  let dateUTC = moment.utc($(this).data().times);
  let dateGet = new Date(dateUTC.local());
  var minut = dateGet.getMinutes();
  var hour = dateGet.getHours();
  var daily = dateGet.getDate();
  var today = day[dateGet.getDay()];
  if (daily < 10) {
    daily = '0' + daily;
  }
  if (minut < 10) {
    minut = '0' + minut;
  }
  if (hour < 10) {
    hour = '0' + hour;
  }
  let dateString = today + ' ' + daily + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
  $(this).html(dateString + ' à ' + hour + 'h' + minut);
});
