$('.co-with-job').on('click', '.delete', function (e) {
  var box = $('.coj-box').eq(e.currentTarget.id);
  box.fadeOut(500);
});
