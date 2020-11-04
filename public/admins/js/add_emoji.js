$(document).ready(function () {
  $(".fa-smile").click(function () {
    $(".emoji-dashboard").slideToggle("fast");
  });

  $(".emojie").click(function (e) {
    e.stopPropagation();
  });

  var list = $(".emojis");

  for (var i, li; (li = list.childNodes[i]); i++) {
    console.log(list[i]);
  }

  $(".emoji-dashboard li .em").click(function () {
    var emo = $(this).css("background-image").split('"')[1];
    $(".m-msg").remove();
    $(".m-msg").append('<img src="' + emo + '">');
  });
});
