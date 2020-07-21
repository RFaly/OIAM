$(document).ready(function () {
  var path = window.location.pathname.split('/').pop();
  console.log(`${path}`);

  let target = $('nav a[href="/' + path + '"]');
  target.addClass('act');

  let check = true;
  $('.btn-btn').click(function () {
    if (check === true) {
      $('.btn-btn-burger').addClass('open');
      $('.navbar-content').fadeIn(800);
      check = false;
    } else {
      $('.btn-btn-burger').removeClass('open');
      $('.navbar-content').fadeOut(500);
      check = true;
    }
  });
  let check1 = true;
  $(' .dropup-btn1').click(function () {
    if (check1) {
      $('.dropup-content1').fadeIn(800);
      check1 = false;
    } else {
      $('.dropup-content1').fadeOut(500);
      check1 = true;
    }
  });
});
