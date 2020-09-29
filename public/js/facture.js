/* input show image */
function shwoMyImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#addimage').css('display', 'block');
      $('#addimage').css('background-image', 'url(' + e.target.result + ')');
      $('#addimage').width(220);
      $('#addimage').height(300);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$('#image').change(function () {
  shwoMyImage(this);
});
