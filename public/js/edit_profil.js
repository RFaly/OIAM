$('#cp-full-name').focusout(function () {
  var full_name = $(this).val().split(' ');
  var first_name = full_name.splice(1).join(' ');
  $('#cp-first-name').val(first_name);
  $('#cp-last-name').val(full_name[0]);
});
