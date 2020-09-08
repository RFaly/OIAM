$(document).ready(function () {
  $('#datepicker').datepicker({
    dateFormat: 'yy-mm-dd',
    inline: true,
    minDate: 0,
    showOtherMonths: true,
    dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
    monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
    monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
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
    beforeShow: function (input, inst) {
      // Handle calendar position before showing it.
      // It's not supported by Datepicker itself (for now) so we need to use its internal variables.
      var calendar = inst.dpDiv;

      // Dirty hack, but we can't do anything without it (for now, in jQuery UI 1.8.20)
      setTimeout(function () {
        calendar.position({
          my: 'left top',
          at: 'left bottom',
          collision: 'none',
          of: input,
        });
      }, 1);
    },
  });
});
