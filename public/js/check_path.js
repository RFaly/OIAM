$(document).ready(function () {
  // flash animation
  if ($('.flash').html().length == 6) {
    $('.flash').hide();
  } else {
    $('.flash').fadeIn(300);
    $('.flash-notice').addClass('active');
    setTimeout(function () {
      $('.flash-notice').removeClass('active');
      $('.flash').fadeOut(2000);
    }, 2700);
  }
  $('.flash').click(function () {});
  // check path
  var path = window.location.pathname.split('/').pop();

  //   remove backgroung of some page
  if (path == 'welcome' || path == 'equipe' || path == 'potential-test' || path == 'skills-test' || path == 'fit-test') {
    $('.navbar-controll').removeClass('bg-inside');
  }

  // check menu navbar
  $('nav a[href="/' + path + '"]').addClass('act');

  // check path menu recruteur
  $('.left-menu-r a[href="/recruteur/' + path + '"]').addClass('color-this');
  $('.line-white').css('height', $('.cpe-si-td').height() + 25);
  $('.left-menu-r a[href="/cadre/' + path + '"]').addClass('color-this');
  $('.line-white').css('height', $('.cpe-si-td').height() + 25);
});
