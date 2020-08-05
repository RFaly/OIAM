var month = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]
var day = ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]

$(".input-date-js-me").on('input',function () {
	let items_id = $(this).data().items
	let dateGet = new Date($(this).val())
	let dateString = day[dateGet.getDay()] +" "+ dateGet.getDate()+" "+month[dateGet.getMonth()]+" "+dateGet.getFullYear()
	$("#showDateLong-"+items_id).html(dateString)
	$("#choseTime-"+items_id).show()
	$("#js-hide-input-date"+items_id).hide()
});

$(".dateShowGo").each(function(){
    let dateGet = new Date($(this).data().time)
	let dateString = day[dateGet.getDay()] +" "+ dateGet.getDate()+" "+month[dateGet.getMonth()]+" "+dateGet.getFullYear()
	$(this).html(dateString+", "+$(this).data().hours)
});

$(".js-proposer-date").click(function(){
	let $current_dom = $("#js-form-show-"+$(this).data().items)
	if ($current_dom.is(':visible')){
		$current_dom.hide()
	}else{
		$current_dom.show()
	}
});

$(".js-reditDate").click(function(){
	let items_id = $(this).data().items
	$("#js-hide-input-date"+items_id).show()
	$("#choseTime-"+items_id).hide()
});

$(".js-hoursTime").click(function(){
	let items_id = $(this).data().items
	$("#input-time-js-"+items_id).val($(this).data().time)
	$("#valid-submit-"+items_id).prop("disabled",false)
	$(".js-hoursTime[data-items="+items_id+"]").css('background-color','#e3b465')
	$(".js-hoursTime[data-items="+items_id+"]").css('border','2px solid #fff')
	$(".js-hoursTime[data-items="+items_id+"]").css('color','#fff')
	$(this).css('background-color','#fff')
	$(this).css('border','2px solid #e3b465')
	$(this).css('color','#e3b465')
})

$(".send-data-form").bind('ajax:beforeSend', function () {
	let items_id = $(this).data().items
	$("#js-form-show-"+items_id).hide(200);
});

$(".send-data-form").bind('ajax:complete', function () {
	let items_id = $(this).data().items
	$("#agenda-"+items_id+"-yes").replaceWith("<div class='btn btn-primary'>VOTRE RÉPONSE EST ENVOYER AVEC SUCCESS</div>")
});
