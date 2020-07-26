window.$boitReception = $('#js-add-new-message')
window.$is_client = $('#is_client_session').data().client

function creatAndApendNewMessage(data){
	var div = document.createElement('div')
	var divClear = document.createElement('div')
	if ($is_client) {
		if (data.is_client) {
			$(div).addClass('my-message')
		}else{
			$(div).addClass('her-message')
		}
	}else{
		if (data.is_client) {
			$(div).addClass('her-message')
		}else{
			$(div).addClass('my-message')
		}
	}
	$(div).attr('data-store-id',data.id)
	$(divClear).addClass('clear')
	$(div).html(data.content)
	$boitReception.append(div)
	$boitReception.append(divClear)
}

function getMyMessage(){
	var path = $("#form-promo-code").data().path
	$.getJSON(path,function(data) {
		console.log('a')
		var my_data = data

		var storeId = $("div[data-store-id]").last().data().storeId

		for (var i = 0; i < my_data.length; i++) {
			if (my_data[i].id == storeId){
				for (var j = i+1; j < my_data.length; j++) {
					creatAndApendNewMessage(my_data[j])
				}
				break;
			}
		}
	});
}

setInterval(getMyMessage, 10000);
