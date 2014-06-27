var map, vectorLayer;
var drawControls;
var polygon, box;
var edit, nav, select;

function init() {
    vectorLayer = new OpenLayers.Layer.Vector( "Editable Layer" );


    modifier = new OpenLayers.Control.ModifyFeature(vectorLayer);


    map = new OpenLayers.Map('map', {
        projection: 'EPSG:3857',
        layers: [
            new OpenLayers.Layer.Google(
                "Google Physical",
                {type: google.maps.MapTypeId.TERRAIN}
            ),
            new OpenLayers.Layer.Google(
                "Google Streets", // the default
                {numZoomLevels: 20}
            ),
            new OpenLayers.Layer.Google(
                "Google Hybrid",
                {type: google.maps.MapTypeId.HYBRID, numZoomLevels: 20}
            ),
            new OpenLayers.Layer.Google(
                "Google Satellite",
                {type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22}
            ),
        ],
        center: new OpenLayers.LonLat(10.2, 48.9)
            // Google.v3 uses web mercator as projection, so we have to
            // transform our coordinates
            .transform('EPSG:4326', 'EPSG:3857'),
        zoom: 5
    });

    drawControls = {
        polygon: new OpenLayers.Control.DrawFeature(vectorLayer,
            OpenLayers.Handler.Polygon),
        box: new OpenLayers.Control.DrawFeature(vectorLayer,
            OpenLayers.Handler.RegularPolygon, {
                handlerOptions: {
                    sides: 4,
                    irregular: true
                }
            }
        ),
        edit: new OpenLayers.Control.ModifyFeature(vectorLayer),
        nav:  new OpenLayers.Control.Navigation(),
        select: new OpenLayers.Control.SelectFeature(vectorLayer, {clickout: true})
    };
    for(var key in drawControls) {
        map.addControl(drawControls[key]);
    }


    map.addLayers([vectorLayer]);
    map.addControl(new OpenLayers.Control.LayerSwitcher());
}

function toggleControl(element) {
    for(key in drawControls) {
        var control = drawControls[key];
        if(element.value == key) {
            control.activate();
        } else {
            control.deactivate();
        }
    }
}
