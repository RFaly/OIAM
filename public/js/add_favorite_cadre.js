$('.add-js-toFavorite').click(function () {
  let testDiv = $('.js-candidates-list[data-info=false]');
  if (testDiv.length < 5) {
    let number = $(this).data().info;
    let currentDiv = $('.js-candidates-list[data-info=true]')[0];
    let image1 = $('.js-image-' + number);
    var image = image1.first().clone();
    $(currentDiv).html(image);
    currentDiv.dataset.info = false;
    currentDiv.dataset.element = number;
    $('.rmv-js-toFavorite[data-info=' + number + ']').show();
    $(this).hide();
    $('#input_cadre_ids').val(actualiseValueInArray());
    $(this).parent().css('border-top', '67px solid white');
  }
});

$('.rmv-js-toFavorite').click(function () {
  let testDiv = $('.js-candidates-list[data-info=false]');
  if (testDiv.length > 0) {
    let number = $(this).data().info;
    let currentDiv = $('.js-candidates-list[data-element=' + number + ']')[0];
    currentDiv.dataset.info = true;
    currentDiv.dataset.element = '';
    $(currentDiv).html('');
    $('.add-js-toFavorite[data-info=' + number + ']').show();
    $(this).hide();
    $('#input_cadre_ids').val(actualiseValueInArray());
    $(this).parent().css('border-top', '67px solid #d6b36a');
  }
});
$(document).ready(function () {
  if ($('.alreadyFavorite').length) {
    $('.alreadyFavorite').parent().css('border-top', '67px solid white');
  }
});
function actualiseValueInArray() {
  let listArray = [];
  $('.js-candidates-list[data-info]').each(function () {
    let element = this.dataset.element.toString();
    if (element.length >= 1) {
      listArray.push(element);
    }
  });
  return listArray;
}
