$('#newslettres').click(function () {
  $(this).fadeOut(100);
  function showpanel() {
    $('#input-mail').css('display', 'flex');
    $('#input-mail').css('transform', 'translateX(0)');
  }
  setTimeout(showpanel, 200);
});
// check mail
$('#input-types').on('input', function () {
  check_mail($(this));
});
// fonction check mail
function check_mail(testee) {
  var pattern = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
  if (pattern.test(testee.val())) {
    $('#submit').removeAttr('disabled');
  } else {
    $('#submit').attr('disabled', 'disabled');
  }
}
