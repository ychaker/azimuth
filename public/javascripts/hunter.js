$(function() {
	$(document).ready(function() {
		// $("#accordion").accordion({ 
		// 	header: "div.heading",
		// 	clearStyle: true
		// });
		
		$("#discovery input[type='submit']").click(function() {
			$("#progress").text("checking...");
			
			vars = {
				password: $("#password").attr('value')
			};
			
			console.log(vars['password']);
			
			$.ajax({ 
				url: '/hunters/check_clue', 
				data: vars, 
				complete: function(data, textStatus) {
				}
			});
			
			return false;
		});	
	});
});