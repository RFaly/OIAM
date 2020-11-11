$('.admincp-box').on('click', $('.acp-nam'), function (e) {
    $height = $('#' + $(e.target).data().items).height()
    $heighti = $('#' + $(e.target).data().items + 'i').height() + 20
    if ($height != 0) {
        $('.hide-box').height(0);
    } else {
        $('.hide-box').height(0);
        $('#' + $(e.target).data().items)
            .height(`${$heighti}`)
            .delay(1000).css('transition', 'all 500ms ease');
    }
});