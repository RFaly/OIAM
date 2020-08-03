$('.co-with-job').on('click', '.delete', function (e) {
  console.log(e.currentTarget.id);
  console.log($('.coj-box:eq(e.currentTarget.id)'));
  var box = $('.coj-box').eq(e.currentTarget.id);
  box.fadeOut(500);
});
