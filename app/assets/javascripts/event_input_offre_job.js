
// if (sessionStorage.getItem("country")){
// 	$("#paysInput").val(sessionStorage.getItem("country"))
// 	$("#regionInput").prop('disabled', false);
// 	$("#departmentInput").prop('disabled', false);
// 	$("#regionInput").val(sessionStorage.getItem("region"));
// 	$("#departmentInput").val(sessionStorage.getItem("departement"));
// }

/* INITIALISER LES VALEURS */
var franceData = [{"region": "Auvergne-Rhône-Alpes","departement": ["Ain","Allier","Ardèche ","Cantal","Drôme","Isère","Loire ","Haute-Loire ","Puy-de-Dôme"," Rhône + Métropole de Lyon","Savoie","Haute-Savoie"]},{"region": "Bourgogne-Franche-Comté","departement": ["Côte-d'Or","Doubs","Jura","Nièvre","Haute-Saône","Saône-et-Loire","Yonne","Territoire de Belfort"]},{"region": "Bretagne","departement": ["Côtes-d'Armor","Finistère","Ille-et-Vilaine","Morbihan"]},{"region": "Centre-Val de Loire","departement": ["Cher","Eure-et-Loir","Indre","Indre-et-Loire","Loir-et-Cher","Loiret"]},{"region": "Corse","departement": ["Corse-du-Sud","Haute-Corse"]},{"region": "Grand Est","departement": ["Ardennes","Aube","Marne","Haute-Marne","Meurthe-et-Moselle","Meuse","Moselle","Bas-Rhin","Haut-Rhin","Vosges"]},{"region": "Hauts-de-France","departement": ["Aisne","Nord","Oise","Pas-de-Calais","Somme"]},{"region": "Île-de-France","departement": ["Paris","Seine-et-Marne","Yvelines","Essonne","Hauts-de-Seine","Seine-Saint-Denis","Val-de-Marne","Val-d'Oise"]},{"region": "Normandie","departement": ["Calvados","Eure","Manche","Orne","Seine-Maritime"]},{"region": "Nouvelle-Aquitaine","departement": ["Charente","Charente-Maritime","Corrèze","Creuse","Dordogne","Gironde","Landes","Lot-et-Garonne","Pyrénées-Atlantiques","Deux-Sèvres","Vienne","Haute-Vienne"]},{"region": "Occitanie","departement": ["Ariège","Aude","Aveyron","Gard","Haute-Garonne","Gers","Hérault","Lot","Lozère","Hautes-Pyrénées","Pyrénées-Orientales","Tarn","Tarn-et-Garonne"]},{"region": "Pays de la Loire","departement": ["Loire-Atlantique","Maine-et-Loire","Mayenne","Sarthe","Vendée"]},{"region": "Provence-Alpes-Côte d'Azur","departement": ["Alpes-de-Haute-Provence","Hautes-Alpes","Alpes-Maritimes","Bouches-du-Rhône","Var","Vaucluse"]}];
var listOptionRegion = ""
var listOptionDepartment = ""
for (var i = 0; i < franceData.length; i++) {
	listOptionRegion += '<option data-index="'+i+'" value="'+franceData[i].region+'">'+franceData[i].region+'</option>';			
	var departments = franceData[i].departement
	for (var j = departments.length - 1; j >= 0; j--) {
		listOptionDepartment += '<option data-index="'+i+'" value="'+departments[j]+'">'+departments[j]+'</option>';
	}
}
$("#regionInput").html(listOptionRegion)
$("#departmentInput").html(listOptionDepartment)



/* Lite region de france et departement */
// Change input region for pays
$("#paysInput").change(function() {
	sessionStorage.setItem("country",this.value)
	if($(this).val() == "France"){
		var listOptionRegion = "<option value=''>Région</option>"
		for (var i = 0; i < franceData.length; i++) {
			listOptionRegion += '<option data-index="'+i+'" value="'+franceData[i].region+'">'+franceData[i].region+'</option>';
		}
		$("#regionInput").html(listOptionRegion)
		sessionStorage.setItem("country","France")
	}else{
		/* A VOIR */
	}
});

// change input depatement for Région
$("#regionInput").change(function() {
	let allOptions = document.getElementById("regionInput").options
	let listDepartement = ""
	for (var i = 0; i < allOptions.length; i++) {
		if ($(allOptions[i]).val() == $(this).val()){
			let currentDepartment = franceData[allOptions[i].dataset.index].departement
			for (var j = 0; j < currentDepartment.length; j++) {
				listDepartement += '<option data-index="'+allOptions[i].dataset.index+'" value="'+currentDepartment[j]+'">'+currentDepartment[j]+'</option>';
			}
			$("#paysInput").val("France")
			sessionStorage.setItem("country","France")
			break;
		}
	}
	$("#departmentInput").html(listDepartement)
	sessionStorage.setItem("region",this.value)
	sessionStorage.setItem("departement",$("#departmentInput").val())
});

$("#departmentInput").change(function(){
	let allOptions = document.getElementById("departmentInput").options
	for (var i = 0; i < allOptions.length; i++) {
		if ($(allOptions[i]).val() == $(this).val()){
			$("#regionInput").val(franceData[allOptions[i].dataset.index].region)
			$("#paysInput").val("France")
			break;
		}
	}
	sessionStorage.setItem("country","France")
	sessionStorage.setItem("region",$("#regionInput").val())
	sessionStorage.setItem("departement",this.value)
});

/* show value integer remuneration */
$("#remuneration").change(function () {
	$("#inputRange").html($('#remuneration').val());
});

/* input show image */
function shwoMyImage(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#addImage').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$("#offre_job_image").change(function() {
	shwoMyImage(this);
});


initializeData();

function initializeData(){
	if(sessionStorage.getItem("country")){
		$("#paysInput").val(sessionStorage.getItem("country"))
	}
	if(sessionStorage.getItem("region")){
		$("#regionInput").val(sessionStorage.getItem("region"))
	}
	if(sessionStorage.getItem("departement")){
		$("#departmentInput").val(sessionStorage.getItem("departement"))
	}
}
