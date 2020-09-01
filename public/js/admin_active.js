// var links = document.getElementsByClassName("navbar-ul");
// var btns = links.getElementsByClassName("navbar-item");
// for (var i = 0; i < btns.length; i++) {
// 	btns[i].addEventListener("click", function() {
// 	// var current = document.getElementsByClassName("active");
// 	// current[0].className = current[0].className.replace(" active", "");
// 	// this.className += " active";
// 	console.log('oeeee');
// 	});
// }
// // $(document).ready(function () {
// // 	var loc = window.location.pathname;

// //     $('.navbar-ul').find('a').each(function() {
// //      	$(this).toggleClass('active', $(this).attr('href') == loc);
// //   	});	
// // }

var loc = window.location.pathname;

$('.navbar-ul').find('a').each(function() {
  $(this).toggleClass('active', $(this).attr('href') == loc);
});


