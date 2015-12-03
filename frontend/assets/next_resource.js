$( function() {
	function getURLParam(sParam) {
		var sPageURL = window.location.search.substring(1);
		var sURLVariables = sPageURL.split('&');
		for(var i = 0; i < sURLVariables.length; i++) {
			var sParameterName = sURLVariables[i].split('=');
			if(sParameterName[0] == sParam) {
				return sParameterName[1];
			}
		}
	}

	$("#resource_id_0_").val(getURLParam('resource_id'));

})
