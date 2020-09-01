var loc = window.location.pathname;

$('.left-menu-content').find('a').each(function() {
  $(this).toggleClass('active', $(this).attr('href') == loc);
});