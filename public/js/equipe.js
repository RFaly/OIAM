$('#emmanuel').click(function () {
  $('.big-box').fadeIn(800);
  $('.big-box').css('display', 'flex');
});
$('.closed').click(function () {
  $('.big-box').fadeOut(800);
});
$(document).mouseup(function (e) {
  var container = $('.big-box');

  // if the target of the click isn't the container nor a descendant of the container
  if (!container.is(e.target) && container.has(e.target).length === 0) {
    container.fadeOut(800);
  }
});
