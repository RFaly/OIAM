window.$boitReception = $("#js-add-new-message");
window.$is_admin = $("#is_admin_session").data().client;
window.path_url = $("#form-promo-code").data().path;
var profil = $("#Profilher").data().image;
function creatAndApendNewMessage(data) {
  var div = document.createElement("div");
  var div2 = document.createElement("div");
  var message = document.createElement("div");
  var divClear = document.createElement("div");
  if ($is_admin) {
    if (data.is_admin) {
      $(div).addClass("my-message");
    } else {
      $(div).addClass("her-message");
    }
  } else {
    if (data.is_admin) {
      $(div).addClass("her-message");
    } else {
      $(div).addClass("my-message");
    }
  }
  $(div2).attr(
    "style",
    "background: url(" + profil + ") center no-repeat; background-size: cover"
  );
  $(div2).attr("id", "image");
  $(message).html(data.content);

  $(div).attr("data-store-id", data.id);
  $(divClear).addClass("clear");
  $(div).append(div2);
  $(div).append(message);
  $boitReception.append(div);
  $boitReception.append(divClear);
  $boitReception.animate(
    {
      scrollTop: $boitReception.prop("scrollHeight"),
    },
    2000
  );
}

function getMyMessage() {
  var storeId = $("div[data-store-id]").last().data().storeId;
  $.getJSON(path_url, function (data) {
    var my_data = data;
    for (var i = 0; i < my_data.length; i++) {
      if (my_data[i].id == storeId) {
        for (var j = i + 1; j < my_data.length; j++) {
          creatAndApendNewMessage(my_data[j]);
        }
        break;
      }
    }
  });
}

setInterval(getMyMessage, 1000);
