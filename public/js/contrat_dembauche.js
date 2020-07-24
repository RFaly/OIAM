
function shwoMyImage(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#addImage').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$("#promise_to_hire_signature_entreprise").change(function() {
	shwoMyImage(this);
});

$('.js-post-mois').change(function() {
  if (this.value == 'Personnalisé'){
  	showInputPerso()
  }else{
  	hideInputPerso()
  }
});

$(".js-post-choix").change(function(){
	if (this.value == 'true'){
		showChoixInput()		  	
	}else{
		hideChoixInput()
	}
});

function hideInputPerso(){
	$('#input-perso').attr("required", false);
  	$('#input-perso').attr('disabled', 'disabled');
	$('#input-perso').hide()
}

function showInputPerso(){
	$('#input-perso').show()
	$('#input-perso').attr("required", true);
	$('#input-perso').removeAttr("disabled");
}



function hideChoixInput(){
	$('#js-input-choix').attr("required", false);
  	$('#js-input-choix').attr('disabled', 'disabled');
	$('#js-input-choix').hide()
}

function showChoixInput(){
	$('#js-input-choix').show()
	$('#js-input-choix').attr("required", true);
	$('#js-input-choix').removeAttr("disabled");
}
