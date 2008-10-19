$(document).ready(function() {
	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	}

	$("#hunt-list").sortable({});

	$("#hunt-new-submit").click(function() {
		$.post('/hunts', { "hunt[name]": $("#hunt-new-name").attr('value'), authenticity_token: window._token }, function(data) {
			$("#hunt-new").hide(function() {
				$("#accordion").fadeIn();
			});
			// $("#add-clues div.right-content").html(data).fadeIn();
		}, "html");
		return false;
	});
	
	$("#accordion").accordion({ header: "div.right-heading" });
	
	$("#hunt-list a").click(function() {
		$("#accordion").accordion("activate", 1);
		id = $(this).attr("id").split("-")[2];
		$("#add-clues div.right-content").load('/hunts/' + id);
	});
	
	$("#treasure-new-submit").click(function() {
		vars = { authenticity_token: window._token };

		$("#treasure-new input[type='text'], #treasure-new input[type='hidden']")
			.each(function() {
				vars['treasure[' + $(this).attr('id') + ']'] = $(this).attr('value');
			});
		
		console.log(vars);
		
		$.post('/hunts/add_treasure', vars, function(data) {
			$("#treasure-list")
				.append(data);

			$('.new-treasure')
				.effect("highlight", {}, 500)
				.removeClass('new-treasure');

			$("#treasure-new").fadeOut()
				.find("input[type='text']").each(function() {
					$(this).attr("value","");
				});
				
		}, "html");
		
		return false;
	});
	
	$("#hunt-new-link").click(function() {
		$("#accordion").fadeOut("fast", function() {
			$("#hunt-new").fadeIn();			
		});
	});

	$("#hunt-new-cancel-link").click(function() {
		$("#hunt-new").fadeOut("fast", function() {
			$("#accordion").fadeIn();			
		});
	});

});