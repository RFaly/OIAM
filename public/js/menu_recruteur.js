$(document).ready(function () {
  // js btn burger menu recruteur
  let check = true;
  if (screen.width < 700) {
    $('.btn-menu-burger').removeClass('open');
    $('.left-menu-r').addClass('open');
    $('.left-menu-photo').addClass('open');
    $('.left-menu-content').fadeOut(500);
    check = false;
  }
  $('.btn-menu-r').click(function () {
    if (check === true) {
      $('.btn-menu-burger').removeClass('open');
      $('.left-menu-r').addClass('open');
      $('.left-menu-photo').addClass('open');
      $('.left-menu-content').fadeOut(500);
      if ($(window).width() < 1200) {
        $('.line-white2').css('height', $('.code-naf-flex').height() + 5);
      }
      check = false;
    } else {
      $('.btn-menu-burger').addClass('open');
      $('.left-menu-r').removeClass('open');
      $('.left-menu-photo').removeClass('open');
      $('.left-menu-content').fadeIn(800);
      if ($(window).width() < 1200) {
        $('.line-white2').css('height', $('.code-naf-flex').height() + 45);
      }
      check = true;
    }
  });
});
