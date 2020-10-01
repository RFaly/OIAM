window.$boitReception = $('#js-add-new-message');
window.$is_client = $('#is_client_session').data().client;
window.path_url = $('#form-promo-code').data().path;
console.log($('#Profilher').data().image);
var profil = $('#Profilher').data().image;
function creatAndApendNewMessage(data) {
  var div = document.createElement('div');
  var div2 = document.createElement('div2');
  var divClear = document.createElement('div');
  if ($is_client) {
    if (data.is_client) {
      $(div).addClass('my-message');
    } else {
      $(div).addClass('her-message');
    }
  } else {
    if (data.is_client) {
      $(div).addClass('her-message');
    } else {
      $(div).addClass('my-message');
    }
  }
  $(div2).css('background', 'url(' + $(profil) + ') center no-repeat;');
  $(div).attr('data-store-id', data.id);
  $(divClear).addClass('clear');
  $(div).html(data.content);
  $boitReception.append(div);
  $boitReception.append(divClear);
  $boitReception.animate(
    {
      scrollTop: $boitReception.prop('scrollHeight'),
    },
    2000
  );
}

function getMyMessage() {
  var storeId = $('div[data-store-id]').last().data().storeId;
  $.getJSON(path_url, function (data) {
    var my_data = data;
    for (var i = 0; i < my_data.length; i++) {
      if (my_data[i].id == storeId) {
        for (var j = i + 1; j < my_data.length; j++) {
          console.log(my_data[j]);
          creatAndApendNewMessage(my_data[j]);
        }
        break;
      }
    }
  });
}

setInterval(getMyMessage, 1000);
