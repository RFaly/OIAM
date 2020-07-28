$(document).ready(function(){

    $(".cv-champs").change(function() {
   shwoNameCv(this);
    });

    function shwoNameCv(input) {
     if (input.files && input.files[0]) {
       var cv_filename_show = $('#cv-filename');
       $(cv_filename_show).text(cv_filename);
     }
}
 });


var slider = document.getElementById("slide");
var output = document.getElementById("value");

output.style.left = ((slider.value-60)*97)/290 + "%";


output.innerHTML = slide.value;

slider.oninput = function(){
    output.innerHTML = this.value;
    output.style.left = ((this.value-60)*97)/290 + "%";
}


var filename = document.getElementById('cv-filename');
var cv_filename = document.getElementsByClassName('cv-champs');
