let $main = $("#js-main-bloc-information");
let $next = $("#js-show_ca_next_stape");
let $attente = $("#js-show_ca_en_attente");
let $refused = $("#js-show_ca_refused");

$('#js-ca_next_stape').click(function(){
	$main.hide(500);
	$next.hide(500);
	$refused.hide(500);
	$next.show(500);
});

$('#js-ca_en_attente').click(function(){
	$main.hide(500);
	$next.hide(500);
	$refused.hide(500);
	$attente.show(500);

});

$('#js-ca_refused').click(function(){
	$main.hide(500);
	$next.hide(500);
	$attente.hide(500);
	$refused.show(500);

});


$('.js-retour-choice').click(function(){
	$main.show(500);
	$next.hide(500);
	$attente.hide(500);
	$refused.hide(500);
});


// ~~~~~~~~~~~~~~~~ Mise à jour de la compte à rebours ~~~~~~~~~~~~~~~~

var objectifTime = new Date($('#clockdiv').data().times)
let $dd = $('#js-days');
let $hh = $('#js-hours');
let $mm = $('#js-minutes');
let $ss = $('#js-seconds');

function updateTimeNow() {
     var current_time = Date.parse(objectifTime) - Date.parse(new Date());
     var seconds = Math.floor((current_time / 1000) % 60);
     var minutes = Math.floor((current_time / 1000 / 60) % 60);
     var hours = Math.floor((current_time / (1000 * 60 * 60)) % 24);
     var days = Math.floor(current_time / (1000 * 60 * 60 * 24));
     return {
       'rest_number_time': current_time,
       'days': days,
       'hours': hours,
       'minutes': minutes,
       'seconds': seconds
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




/*


// 	let dateGet = new Date($(this).val())
// 	let dateString = day[dateGet.getDay()] +" "+ dateGet.getDate()+" "+month[dateGet.getMonth()]+" "+dateGet.getFullYear()


1. Publication
2. Selection
3. 1er entretien            1
4. 2e entretien             2
5. 3e entretien             3
6. Promesse d'ambauche      4
7. Recrutement              5


*/