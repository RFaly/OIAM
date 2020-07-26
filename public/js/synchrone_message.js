var path = $("#form-promo-code").data('path')
var my_data = []
$.getJSON(path,function(data) {
	my_data = data
});
