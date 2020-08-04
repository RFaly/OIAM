

$(".importe-cv").click(function(){
  let value = $(".cv-champs").files;
  alert(value)
})



var slider = document.getElementById("slide");
var output = document.getElementById("value");

output.style.left = ((slider.value-62)*97)/290 + "%";


output.innerHTML = slide.value;

slider.oninput = function(){
    output.innerHTML = this.value;
    output.style.left = ((this.value-62)*97)/290 + "%";
}


var filename = document.getElementById('cv-filename');
var cv_filename = document.getElementsByClassName('cv-champs');
