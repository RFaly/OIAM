$(document).ready(function () {
  $('.input-error').hide();
  // details entreprise validation
  $('#entreprise_name').focusout(function () {
    check_name($(this), $('#entreprise-name-error'));
  });
  $('#entreprise_adresse').focusout(function () {
    check_nil($(this), $('#entreprise-adress-error'));
  });
  $('#postal_code').on('input', function () {
    check_none($(this), $('#entreprise-postal-error'), $('#city'));
  });
  $('#entreprise_siret').focusout(function () {
    check_nil($(this), $('#entreprise-siret-error'));
  });
  $('#entreprise_site').focusout(function () {
    check_nil($(this), $('#entreprise-site-error'));
  });
  $('#code_naf').on('input', function () {
    check_none($(this), $('#code-naf-error'), $('#entreprise_description'));
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
    check_phone($(this), $('#recruteur-phone-error'));
  });
  $('#recruteur-phone').on('input', function () {
    verifyPhone($(this).val());
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
    if (
      $('#entreprise_name').val().length > 1 &&
      $('#entreprise_adresse').val().length > 1 &&
      $('#postal_code').val().length > 1 &&
      $('#entreprise_siret').val().length > 1 &&
      $('#entreprise_site').val().length > 1 &&
      $('#code_naf').val().length > 1 &&
      $('#entreprise_description').val() != "Aucune description d'entreprise correspondante!!" &&
      $('#city').val() != 'Aucune ville correspondante!!'
    ) {
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
});

////////////////////////////////////////////////////
// fonction check name
function check_name(test, value) {
  var name0 = test.val().length;
  if (name0 < 3 || name0 > 80) {
    value.html('(doit avoir 3 à 80 caractères)');
    value.show();
  } else {
    value.hide();
  }
}
// fonction check password
function check_pass(test, value) {
  var name = test.val().length;
  if (name < 6 || name > 80) {
    value.html('(doit avoir 6 à 80 caractères)');
    value.show();
  } else {
    value.hide();
  }
}
// fonction check confirme passe word
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
// fonction check nil
function check_nil(test, value) {
  var name = test.val().length;
  if (name < 3) {
    value.html('(Champ obligatoire)');
    value.show();
  } else {
    value.hide();
  }
}
// fonction check mail
function check_mail(testee, value) {
  var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if (pattern.test(testee.val())) {
    value.hide();
  } else {
    value.html('(Adresse email invalide)');
    value.show();
  }
}
//  fonction check phone
function check_phone(testee, value) {
  var checkspace = testee.val().split(' ').join('');
  if (checkspace.length == 9) {
    value.hide();
  } else {
    value.html('(Numero téléphone invalide)');
    value.show();
  }
}

function verifyPhone(phone) {
  var pathern2 = /^[\d\s]+$/;
  if (pathern2.test(phone)) {
    $('#recruteur-phone-error').hide();
  } else {
    $('#recruteur-phone-error').html('(Veuillez saisir uniquement des chiffres ou des espaces)');
    $('#recruteur-phone-error').show();
  }
}

// fonction check description
function check_none(test, value, check) {
  var nameCity = 'Aucune ville correspondante!!';
  var description = "Aucune description d'entreprise correspondante!!";
  var name = test.val().length;
  if (name < 3) {
    value.html('(Champ obligatoire)');
    value.show();
    check.css('outline', '1px solid red');
    check.css('box-shadow', '.5px 1px 10px 1px red');
  } else {
    value.hide();
    if (check.val() == description || check.val() == nameCity) {
      check.css('outline', '1px solid red');
      check.css('box-shadow', '.5px 1px 10px 1px red');
    } else {
      check.css('outline', 'none');
      check.css('box-shadow', 'none');
    }
  }
}
