$('#client_mail').on('input', function() {
	$('#client_email').val($(this).val())
})

$('#postal_code').on('input', function() {
	$("#city").val(verifyCity(this.value))
})

function verifyCity(zip="*"){
	var nameCity = "Aucune ville correspondante!!";
	for (var i = data.length - 1; i >= 0; i--) {
		if(data[i].zip_code == zip){
			nameCity = data[i].name;
			break;
		}
	}
	return nameCity;
}
