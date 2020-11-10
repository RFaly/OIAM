$(document).ready(function () {
  $('#search').hide()
  let test_it = true;
  $(".calendar").click(function () {
    if (test_it) {
      $('#search').fadeIn(800)
      test_it = false
    } else {
      $('#search').fadeOut(200)
      test_it = true
    }
  })
  $("#delete_filter").click(function () {
    $("#filtre").val(".TOUS")
    $("#enter_date_min").val("")
    $("#enter_date_max").val("")
    $("#lim_date_min").val("")
    $("#lim_date_max").val("")

    if ($('.list-items-me').length == 0) {
      $("#none-element").fadeIn(800);
    } else {
      $('.list-items-me').fadeIn(800);
      $("#none-element").fadeOut(200);
    }
  });

  if ($('.list-items-me').length == 0) {
    $("#none-element").fadeIn();
  }

  $(".currentDatentretien").ready(function () {
    let $elementDate = $('.currentDatentretien');
    $elementDate.each(function () {
      let dateUTC = moment.utc($(this).data().times);
      let dateGet = new Date(dateUTC.local());
      let dateString = dateGet.getDate() + "/" + (dateGet.getMonth() + 1) + "/" + dateGet.getFullYear();
      $(this).html(dateString);
    });
  });

  $(".input-date-js").change(function () {
    run_filter();
  });
})


function run_filter() {
  enter_date_min = $("#enter_date_min").val()
  enter_date_max = $("#enter_date_max").val()

  lim_date_min = $("#lim_date_min").val()
  lim_date_max = $("#lim_date_max").val()

  if (enter_date_min != "") {
    enter_date_min = new Date(enter_date_min)
  }

  if (enter_date_max != "") {
    enter_date_max = new Date(enter_date_max)
  }

  if (lim_date_min != "") {
    lim_date_min = new Date(lim_date_min)
  }

  if (lim_date_max != "") {
    lim_date_max = new Date(lim_date_max)
  }

  filter_select = $("#filtre").val()

  filterItems(enter_date_min, enter_date_max, lim_date_min, lim_date_max, filter_select);
}

function filterItems(enter_date_min = "", enter_date_max = "", lim_date_min = "", lim_date_max = "", filter_select = ".TOUS") {
  let numberHide = 0
  let $listElement = $(".list-items-me")
  $listElement.each(function () {
    let thisiko = $(this)
    let date_enter = thisiko.data().min
    let date_lim = thisiko.data().max
    if (date_enter.length > 3) {
      tmp_min = date_enter.split("/")
      date_enter = new Date(tmp_min[2], (tmp_min[1] - 1), tmp_min[0])
    }
    if (date_lim.length > 3) {
      tmp_max = date_lim.split("/")
      date_lim = new Date(tmp_max[2], (tmp_max[1] - 1), tmp_max[0])
    }
    if (enter_date_min == "") {

    } else {
      if (date_enter < enter_date_min) {
        thisiko.fadeOut(200);
        numberHide++;
        return;
      } else {
        thisiko.fadeIn(800);
      }
    }

    if (enter_date_max == "") {

    } else {
      if (date_enter > enter_date_max) {
        thisiko.fadeOut(200);
        numberHide++;
        return;
      } else {
        thisiko.fadeIn(800);
      }
    }

    if (lim_date_min == "") {

    } else {
      if (date_lim < lim_date_min) {
        thisiko.fadeOut(200);
        numberHide++;
        return;
      } else {
        thisiko.fadeIn(800);
      }
    }

    if (lim_date_max == "") {

    } else {
      if (date_lim > lim_date_max) {
        thisiko.fadeOut(200);
        numberHide++;
        return;
      } else {
        thisiko.fadeIn(800);
      }
    }

    if (filter_select == ".TOUS") {
      thisiko.fadeIn(800);
    } else {
      if (filter_select == thisiko.data().name) {
        thisiko.fadeIn(800);
      } else {
        thisiko.fadeOut(200);
        numberHide++;
        return;
      }
    }
  });
  if ($listElement.length == numberHide) {
    $("#none-element").fadeIn(800);
  } else {
    $("#none-element").fadeOut(200);
  }
}