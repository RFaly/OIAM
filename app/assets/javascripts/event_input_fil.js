/* input show image */
function shwoMyImage(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#addImage').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$("#client_image").change(function() {
	shwoMyImage(this);
});

