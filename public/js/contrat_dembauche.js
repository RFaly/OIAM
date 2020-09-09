function shwoMyImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#addImage').css('background-image', 'url(' + e.target.result + ')');
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$('#promise_to_hire_signature_entreprise').change(function () {
  shwoMyImage(this);
});

$('.js-post-mois').change(function () {
  if (this.value == 'Personnalisé') {
    showInputPerso();
  } else {
    hideInputPerso();
  }
});

$('.js-post-choix').change(function () {
  if (this.value == 'true') {
    showChoixInput();
  } else {
    hideChoixInput();
  }
});

function hideInputPerso() {
  $('#input-perso').attr('required', false);
  $('#input-perso').attr('disabled', 'disabled');
  $('#input-perso').hide();
}

function showInputPerso() {
  $('#input-perso').show();
  $('#input-perso').attr('required', true);
  $('#input-perso').removeAttr('disabled');
}

function hideChoixInput() {
  $('#js-input-choix').attr('required', false);
  $('#js-input-choix').attr('disabled', 'disabled');
  $('#js-input-choix').hide();
}

function showChoixInput() {
  $('#js-input-choix').show();
  $('#js-input-choix').attr('required', true);
  $('#js-input-choix').removeAttr('disabled');
}

// custom date picker
$('#datepicker').datepicker({
  dateFormat: 'dd/mm/yy',
  inline: true,
  minDate: 0,
  showOtherMonths: true,
  dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
  monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
  monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
  onSelect: function (date) {
    $('#datepicker').css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    $('#datepicker').css('outline', '2px solid #e3d7bf ');
  },
});
// custom date picker
$('#datepicker2').datepicker({
  dateFormat: 'dd/mm/yy',
  inline: true,
  minDate: 0,
  showOtherMonths: true,
  dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
  monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
  monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
  onSelect: function (date) {
    $('#datepicker2').css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    $('#datepicker2').css('outline', '2px solid #e3d7bf ');
  },
});
