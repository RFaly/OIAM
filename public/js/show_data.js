$(document).ready(function () {
  $('#recruteur-mail').on('input', function () {
    $('#email-r').val($(this).val());
  });

  $('#postal_code').on('input', function () {
    $('#city').val(verifyCity(this.value));
  });

  $('#code_naf').on('input', function () {
    $('#entreprise_description').val(verifyCodeNaf(this.value));
  });
});

function verifyCity(zip = '*') {
  var nameCity = 'Aucune ville correspondante!!';
  for (var i = data.length - 1; i >= 0; i--) {
    if (data[i].zip_code == zip) {
      nameCity = data[i].name;
      $('#city').css('outline', 'none');
      $('#city').css('box-shadow', 'none');
      break;
    } else {
      $('#city').css('outline', '1px solid red');
      $('#city').css('box-shadow', '.5px 1px 10px 1px red');
    }
  }
  return nameCity;
}
function verifyCodeNaf(code = '*') {
  var description = "Aucune description d'entreprise correspondante!!";
  var code_naf_valide = false;
  for (var i = code_naf.length - 1; i >= 0; i--) {
    if (code_naf[i].code == code) {
      description = code_naf[i].info;
      $('#entreprise_description').css('outline', 'none');
      $('#entreprise_description').css('box-shadow', 'none');
      break;
    } else {
      $('#entreprise_description').css('outline', '0.5px solid red');
      $('#entreprise_description').css('box-shadow', '1px 1px 10px 1px red');
    }
  }
  return description;
}
