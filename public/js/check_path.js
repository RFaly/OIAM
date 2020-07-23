$(document).ready(function () {
  // check path
  var path = window.location.pathname.split('/').pop();
  //   remove navbar and footer in landing page
  if (path === '') {
    $('.navbar-controll').remove();
    $('.footer-controll').remove();
  }
  //   remove backgroung of some page
  if (path == 'welcome' || path == 'equipe') {
    $('.navbar-controll').removeClass('bg-inside');
  }
  // check menu navbar
  $('nav a[href="/' + path + '"]').addClass('act');
  // check path menu recruteur
  $('.left-menu-r a[href="/recruteur/' + path + '"]').addClass('color-this');
  $('.bg-uniq').css('height', $(document).height());
});
