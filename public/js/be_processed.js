$(".currentDatentretien").ready(function () {
    var month = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    var day = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
    let $elementDate = $('.currentDatentretien');
    $elementDate.each(function () {
        let dateUTC = moment.utc($(this).data().times);
        let dateGet = new Date(dateUTC.local());
        let dateString = day[dateGet.getDay()] + ' ' + dateGet.getDate() + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
        // let minute = dateGet.getMinutes()
        // if((minute+"").length == 1){
        //   minute = "0"+minute
        // }
        $(this).html(dateString)
        // $(this).html(dateString + ' à ' + dateGet.getHours() + 'h:'+ minute );
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