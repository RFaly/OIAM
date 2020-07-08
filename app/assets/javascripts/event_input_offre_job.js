// show value integer remuneration

$("#remuneration").change(function () {
	$("#inputRange").html($('#remuneration').val());
});

//input show image
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#addImage').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$("#offre_job_image").change(function() {
	readURL(this);
});

// Lite region de france et departement
var franceData = [{"region": "Auvergne-Rhône-Alpes","departement": ["Ain","Allier","Ardèche ","Cantal","Drôme","Isère","Loire ","Haute-Loire ","Puy-de-Dôme"," Rhône + Métropole de Lyon","Savoie","Haute-Savoie"]},{"region": "Bourgogne-Franche-Comté","departement": ["Côte-d'Or","Doubs","Jura","Nièvre","Haute-Saône","Saône-et-Loire","Yonne","Territoire de Belfort"]},{"region": "Bretagne","departement": ["Côtes-d'Armor","Finistère","Ille-et-Vilaine","Morbihan"]},{"region": "Centre-Val de Loire","departement": ["Cher","Eure-et-Loir","Indre","Indre-et-Loire","Loir-et-Cher","Loiret"]},{"region": "Corse","departement": ["Corse-du-Sud","Haute-Corse"]},{"region": "Grand Est","departement": ["Ardennes","Aube","Marne","Haute-Marne","Meurthe-et-Moselle","Meuse","Moselle","Bas-Rhin","Haut-Rhin","Vosges"]},{"region": "Hauts-de-France","departement": ["Aisne","Nord","Oise","Pas-de-Calais","Somme"]},{"region": "Île-de-France","departement": ["Paris","Seine-et-Marne","Yvelines","Essonne","Hauts-de-Seine","Seine-Saint-Denis","Val-de-Marne","Val-d'Oise"]},{"region": "Normandie","departement": ["Calvados","Eure","Manche","Orne","Seine-Maritime"]},{"region": "Nouvelle-Aquitaine","departement": ["Charente","Charente-Maritime","Corrèze","Creuse","Dordogne","Gironde","Landes","Lot-et-Garonne","Pyrénées-Atlantiques","Deux-Sèvres","Vienne","Haute-Vienne"]},{"region": "Occitanie","departement": ["Ariège","Aude","Aveyron","Gard","Haute-Garonne","Gers","Hérault","Lot","Lozère","Hautes-Pyrénées","Pyrénées-Orientales","Tarn","Tarn-et-Garonne"]},{"region": "Pays de la Loire","departement": ["Loire-Atlantique","Maine-et-Loire","Mayenne","Sarthe","Vendée"]},{"region": "Provence-Alpes-Côte d'Azur","departement": ["Alpes-de-Haute-Provence","Hautes-Alpes","Alpes-Maritimes","Bouches-du-Rhône","Var","Vaucluse"]}];

// Change input region for pays
$("#paysInput").change(function() {
	if($(this).val() == "France"){
		var listOptionRegion = "<option value=''>Région</option>"
		for (var i = 0; i < franceData.length; i++) {
			listOptionRegion += "<option data-index='"+i+"' value='"+franceData[i].region+"'>"+franceData[i].region+"</option>";
		}
		$("#regionInput").html(listOptionRegion)
		$("#regionInput").prop('disabled', false);
	}else{
		$("#regionInput").html("<option value=''>Région</option>")
		$("#departmentInput").html("<option value=''>Département</option>")
		$("#regionInput").prop('disabled', true);
		$("#departmentInput").prop('disabled', true);
	}
});

// change input depatement for Région
$("#regionInput").change(function() {
	let allOptions = document.getElementById("regionInput").options
	let listDepartement = "<option value=''>Département</option>"
	for (var i = 0; i < allOptions.length; i++) {
		if ($(allOptions[i]).val() == $(this).val()){
			let currentDepartment = franceData[allOptions[i].dataset.index].departement
			for (var j = 0; j < currentDepartment.length; j++) {
				listDepartement += "<option value='"+currentDepartment[j]+"'>"+currentDepartment[j]+"</option>";
			}
			break;
		}
	}
	$("#departmentInput").html(listDepartement)
	$("#departmentInput").prop('disabled', false);
});
