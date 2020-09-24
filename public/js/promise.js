$(document).ready(function () {
  let pop = 12;
  $('#renumeration-fixe').on('input', function () {
    if ($('#post_oui').is(':checked')) {
      var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    } else {
      var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    }
  });
  $('#post_12').on('click', function () {
    pop = 12;
    if ($('#post_oui').is(':checked')) {
      var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    } else {
      var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    }
  });
  $('#post_13').on('click', function () {
    pop = 13;
    if ($('#post_oui').is(':checked')) {
      var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    } else {
      var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    }
  });
  $('#post_perso').on('click', function () {
    pop = $('#input-perso').val();
    if ($('#post_oui').is(':checked')) {
      var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    } else {
      var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    }
  });

  $('#input-perso').on('input', function () {
    pop = $(this).val();
    if ($('#post_oui').is(':checked')) {
      var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    } else {
      var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
      $('#pc-calcul').html(oiam.toFixed(2) + '€');
    }
  });

  $('#js-input-choix').on('input', function () {
    var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
    $('#pc-calcul').html(oiam.toFixed(2) + '€');
  });
  $('#post_nom').on('focus', function () {
    var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
    $('#pc-calcul').html(oiam.toFixed(2) + '€');
  });
  //  on load
  if ($('#post_13').is(':checked')) {
    pop = 13;
  }
  if ($('#post_perso').is(':checked')) {
    pop = $('#input-perso').val();
  }
  if ($('#post_oui').is(':checked')) {
    var oiam = (($('#renumeration-fixe').val() * pop + $('#js-input-choix').val() * 1000) * 15) / 100;
    $('#pc-calcul').html(oiam.toFixed(2) + '€');
  } else {
    var oiam = ($('#renumeration-fixe').val() * pop * 15) / 100;
    $('#pc-calcul').html(oiam.toFixed(2) + '€');
  }
});
