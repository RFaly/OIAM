$("#dateEntretien").click(function(){
	if ($(".hiddenDate").is(':visible')){
		$(".hiddenDate").hide()
	}else{
		$(".hiddenDate").show()
	}
});

$(".js-input-adresse").click(function() {
	let $input = $("#js-adresse_name_input")
	if($(this).data().value == "autre"){
		$input.show()
		$input.prop("disabled",false)
		$input.prop("required",true)
	}else{
		$input.hide()
		$input.prop("disabled",true)
		$input.prop("required",false)
	}
})

$(".js-input-name").click(function() {
	let $input = $("#client_name_input")
	if($(this).val() == "1"){
		$input.show()
		$input.prop("disabled",false)
		$input.prop("required",true)
	}else{
		$input.hide()
		$input.prop("disabled",true)
		$input.prop("required",false)
	}
})

var month = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]
var day = ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]


$("#input-date").on("input",function(){
	let dateGet = new Date($(this).val())
	let dateString = day[dateGet.getDay()] +" "+ dateGet.getDate()+" "+month[dateGet.getMonth()]+" "+dateGet.getFullYear()
	$("#showDateLong").html(dateString)
	$("#input-date").hide()
	// dateGet[0] // year
	// dateGet[1] // month
	// dateGet[2] //day
	$(".js-timeContainer").show()
});


$("#reditDate").click(function(){
	$("#input-date").show()
	$(".js-timeContainer").hide()
});

$(".js-hoursTime").click(function(){
	$("#input-time").val($(this).data().time)
	
	$("#valid-submit").prop("disabled",false)

	$(".js-hoursTime").css('background-color','#e3b465')
	$(".js-hoursTime").css('border','2px solid #fff')
	$(".js-hoursTime").css('color','#fff')

	$(this).css('background-color','#fff')
	$(this).css('border','2px solid #e3b465')
	$(this).css('color','#e3b465')
});
