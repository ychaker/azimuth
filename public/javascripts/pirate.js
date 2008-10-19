$(document).ready(function() {

	function hunt_list_click() {
		$("#accordion").accordion("activate", 1);
		id = $(this).attr("id").split("-")[2];
		$("#hunt_id").attr("value", id);
		$("div#add-clues.right-container.selected > div.right-content").css("overflow","auto").css("height","");
		$("#add-clues div.right-content-body").load('/hunts/' + id);
	}


	
	if (GBrowserIsCompatible()) {
		var map = new GMap2(document.getElementById("map"));
		map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	}

	$("#hunt-list").sortable({});

	$("#hunt-new-submit").click(function() {
		vars = { authenticity_token: window._token };
		
		$("#hunt-new input[type='text'], #hunt-new input[type='hidden']")
			.each(function() {
				vars['hunt[' + $(this).attr('id') + ']'] = $(this).attr('value');
			});
		
		// console.log(vars);

		$.post('/hunts', vars, function(data) {
			$("#hunt-list").append(data);
			$("li.new-hunt-no-event").click(hunt_list_click);
			$("#hunt-new").fadeOut(function() {
				$("#accordion").fadeIn();
			});
		}, "html");
		return false;
	});
	
	$("#accordion").accordion({ 
		header: "div.right-heading",
		clearStyle: true
	});
	
	$("#hunt-list a").click(hunt_list_click);
	
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
		
			$("#treasure-new").find("input[type='text']").each(function() {
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