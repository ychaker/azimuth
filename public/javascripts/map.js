function createMarker(point, barname) {
  var marker = new GMarker(point);
	GEvent.addListener(marker, "click", function() {
		// $("#accordion").accordion("activate",1);
		$("#lat").val(marker.getLatLng().lat());
		$("#lng").val(marker.getLatLng().lng());
	    var myHtml = "<b>" + barname + "</b><br/>" + deal;
	    map.openInfoWindowHtml(point, myHtml);
	  });
  return marker;
}

$(document).ready(function() {
	if (GBrowserIsCompatible()) {
	    map = new GMap2(document.getElementById("map"));
	    map.enableContinuousZoom();

	    map.setCenter(new GLatLng(38.90653,-77.035446), 11); // center on dc
	    map.addControl(new GLargeMapControl());

		GEvent.addListener(map, "click", function(overlay, latlng) {
			if (!$("#map").hasClass('hunt-chosen')) {
				alert("Please choose a Treasure Hunt first");
				return;
			}
			$("#accordion").accordion("activate",1);
			if (latlng) {
				$("#lat").val(latlng.lat()).effect("highlight",{duration: 1000});
				$("#lng").val(latlng.lng()).effect("highlight",{duration: 1000});
			}
		});
	}

	$("#go-geocode").click(function() {
		geocoder = new GClientGeocoder();
		geocoder.getLatLng($("#geocode").attr('value'), function(point) {
		    map.clearOverlays();
		    map.addOverlay(createMarker(point));
		    map.setCenter(point);
		    map.setZoom(15);

		    // bounds = map.getBounds();
		    // 
		    // $.getJSON('/bars/bounds/' + bounds.getSouthWest().lat() + "," + bounds.getSouthWest().lng() + "," + bounds.getNorthEast().lat() + "," + bounds.getNorthEast().lng() + '.json', function (data) {
		    //     jQuery.each(data, function(i, item) {
		    //         map.addOverlay(
		    //             new GMarker(new GPoint(parseFloat(this.lon), parseFloat(this.lat)), 
		    //             new GIcon(G_DEFAULT_ICON,'/static/images/icons/' + i + '.png'))
		    //         );
		    //     });
		    // });
		});		
	});

});

$(document).unload(GUnload());
