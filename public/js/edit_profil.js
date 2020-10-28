$('#cp-full-name').focusout(function () {
  var full_name = $(this).val().split(' ');
  var first_name = $(this).val().split(' ');
  first_name.pop();
  $('#cp-first-name').val(first_name.join(' '));
  $('#cp-last-name').val(full_name[full_name.length - 1]);
});