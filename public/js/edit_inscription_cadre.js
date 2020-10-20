$(document).ready(function(){
	var new_password = $('#new_password');
	var confirm_password = $('#confirm_password');

	confirm_password.focusout(function(){
		if (confirm_password.val() !== new_password.val()) {
			$('#confirm_pass_error').html('*Votre mot de passe ne correspond pas')
		}
		else{
			$('#confirm_pass_error').html('')	
		}
	})

	$('.action input').click(function(){
		
	})
	
	

})