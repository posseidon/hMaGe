//= require ckeditor/init

var markersLayer;
var latitude = 0;
var longitude = 0;
var wkt = new OpenLayers.Format.WKT();

var size = new OpenLayers.Size(48, 48);
calculateOffset = function(size) {
            return new OpenLayers.Pixel(-(size.w/2), -size.h); };
var icon = new OpenLayers.Icon( '/pagoda-2.png', size, null, calculateOffset);

function getLatLng(address) {
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({ 'address': address }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var location = results[0].geometry.location;
      latitude  = location.lat();
      longitude = location.lng();
      zoomToCenter(latitude, longitude);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
  return 0;
}

function zoomToCenter(lat, lon){
  // Remove All the Markers
  markersLayer.clearMarkers();

  var point = new OpenLayers.Geometry.Point(lon, lat).transform(map.displayProjection, map.getProjectionObject());

  markersLayer.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(point.x, point.y), icon));

  map.setCenter(point.getBounds().getCenterLonLat());
  map.zoomTo(12);
}

function getWktFrom(lat, lon){
    var wkt_begin = "POINT(";
    var wkt_end   = ")";
    var wkt = wkt_begin + lat + ' ' + lon + wkt_end;
    console.log(wkt);
    return wkt;
}

function setNameWkt(){
  if(latitude != 0 && longitude != 0){
    var wkt = getWktFrom(latitude, longitude);
    $('#name_latlon').val(wkt);
  }
}

function setLocation(lat, lon){
  var point = new OpenLayers.Geometry.Point(lon, lat).transform(map.displayProjection, map.getProjectionObject());
  markersLayer.addMarker(new OpenLayers.Marker(new OpenLayers.LonLat(point.x, point.y), icon));
}


function setPointsData(){
  // Points are taken from names/index.html javascript section
  var wkt = "MULTIPOINT(" + points.join() + ")";
  $("#points_geometry").val(wkt);
}