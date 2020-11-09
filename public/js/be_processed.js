$(".currentDatentretien").ready(function () {
    let $elementDate = $('.currentDatentretien');
    $elementDate.each(function () {
        let dateUTC = moment.utc($(this).data().times);
        let dateGet = new Date(dateUTC.local());
        let dateString = dateGet.getDate()+"/"+(dateGet.getMonth()+1)+"/"+dateGet.getFullYear();
        $(this).html(dateString);
    });
});

$(document).ready(function () {
    if ($(".list-items-me").length == 0) {
        $("#none-element").fadeIn(500);
    }
    $("#filtre").change(function () {
        var search = $(this).val()
        var emptyS = true
        $(".list-items-me").each(function () {
            let thisiko = $(this)
            if ((search == thisiko.data().name) || (search == ".TOUS")) {
                thisiko.fadeIn(500);
                emptyS = false
            } else {
                thisiko.fadeOut(100);
            }
        });
        if (emptyS) {
            $("#none-element").fadeIn(500);
        } else {
            $("#none-element").fadeOut(100);
        }
    });
})