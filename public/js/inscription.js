var error1 = false;
var error2 = false;
var error3 = false;
var error4 = false;
var error5 = false;
var error6 = false;
var error7 = false;
var error8 = false;
var error9 = false;
var error10 = false;
var error11 = false;
$('.input-error').hide();
// details entreprise validation
$('#entreprise_name').focusout(function () {
  check_name($(this), $('#entreprise-name-error'), error1);
});
$('#entreprise_adresse').focusout(function () {
  check_nil($(this), $('#entreprise-adress-error'), error2);
});
$('#postal_code').focusout(function () {
  check_nil($(this), $('#entreprise-postal-error'), error3);
});
$('#entreprise_siret').focusout(function () {
  check_nil($(this), $('#entreprise-siret-error'), error4);
});
$('#entreprise_site').focusout(function () {
  check_nil($(this), $('#entreprise-site-error'), error5);
});
$('#code_naf').focusout(function () {
  check_nil($(this), $('#code-naf-error'), error6);
});
////////////////////////////////////
// details recruteur validation
$('#recruteur-last-name').focusout(function () {
  check_name($(this), $('#recruteur-last-name-error'), error7);
});
$('#recruteur-first-name').focusout(function () {
  check_name($(this), $('#recruteur-first-name-error'), error8);
});
$('#recruteur-fonction').focusout(function () {
  check_nil($(this), $('#recruteur-fonction-error'), error9);
});
$('#recruteur-mail').focusout(function () {
  check_mail($(this), $('#recruteur-mail-error'), error10);
});
$('#recruteur-phone').focusout(function () {
  check_nil($(this), $('#recruteur-phone-error'), error11);
});

////////////////////////////////////////////////////
////////////////////////////////////
// details recruteur validation
$('#email-r').focusout(function () {
  check_mail($(this), $('#email-r-error'), error7);
});
$('#password-r').focusout(function () {
  check_pass($(this), $('#password-r-error'), error8);
});
$('#cpass-r').focusout(function () {
  check_nil($(this), $('#cpass-r-error'), error9);
});

////////////////////////////////////////////////////

function check_name(test, value, error) {
  var name = test.val().length;
  if (name < 3 || name > 80) {
    value.html('(doit avoir 5 à 80 caractères)');
    value.show();
    error = true;
  } else {
    value.hide();
  }
}
function check_pass(test, value, error) {
  var name = test.val().length;
  if (name < 6 || name > 80) {
    value.html('(doit avoir 5 à 80 caractères)');
    value.show();
    error = true;
  } else {
    value.hide();
  }
}
function check_cpass(test, value, error) {
  var name = test.val().length;
  var name2 = $('#password-r').val().length;
  if (name != name2) {
    value.html('(inégale au mots de passe)');
    value.show();
    error = true;
  } else {
    value.hide();
  }
}
function check_nil(test, value, error) {
  var name = test.val().length;
  var name = test.val().length;
  if (name < 3) {
    value.html('(Remplissage obligatoire)');
    value.show();
    error = true;
  } else {
    value.hide();
  }
}
function check_mail(testee, value, error) {
  var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if (pattern.test(testee.val())) {
    value.hide();
  } else {
    value.html('(Adresse email invalide)');
    value.show();
    error = true;
  }
}

/////////////////////////////////////////////////
// submit 1 validation
$('.dr-btn2').click(function () {
  if (error7 == false && error8 == false && error9 == false && error10 == false && error11 == false) {
    $('.ir-l2').addClass('color-bg');
    $('.ir-c2').addClass('color-bg');
    $('.dr-2').hide();
    $('.dr-3').fadeIn(800);
  } else {
    $('#submit-error2').html('(formulaire non remplie)');
    $('#submit-error2').show();
  }
});

/////////////////////////////////////////////////
// submit 1 validation
$('.dr-btn1').click(function () {
  if (error1 == false && error2 == false && error3 == false && error4 == false && error5 == false && error6 == false) {
    $('.ir-l1').addClass('color-bg');
    $('.ir-c1').addClass('color-bg');
    $('.dr-1').hide();
    $('.dr-2').fadeIn(800);
  } else {
    $('#submit-error').html('(formulaire non remplie)');
    $('#submit-error').show();
  }
});
