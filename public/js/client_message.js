$(document).ready(function () {
  if (document.URL.indexOf('#') == -1) {
    // Set the URL to whatever it was plus "#".
    url = document.URL + '#';
    location = '#';
    //Reload the page
    location.reload(true);
  }
  //scroll bottom
  var container = document.querySelector('#js-add-new-message');
  container.scrollTop = container.scrollHeight;
  //clear form
  $('#form-promo-code').bind('ajax:beforeSend', function () {
    $('#message_client_cadre_content')[0].value = '';
    $('#message_client_cadre_content').focus();
  });

  $('#form-promo-code').bind('ajax:complete', function () {
    $('#message_client_cadre_content')[0].value = '';
    $('#message_client_cadre_content').focus();
  });
  //focus outerHeigh
  $('#message_client_cadre_content').css('box-shadow', '1px 1px 1px 1px white');
  $('#message_client_cadre_content').focusout(function () {
    $(this).css('outline', 'none');
    $(this).css('box-shadow', '1px 1px 1px 1px white');
  });
  $('#message_client_cadre_content').focus(function () {
    $(this).css('outline', 'none');
    $(this).css('box-shadow', '1px 1px 3px 1px #d6b36a');
  });
});