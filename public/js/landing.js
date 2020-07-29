var height = $(window).height();
var windth = $(window).width();
if (height < 650) {
  $('.box-2').width(windth * 0.5);
} else if (height < 750) {
  $('.box-2').width(windth * 0.6);
} else {
  $('.box-2').width(windth * 0.7);
}
