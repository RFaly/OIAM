$(document).ready(function () {
  $('.input-error').hide();
  // details entreprise validation
  $('#entreprise_name').focusout(function () {
    check_name($(this), $('#entreprise-name-error'));
  });
  // adress
  $('#entreprise_adresse').focusout(function () {
    check_nil($(this), $('#entreprise-adress-error'));
  });
  // postal check
  $('#postal_code').on('input', function () {
    check_none($(this), $('#entreprise-postal-error'), $('#city'));
  });
  $('#postal_code').focusout(function () {
    check_nil($(this), $('#entreprise-postal-error'));
  });
  // siret check
  $('#entreprise_siret').focusout(function () {
    check_siret($(this), $('#entreprise-siret-error'));
  });
  $('#entreprise_siret').on('input', function () {
    verifyNumber($(this).val(), $('#entreprise-siret-error'));
  });
  // site check
  $('#entreprise_site').focusout(function () {
    check_nil($(this), $('#entreprise-site-error'));
  });
  // code naf check
  $('#code_naf').focusout(function () {
    check_nil($(this), $('#code-naf-error'));
  });
  $('#code_naf').on('input', function () {
    check_none($(this), $('#code-naf-error'), $('#entreprise_description'));
    // check_inside_list($(this));
  });
  // $('#code_naf').focus(function () {
  //   add_list();
  // });

  ////////////////////////////////////
  // details recruteur validation
  $('#recruteur-last-name').focusout(function () {
    check_name($(this), $('#recruteur-last-name-error'));
  });
  // first name
  $('#recruteur-first-name').focusout(function () {
    check_name($(this), $('#recruteur-first-name-error'));
  });
  // fonction
  $('#recruteur-fonction').focusout(function () {
    check_nil($(this), $('#recruteur-fonction-error'));
  });
  // check mail
  $('#recruteur-mail').focusout(function () {
    check_mail($(this), $('#recruteur-mail-error'));
  });
  // check phone
  $('#recruteur-phone').focusout(function () {
    check_phone($(this), $('#recruteur-phone-error'));
  });
  $('#recruteur-phone').on('input', function () {
    verifyNumber($(this).val(), $('#recruteur-phone-error'));
  });
  ////////////////////////////////////////////////////
  ////////////////////////////////////
  // details recruteur validation
  $('#email-r').focusout(function () {
    check_mail($(this), $('#email-r-error'));
  });
  // check password
  $('#password-r').focusout(function () {
    check_pass($(this), $('#password-r-error'));
  });
  // check confirmation
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
      $('#entreprise_siret').val().split(' ').join('').length == 14 &&
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
/////////////////////////////////////////////////
// submit 4 validation
$('#cpe-submit').hover(function () {
  if ($('#entreprise_description').val() != "Aucune description d'entreprise correspondante!!" && $('#city').val() != 'Aucune ville correspondante!!' && $('#recruteur-phone').val().split(' ').join('').length == 9) {
    $('#submit-error4').hide();

    $(this).prop('disabled', false);
  } else {
    $('#submit-error4').html('(Verifié les erreurs dans les remplissage de champ!!)');
    $('#submit-error4').show();
    $(this).prop('disabled', true);
  }
});

////////////////////////////////////////////////////
// fonction check name
function check_name(test, value) {
  var name0 = test.val().length;
  if (name0 < 3 || name0 > 80) {
    value.html('(doit avoir 3 à 80 caractères)');
    value.show();

    test.css('outline', '.2px solid red');
  } else {
    test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    test.css('outline', '2px solid #e3d7bf ');
    value.hide();
  }
}
// fonction check password
function check_pass(test, value) {
  var name = test.val().length;
  if (name < 6 || name > 80) {
    test.css('outline', '.2px solid red');
    value.html('(doit avoir 6 à 80 caractères)');
    value.show();
  } else {
    test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    test.css('outline', '2px solid #e3d7bf ');
    value.hide();
  }
}
// fonction check confirme passe word
function check_cpass(test, value) {
  var name1 = test.val();
  var name2 = $('#password-r').val();
  if (name1 != name2) {
    test.css('outline', '.2px solid red');
    value.html('(inégale au mots de passe)');
    value.show();
  } else {
    test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    test.css('outline', '2px solid #e3d7bf ');
    value.hide();
  }
}
// fonction check nil
function check_nil(test, value) {
  var name = test.val().length;
  if (name < 3) {
    test.css('outline', '.2px solid red');
    value.html('(Champ obligatoire)');
    value.show();
    // $('#code-naf-list').css('display', 'none');
  } else {
    // $('#code-naf-list').css('display', 'none');
    test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    test.css('outline', '2px solid #e3d7bf ');
    value.hide();
  }
}
// fonction check mail
function check_mail(testee, value) {
  var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if (pattern.test(testee.val())) {
    testee.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    testee.css('outline', '2px solid #e3d7bf ');
    value.hide();
  } else {
    testee.css('outline', '.2px solid red');
    value.html('(Adresse email invalide)');
    value.show();
  }
}
// fonction check siret
function check_siret(testee, value) {
  var siret = testee.val().split(' ').join('').length;
  if (siret == 14) {
    testee.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    testee.css('outline', '2px solid #e3d7bf ');
    value.hide();
  } else if (siret < 14) {
    testee.css('outline', '.2px solid red');
    value.html('(Le numero de SIRET doit avoir au moins 14 caractères.)');
    value.show();
  } else {
    testee.css('outline', '.2px solid red');
    value.html('(Le numero de SIRET ne doit pas dépasser 14 caractères.)');
    value.show();
  }
}
//  fonction check phone
function check_phone(testee, value) {
  var checkspace = testee.val().split(' ').join('');
  if (checkspace.length == 9) {
    testee.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    testee.css('outline', '2px solid #e3d7bf ');
    value.hide();
  } else {
    testee.css('outline', '.2px solid red');
    value.html('(Numero téléphone invalide)');
    value.show();
  }
}
// Verify number
function verifyNumber(Number, error) {
  var pathern2 = /^[\d\s]+$/;
  if (pathern2.test(Number)) {
    error.hide();
  } else {
    error.html('(Veuillez saisir uniquement des chiffres ou des espaces)');
    error.show();
  }
}

// fonction check description and ville
function check_none(test, value, check) {
  var nameCity = 'Aucune ville correspondante!!';
  var description = "Aucune description d'entreprise correspondante!!";
  var name = test.val().length;
  if (name < 3) {
    test.css('outline', '.2px solid red');
    check.css('outline', '.2px solid red');
    check.css('box-shadow', '0px 1px 2px 1px red');
    value.html('(Code invalide)');
    value.show();
  } else {
    if (check.val() == description || check.val() == nameCity) {
      test.css('outline', '.2px solid red');
      check.css('outline', '.2px solid red');
      check.css('box-shadow', '0px 1px 2px 1px red');
      value.html('(Code invalide)');
      value.show();
    } else {
      test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
      test.css('outline', '2px solid #e3d7bf ');
      check.css('outline', 'none');
      check.css('box-shadow', 'none');
      value.hide();
    }
  }
}
// fonction add data in list
// function add_list() {
//   var list = $('#code-naf-list');
//   list.css('display', 'block');
//   for (var i = 0; i < code_naf.length; i++) {
//     list.append('<li class="code-naf-list-item">' + code_naf[i].code + ' ' + code_naf[i].info + '</li>');
//   }
// }
// fonction find list
// function check_inside_list(test) {
//   var filter = test.val();
//   var list_li = $('.code-naf-list-item');
//   for (i = 0; i < list_li.length; i++) {
//     txtValue = list_li[i].textContent || list_li[i].innerText;
//     if (txtValue.indexOf(filter) > -1) {
//       list_li[i].style.display = '';
//     } else {
//       list_li[i].style.display = 'none';
//     }
//   }
// }
