// if (sessionStorage.getItem("country")){
// 	$("#paysInput").val(sessionStorage.getItem("country"))
// 	$("#regionInput").prop('disabled', false);
// 	$("#departmentInput").prop('disabled', false);
// 	$("#regionInput").val(sessionStorage.getItem("region"));
// 	$("#departmentInput").val(sessionStorage.getItem("departement"));
// }

/* INITIALISER LES VALEURS */
var franceData = [
  { region: 'Auvergne-Rhône-Alpes', departement: ['Ain', 'Allier', 'Ardèche ', 'Cantal', 'Drôme', 'Isère', 'Loire ', 'Haute-Loire ', 'Puy-de-Dôme', ' Rhône + Métropole de Lyon', 'Savoie', 'Haute-Savoie'] },
  { region: 'Bourgogne-Franche-Comté', departement: ["Côte-d'Or", 'Doubs', 'Jura', 'Nièvre', 'Haute-Saône', 'Saône-et-Loire', 'Yonne', 'Territoire de Belfort'] },
  { region: 'Bretagne', departement: ["Côtes-d'Armor", 'Finistère', 'Ille-et-Vilaine', 'Morbihan'] },
  { region: 'Centre-Val de Loire', departement: ['Cher', 'Eure-et-Loir', 'Indre', 'Indre-et-Loire', 'Loir-et-Cher', 'Loiret'] },
  { region: 'Corse', departement: ['Corse-du-Sud', 'Haute-Corse'] },
  { region: 'Grand Est', departement: ['Ardennes', 'Aube', 'Marne', 'Haute-Marne', 'Meurthe-et-Moselle', 'Meuse', 'Moselle', 'Bas-Rhin', 'Haut-Rhin', 'Vosges'] },
  { region: 'Hauts-de-France', departement: ['Aisne', 'Nord', 'Oise', 'Pas-de-Calais', 'Somme'] },
  { region: 'Île-de-France', departement: ['Paris', 'Seine-et-Marne', 'Yvelines', 'Essonne', 'Hauts-de-Seine', 'Seine-Saint-Denis', 'Val-de-Marne', "Val-d'Oise"] },
  { region: 'Normandie', departement: ['Calvados', 'Eure', 'Manche', 'Orne', 'Seine-Maritime'] },
  { region: 'Nouvelle-Aquitaine', departement: ['Charente', 'Charente-Maritime', 'Corrèze', 'Creuse', 'Dordogne', 'Gironde', 'Landes', 'Lot-et-Garonne', 'Pyrénées-Atlantiques', 'Deux-Sèvres', 'Vienne', 'Haute-Vienne'] },
  { region: 'Occitanie', departement: ['Ariège', 'Aude', 'Aveyron', 'Gard', 'Haute-Garonne', 'Gers', 'Hérault', 'Lot', 'Lozère', 'Hautes-Pyrénées', 'Pyrénées-Orientales', 'Tarn', 'Tarn-et-Garonne'] },
  { region: 'Pays de la Loire', departement: ['Loire-Atlantique', 'Maine-et-Loire', 'Mayenne', 'Sarthe', 'Vendée'] },
  { region: "Provence-Alpes-Côte d'Azur", departement: ['Alpes-de-Haute-Provence', 'Hautes-Alpes', 'Alpes-Maritimes', 'Bouches-du-Rhône', 'Var', 'Vaucluse'] },
];
var listOptionRegion = '';
var listOptionDepartment = '';
for (var i = 0; i < franceData.length; i++) {
  listOptionRegion += '<option data-index="' + i + '" value="' + franceData[i].region + '">' + franceData[i].region + '</option>';
  var departments = franceData[i].departement;
  for (var j = departments.length - 1; j >= 0; j--) {
    listOptionDepartment += '<option data-index="' + i + '" value="' + departments[j] + '">' + departments[j] + '</option>';
  }
}
$('#regionInput').html(listOptionRegion);
$('#departmentInput').html(listOptionDepartment);

/* Lite region de france et departement */
// Change input region for pays
$('#paysInput').change(function () {
  sessionStorage.setItem('country', this.value);
  if ($(this).val() == 'France') {
    var listOptionRegion = "<option value=''>Région</option>";
    for (var i = 0; i < franceData.length; i++) {
      listOptionRegion += '<option data-index="' + i + '" value="' + franceData[i].region + '">' + franceData[i].region + '</option>';
    }
    $('#regionInput').html(listOptionRegion);
    sessionStorage.setItem('country', 'France');
  } else {
    /* A VOIR */
  }
});

// change input depatement for Région
$('#regionInput').change(function () {
  let allOptions = document.getElementById('regionInput').options;
  let listDepartement = '';
  for (var i = 0; i < allOptions.length; i++) {
    if ($(allOptions[i]).val() == $(this).val()) {
      let currentDepartment = franceData[allOptions[i].dataset.index].departement;
      for (var j = 0; j < currentDepartment.length; j++) {
        listDepartement += '<option data-index="' + allOptions[i].dataset.index + '" value="' + currentDepartment[j] + '">' + currentDepartment[j] + '</option>';
      }
      $('#paysInput').val('France');
      sessionStorage.setItem('country', 'France');
      break;
    }
  }
  $('#departmentInput').html(listDepartement);
  sessionStorage.setItem('region', this.value);
  sessionStorage.setItem('departement', $('#departmentInput').val());
});

$('#departmentInput').change(function () {
  let allOptions = document.getElementById('departmentInput').options;
  for (var i = 0; i < allOptions.length; i++) {
    if ($(allOptions[i]).val() == $(this).val()) {
      $('#regionInput').val(franceData[allOptions[i].dataset.index].region);
      $('#paysInput').val('France');
      break;
    }
  }
  sessionStorage.setItem('country', 'France');
  sessionStorage.setItem('region', $('#regionInput').val());
  sessionStorage.setItem('departement', this.value);
});
// custom date picker
$('#datepicker').datepicker({
  dateFormat: 'dd/mm/yy',
  inline: true,
  minDate: 0,
  showOtherMonths: true,
  dayNamesMin: ['', '', '', '', '', '', ''],
  monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
  monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
  onSelect: function (date) {
    $('#datepicker').css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    $('#datepicker').css('outline', '2px solid #e3d7bf ');
    $('.dp-date-error').hide();
  },
});
// custom slide
$('#remuneration').on('input', function () {
  $('#inputRange').html($(this).val());
  var valuer = $('#value-renum');
  // console.log($(this).width());
  $('#inputRange-div').css('left', `${(($(this).val() - 60) * 100) / 290}%`);
  if ($(this).width() < 270) {
    valuer.css('width', `${($(this).width() * 84) / 100}`);
    valuer.css('left', `5%`);
  }
  if ($(this).width() < 550) {
    valuer.css('width', `${($(this).width() * 92) / 100}`);
    valuer.css('left', '2.8%');
  }
  if ($(this).width() < 800) {
    valuer.css('width', `${($(this).width() * 96) / 100}`);
    valuer.css('left', '.5%');
  } else {
    valuer.css('width', `${($(this).width() * 97) / 100}`);
    valuer.css('left', '0');
  }
});

/* input show image */
function shwoMyImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#addImage').css('background-image', 'url(' + e.target.result + ')');
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$('#offre_job_image').change(function () {
  shwoMyImage(this);
});

initializeData();

function initializeData() {
  if (sessionStorage.getItem('country')) {
    $('#paysInput').val(sessionStorage.getItem('country'));
  }
  if (sessionStorage.getItem('region')) {
    $('#regionInput').val(sessionStorage.getItem('region'));
  }
  if (sessionStorage.getItem('departement')) {
    $('#departmentInput').val(sessionStorage.getItem('departement'));
  }
}

// js animation and form validation
$('#paysInput').focusout(function () {
  check_nil($(this), $('.country-error'));
});
$('#regionInput').focusout(function () {
  check_nil($(this), $('.country-error'));
});
$('#departmentInput').focusout(function () {
  check_nil($(this), $('.departement-error'));
});
$('#intitule-pote').focusout(function () {
  check_nil($(this), $('.intitule-pote-error'));
});
$('#descriptif-mission').focusout(function () {
  check_nil($(this), $('.descriptif-mission-error'));
});
$('#rattachement').focusout(function () {
  check_nil($(this), $('.rattachement-error'));
});
$('#remuneration-anne').focusout(function () {
  check_nil($(this), $('.remuneration-anne-error'));
});
$('#type-deplacement').focusout(function () {
  check_nil($(this), $('.type-deplacement-error'));
});
$('#datepicker').focusout(function () {
  check_nil($(this), $('.dp-date-error'));
});
// check second party of create offre
$('#question1').focusout(function () {
  check_nil($(this), $('#question1-error'));
});
$('#question2').focusout(function () {
  check_nil($(this), $('#question2-error'));
});
$('#question3').focusout(function () {
  check_nil($(this), $('#question3-error'));
});
$('#question5').focusout(function () {
  check_nil($(this), $('#question5-error'));
});
/////////////////////////////////////////////////
// submit validation
$('#co-dp-btn').click(function () {
  if (
    $('#paysInput').val().length >= 1 &&
    $('#regionInput').val().length >= 1 &&
    $('#departmentInput').val().length >= 1 &&
    $('#intitule-pote').val().length >= 1 &&
    $('#descriptif-mission').val().length >= 1 &&
    $('#rattachement').val().length >= 1 &&
    $('#remuneration-anne').val().length >= 1 &&
    $('#datepicker').val().length >= 1 &&
    $('#type-deplacement').val().length >= 1
  ) {
    $('.ir-l1').addClass('color-bg');
    $('.ir-c1').addClass('color-bg');
    $('.detail-post-box').hide();
    $('.context-offre-box').fadeIn(800);
    var html = '';
    function round(x) {
      return Math.ceil(x / 5) * 5;
    }
    for (i = round(parseInt($('#remuneration').val())); i <= 350; i += 10) {
      let a = i + 5;
      html += '<option value=' + a + '>' + a + 'k€ bruts annuels </option>';
    }
    $('#remuneration-max').html(html);

    $('html, body').animate(
      {
        scrollTop: $('#elementtoScrollToID').offset().top,
      },
      500
    );
  } else {
    $('#co-dp-btn-error').html('(Veuillez corriger les erreurs dans le remplissage des champs.)');
    $('#co-dp-btn-error').show();
  }
});
// submit validation
$('.co-input-submit1').click(function () {
  if ($('#question1').val().length >= 1 && $('#question2').val().length >= 1 && $('#question3').val().length >= 1 && $('#question5').val().length >= 1 && $('.input_fied').val().length >= 1) {
    return true;
  } else {
    $('#co-dp-btn1-error').html('(Veuillez corriger les erreurs dans le remplissage des champs.)');
    $('#co-dp-btn1-error').show();
    return false;
  }
});
// submit validation update
$('.co-input-submit2').click(function () {
  if ($('#question1').val().length >= 1 && $('#question2').val().length >= 1 && $('#question3').val().length >= 1 && $('#question5').val().length >= 1) {
    return true;
  } else {
    $('#co-dp-btn1-error').html('(Veuillez corriger les erreurs dans le remplissage des champs.)');
    $('#co-dp-btn1-error').show();
    return false;
  }
});

// fonction check nil
function check_nil(test, value) {
  var name = test.val().length;
  if (name < 1) {
    test.css('outline', '.2px solid red');
    value.html('(Champ obligatoire)');
    value.show();
  } else {
    test.css('box-shadow', '0px 1px 5px 1px #e3d7bf');
    test.css('outline', '2px solid #e3d7bf ');
    value.hide();
  }
}
