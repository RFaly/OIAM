/* input show image */
function shwoMyImage(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
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
function shwoMyImage2(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#addImage').css('background-image', 'url(' + e.target.result + ')');
      $('#addImage').width(220);
      $('#addImage').height(300);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$('#imagetag1').change(function () {
  shwoMyImage2(this);
});
