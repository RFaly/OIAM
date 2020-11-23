$(document).on('page:fetch', function () {
  startSpinner();
});
window.startSpinner = function () {
  return $('#loading-indicator').fadeIn();
};

window.stopSpinner = function () {
  return $('#loading-indicator').fadeOut(1500);
};

$(document).ready(function () {
  //end check path menu recruteur
  stopSpinner();

  // check ipad pro 
  if ($(window).height() > $(window).width()) {
    $('.box').css('background-size', '170% 77%')
    $('.box-1-logo').css('width', '65%')
    $('.box-1-logo').css('margin', '33px auto 0 33px')
  }

  // add space before option
  $('option').prepend('&#160; &#160;');
  $('option').append('&#160; &#160;');
  // flash animation
  // console.log($('.flash').html().length)
  if ($('.flash').html().length < 10) {
    $('.flash').hide();
  } else {
    $('.flash').fadeIn(300);
    $('.flash-notice').addClass('active');
    $('.flash-alert').addClass('active');
    setTimeout(function () {
      $('.flash-notice').removeClass('active');
      $('.flash-alert').removeClass('active');
      $('.flash').fadeOut(2000);
    }, 5000);
  }
  // $('.flash').click(function () {});
  // check path
  var path = window.location.pathname.split('/').pop();

  //   remove backgroung of some page
  if (path == 'welcome' || path == 'equipe' || path == 'potential-test' || path == 'skills-test' || path == 'fit-test') {
    $('.navbar-controll').removeClass('bg-inside');
  }
  // scroll all
  if (!(path == 'welcome' || path == 'equipe' || path == ' ' || path == 'méthodologie')) {
    $('html, body').animate({
        scrollTop: $('#elementtoScroll').offset().top,
      },
      800
    );
  }

  // check menu navbar
  $('nav a[href="/' + path + '"]').addClass('act');

  // check path menu recruteur
  $('.left-menu-r a[href="/recruteur/' + path + '"]').addClass('color-this');
  $('.line-white').css('height', $('.cpe-si-td').height() + 25);
  $('.line-white2').css('height', $('.code-naf-flex').height() + 25);
  // check path menu cadre
  $('.left-menu-r a[href="/cadre/' + path + '"]').addClass('color-this');
  // check path menu recruteur suit
  // mon profil
  if (window.location.href.indexOf('/mon-profil') > -1) {
    $('.left-menu-r a[href="/recruteur/mon-profil"]').addClass('color-this');
  }
  // mes offres d'emploi
  if (window.location.href.indexOf('/mes-offre-d-emploi') > -1) {
    $('.left-menu-r a[href="/recruteur/mes-offre-d-emploi"]').addClass('color-this');
  }
  // mes candidats favoris
  if (window.location.href.indexOf('/mes-candidats-favoris') > -1) {
    $('.left-menu-r a[href="/recruteur/mes-candidats-favoris"]').addClass('color-this');
  }
  // mon suivi de recruteument
  if (window.location.href.indexOf('/mon-suivi-recrutement') > -1) {
    $('.left-menu-r a[href="/recruteur/mon-suivi-recrutement"]').addClass('color-this');
  }
  // mes factures
  if (window.location.href.indexOf('/mes-factures') > -1) {
    $('.left-menu-r a[href="/recruteur/mes-factures"]').addClass('color-this');
  }
  // mes notifications
  if (window.location.href.indexOf('/mes-notifications') > -1) {
    $('.left-menu-r a[href="/recruteur/mes-notifications"]').addClass('color-this');
  }
  // message
  if (window.location.href.indexOf('/messages') > -1) {
    $('.left-menu-r a[href="/recruteur/messages"]').addClass('color-this');
  }

});