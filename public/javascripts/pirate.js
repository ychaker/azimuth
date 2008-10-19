$(document).ready(function() {
	curr_hunt = 0;

	$("li.new-hunt-no-event").removeClass("new-hunt-no-event");

	hunt_list_click = function(obj) {
		$(".chosen").removeClass("chosen");
		$(obj).addClass("chosen");
		id = $(obj).attr("id").split("-")[2];
		curr_hunt = id;
		$("#map").addClass("hunt-chosen");
		$("#add-clues div.right-content-body").load('/hunts/' + id, function() { 
			$("#accordion").accordion("activate", 1);	
		});
	}
	
	$("div#add-clues div.right-heading").click(function() {
		if (curr_hunt == 0) {
			alert("Please choose a hunt first");
			return false;
		}
	});
	
	$("#hunt-new-submit").click(function() {
		vars = { authenticity_token: window._token };
		
		$("#hunt-new input[type='text'], #hunt-new input[type='hidden'], #hunt-new textarea")
			.each(function() {
				vars['hunt[' + $(this).attr('id') + ']'] = $(this).attr('value');
			});
		
		$.post('/hunts', vars, function(data) {
			$("#hunt-list").append(data);
			$("li.new-hunt-no-event a.select-hunt-lnk").click(function() {
				hunt_list_click(this);
			});
			
			$("#map").addClass("hunt-chosen");

			$("li.new-hunt-no-event a.delete-hunt-lnk").click(function() {
				delete_hunt(this);
			});
			
			curr_hunt = $("li.new-hunt-no-event").attr("id").split("-")[2];
			$("li.new-hunt-no-event").removeClass("new-hunt-no-event").find("a.select-hunt-lnk").addClass("chosen");
			$("#hunt-new").fadeOut(function() {
				$("#accordion").fadeIn().accordion("activate", 1);
			});
		}, "html");
		return false;
	});
	
	$("a.delete-hunt-lnk").click(function() {
		delete_hunt(this);
	});
	
	$("#start-hunt").click(function() {
		if (curr_hunt == 0) {
			alert("Please choose a hunt first");
			return false;
		}
		location.href = "/hunters/start/" + curr_hunt;
	});
	
	function delete_hunt(obj) {
		id = $(obj).attr('id').split('-')[2];
		if (id == curr_hunt) {
			curr_hunt = 0;
			$("#map").removeClass("hunt-chosen");
		}
		
		$.ajax({
			type: 'DELETE',
			url: '/hunts/' + id + "?authenticity_token=" + window._token,
			complete: function(data, textStatus) {
				$("li#list-hunt-" + id).fadeOut(function() {
					$(this).remove();
				})
			}
		})
	}
	
	$("#hunt-new-cancel").click(function() {
		$("#hunt-new").fadeOut("fast", function() {
			$("#accordion").fadeIn();
		});

		$("#hunt-new input[type='text']").each(function() {
			$(this).attr("value","");
		});
	});

	$("#accordion").accordion({ 
		header: "div.right-heading",
		clearStyle: true
	});
	
	$("#hunt-release-btn").click(function() {
		console.log("/hunts/update/" + curr_hunt);
		$.ajax({
			type: "POST",
			url: "/hunts/update/" + curr_hunt,
			data: { hunt_event : 'release_the_hounds', authenticity_token: window._token },
			complete: function(data, textStatus) {
				alert("hounds released...");
				$(this).attr("enabled", "false");
			}
		});
	});
	
	$("#hunt-list a.select-hunt-lnk").click(function() {
		hunt_list_click(this);
	});
	
	$("#treasure-new-submit").click(function() {
		vars = { authenticity_token: window._token, 'treasure[hunt_id]' : curr_hunt, 'treasure[description]' : '--' };
		
		$("#treasure-new input[type='text'], #treasure-new input[type='hidden']")
			.each(function() {
				console.log("vars[treasure[" + $(this).attr('id') + "]] = " + $(this).attr('value'));
				vars['treasure[' + $(this).attr('id') + ']'] = $(this).attr('value');
			});
		
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