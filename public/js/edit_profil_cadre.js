var slider = document.getElementById("slide");
var output = document.getElementById("value");

output.style.left = ((slider.value-60)*97)/290 + "%";


output.innerHTML = slide.value;

slider.oninput = function(){
    output.innerHTML = this.value;
    output.style.left = ((this.value-60)*97)/290 + "%";
}
    