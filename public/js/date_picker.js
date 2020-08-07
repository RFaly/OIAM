$(document).ready(function () {
  $('#datepicker').datepicker({
    dateFormat: 'dd/mm/yy',
    inline: true,
    minDate: 0,
    showOtherMonths: true,
    dayNamesMin: ['', '', '', '', '', '', ''],
    monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
    monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
    beforeShow: function (input, inst) {
      setTimeout(function () {
        inst.dpDiv.css({
          top: 1000,
          left: 700,
        });
      }, 0);
    },
    onSelect: function (date) {
      // Your CSS changes, just in case you still need them
      var date = $('#datepicker').datepicker('getDate');
      let dateGet = new Date($.datepicker.formatDate('yy-mm-dd', date));
      let dateString = day[dateGet.getDay()] + ' ' + dateGet.getDate() + ' ' + month[dateGet.getMonth()] + ' ' + dateGet.getFullYear();
      $('#showDateLong').html(dateString);
      $('#dateShowOk').html(dateString);
      $('#datepicker').hide();
      $('.js-timeContainer').show();
    },
  });
});
