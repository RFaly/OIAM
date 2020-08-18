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