window.$boitReception = $('#js-add-new-message')
window.$is_client = $('#is_client_session').data().client
window.path_url = $("#form-promo-code").data().path

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
	var storeId = $("div[data-store-id]").last().data().storeId
	$.getJSON(path_url,function(data) {
		var my_data = data
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

//avoir les nombre des messages disponible
function numberMessage(){
	var herMessage = document.getElementsByClassName('her-message');
	var myMessage = document.getElementsByClassName('my-message');

	var nombre = herMessage.length + myMessage.length;

	return nombre;
}

//cacher les messages
function hideMessage(){
	//variable contenant le nombre des messages
	var nombreMessage = numberMessage();

	//verification si les nombre des messages est superieur à 10
	if(nombreMessage){
		
	}
}


var myMessage = document.getElementsByClassName('my-message');

for(let i = 0; i < myMessage.length; i++){
	console.log(myMessage[i]);
}





