$(document).ready(function () {
  $('#file-cin-content').hide();
  $('.cin').change(function (e) {
    var file = e.target.files[0].name;
    $('#cin-filename').text(file);
    $('#file-cin-content').show();
  });

  $('#file-atest-content').hide();
  $('.atest').change(function (e) {
    var file = e.target.files[0].name;
    $('#atest-filename').text(file);
    $('#file-atest-content').show();
  });

  $('#file-rib-content').hide();
  $('.rib').change(function (e) {
    var file = e.target.files[0].name;
    $('#rib-filename').text(file);
    $('#file-rib-content').show();
  });

  $('.calen input').focusout(function () {
    if ($('#calendar').val() <= 0) {
      $('.calendar-err').html('Champs obligatoire');

      return false;
    } else {
      $('.calendar-err').hide();
      return true;
    }
  });

  $('.lieu-naiss').focusout(function () {
    if ($(this).val() <= 0) {
      $('.lieu-naiss-err').html('Champs obligatoire');
      return false;
    } else {
      $('.lieu-naiss-err').hide();
      return true;
    }
  });

  $('.number-only').focusout(function () {
    var value = $(this).val();
    if (value <= 0) {
      console.log(value.length);
      $('.secur-social-err').html('Champs obligatoire');
      return false;
    } else if (value.length !== 13) {
      $('.secur-social-err').show();
      $('.secur-social-err').html('Numéro de sécurité invalide (13 chiffres)');
      return false;
    } else {
      $('.secur-social-err').hide();
      return true;
    }
  });

  $('.edit_promise_to_hire').attr('name', 'formulaire');

  $('.btn-valide').click(function () {
    var form = document.forms.formulaire;

    for (var i = 0; i < form.length; i++) {
      if (form[i].value == 0 || form[i].value.length == 0) {
        form[i].style.outline = '1px solid red';
        form[i].nextSibling.nextSibling.innerHTML = 'Champs Obligatoire';
        $('#btn-valid-error').html('*Vérifier que vous avez rempli tous les formulaires');
        $('#btn-valid-error').show(300);
        setTimeout(function () {
          $('#btn-valid-error').hide(500);
        }, 5000);
        return false;
        console.log(form[i].nextSibling.nextSibling);
      } else {
        form[i].style.outline = 'none';
        return true;
      }
    }

    if ($('#signature').val().length() <= 0 || $('.cin').val().length() <= 0 || $('.atest').val().length() <= 0 || $('.rib').val().length()) {
      console.log('fandeany');
      $('#btn-valid-error').html('*Vérifier que vous avez rempli tous les formulaires');
      $('#btn-valid-error').show(300);
      setTimeout(function () {
        $('#btn-valid-error').hide(300);
      }, 5000);
      return false;
    } else {
      return true;
    }
  });
});
