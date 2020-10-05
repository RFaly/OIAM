// custom date picker
$("#calendar").datepicker({
  dateFormat: "dd/mm/yy",
  inline: true,
  minDate: 0,
  showOtherMonths: true,
  dayNamesMin: ["D", "L", "M", "M", "J", "V", "S"],
  monthNames: [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre",
  ],
  monthNamesShort: [
    "Janv.",
    "Févr.",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juil.",
    "Août",
    "Sept.",
    "Oct.",
    "Nov.",
    "Déc.",
  ],
  onSelect: function (date) {
    $("#calendar").css("box-shadow", "0px 1px 5px 1px #e3d7bf");
    $("#calendar").css("outline", "2px solid #e3d7bf ");
    $(".calendar-err").hide();
  },
});
