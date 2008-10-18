$(document).ready(function() {
	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	}

	$("#hunt-list").sortable({});

	$("#hunt-new-submit").click(function() {
		$.post('/hunts', { "hunt[name]": $("#hunt-new-name").attr('value'), authenticity_token: window._token }, function(data) {
			$("#hunt-new").hide();
			$("#current-hunt").hide().html(data).fadeIn();
		}, "html");
	});
	
	$("#hunt-new-link").click(function() {
		$("#hunt-new").fadeIn();
	});
});