$(document).ready(function () {
  $('#recruteur-mail').on('input', function () {
    $('#email-r').val($(this).val());
  });

  $('#postal_code').on('input', function () {
    $('#city').val(verifyCity(this.value));
  });

  $('#code_naf').on('input', function () {
    $('#entreprise_description1').val(verifyCodeNaf(this.value));
    $('#entreprise_description').html(verifyCodeNaf(this.value));
  });

});

function verifyCity(zip = '*') {
  var nameCity = 'Aucune ville correspondante!!';
  for (var i = data.length - 1; i >= 0; i--) {
    if (data[i].zip_code == zip) {
      nameCity = data[i].name;
      break;
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
      break;
    }
  }
  return description;
}