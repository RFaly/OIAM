$('.input-error').hide();
// details entreprise validation
$('#entreprise_name').focusout(function () {

  check_name($(this), $('#entreprise-name-error'));

});
$('#entreprise_adresse').focusout(function () {
  check_nil($(this), $('#entreprise-adress-error'));
});
$('#postal_code').focusout(function () {
  check_nil($(this), $('#entreprise-postal-error'));
});
$('#entreprise_siret').focusout(function () {
  check_nil($(this), $('#entreprise-siret-error'));
});
$('#entreprise_site').focusout(function () {
  check_nil($(this), $('#entreprise-site-error'));
});
$('#code_naf').focusout(function () {
  check_nil($(this), $('#code-naf-error'));
});
////////////////////////////////////
// details recruteur validation
$('#recruteur-last-name').focusout(function () {
  check_name($(this), $('#recruteur-last-name-error'));
});
$('#recruteur-first-name').focusout(function () {
  check_name($(this), $('#recruteur-first-name-error'));
});
$('#recruteur-fonction').focusout(function () {
  check_nil($(this), $('#recruteur-fonction-error'));
});
$('#recruteur-mail').focusout(function () {
  check_mail($(this), $('#recruteur-mail-error'));
});
$('#recruteur-phone').focusout(function () {
  check_nil($(this), $('#recruteur-phone-error'));
});

////////////////////////////////////////////////////
////////////////////////////////////
// details recruteur validation
$('#email-r').focusout(function () {
  check_mail($(this), $('#email-r-error'));
});
$('#password-r').focusout(function () {
  check_pass($(this), $('#password-r-error'));
});
$('#cpass-r').focusout(function () {
  check_cpass($(this), $('#cpass-r-error'));
});

/////////////////////////////////////////////////
// submit 1 validation
$('.dr-btn1').click(function () {
  if ($('#entreprise_name').val().length > 1 && $('#entreprise_adresse').val().length > 1 && $('#postal_code').val().length > 1 && $('#entreprise_siret').val().length > 1 && $('#entreprise_site').val().length > 1 && $('#code_naf').val().length > 1) {
    $('.ir-l1').addClass('color-bg');
    $('.ir-c1').addClass('color-bg');
    $('.dr-1').hide();
    $('.dr-2').fadeIn(800);
  } else {
    $('#submit-error').html('(formulaire non remplie)');
    $('#submit-error').show();
  }
});

/////////////////////////////////////////////////
// submit 2 validation
$('.dr-btn2').click(function () {
  if ($('#recruteur-last-name').val().length > 1 && $('#recruteur-first-name').val().length > 1 && $('#recruteur-fonction').val().length > 1 && $('#recruteur-phone').val().length > 1) {
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
// submit 3 validation
$('.dr-btn3').click(function () {
  if ($('#email-r').val().length > 1 && $('#password-r').val().length > 1 && $('#cpass-r').val().length > 1 && $('#password-r').val() === $('#cpass-r').val()) {
    $('.ir-l3').addClass('color-bg');
    $('.ir-c3').addClass('color-bg');
    $('.dr-3').hide();
    $('.details-r-condition').fadeIn(800);
  } else {
    $('#submit-error3').html('(formulaire non remplie)');
    $('#submit-error3').show();
  }
});

////////////////////////////////////////////////////

function check_name(test, value) {
  var name0 = test.val().length;
  if (name0 < 3 || name0 > 80) {
    value.html('(doit avoir 3 à 80 caractères)');
    value.show();
  } else {
    value.hide();
  }
}
function check_pass(test, value) {
  var name = test.val().length;
  if (name < 6 || name > 80) {
    value.html('(doit avoir 6 à 80 caractères)');
    value.show();
  } else {
    value.hide();
  }
}
function check_cpass(test, value) {
  var name1 = test.val();
  var name2 = $('#password-r').val();
  if (name1 != name2) {
    value.html('(inégale au mots de passe)');
    value.show();
  } else {
    value.hide();
  }
}
function check_nil(test, value) {
  var name = test.val().length;
  var name = test.val().length;
  if (name < 3) {
    value.html('(Remplissage obligatoire)');
    value.show();
  } else {
    value.hide();
  }
}
function check_mail(testee, value) {
  var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if (pattern.test(testee.val())) {
    value.hide();
  } else {
    value.html('(Adresse email invalide)');
    value.show();
  }
}
