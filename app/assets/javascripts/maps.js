var map, vectorLayer;
var drawControls;
var polygon, box;
var edit, nav, remove;
var select;
var selectedFeature;
var viewMode = false;

function init() {
    // allow testing of specific renderers via "?renderer=Canvas", etc
    var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
    renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;


    OpenLayers.Feature.Vector.style['virtual'] = {
        fillColor: "#ee9900",
        fillOpacity: 0.4,
        strokeColor: "#ee9900",
        strokeOpacity: 1,
        strokeWidth: 1,
        pointRadius: 5
    }

    OpenLayers.Feature.Vector.style['default'] = {
        strokeColor: "#6999c5",
        strokeOpacity: 1,
        strokeWidth: 1,
        fillColor: "#6999c5",
        fillOpacity: 0.2,
        pointRadius: 6,
        pointerEvents: "visiblePainted",
        label : "Grid: ${grid}",
        fontColor: "${favColor}",
        fontSize: "18px",
        fontFamily: "Verdana",
        labelAlign: "${align}",
        labelXOffset: "${xOffset}",
        labelYOffset: "${yOffset}",
        labelOutlineColor: "green",
        labelOutlineWidth: 1
    }

    var styleMap = new OpenLayers.StyleMap({
       "default":OpenLayers.Feature.Vector.style['default'],
       "virtual": OpenLayers.Feature.Vector.style['virtual']
    }, {extendDefault: false});


    vectorLayer = new OpenLayers.Layer.Vector( "Editable Layer", {
                styleMap: styleMap,
                renderers: renderer,
                eventListeners: {
                    'featureadded': removeFirstFeature
                }
            });

    map = new OpenLayers.Map('map', {
        projection: 'EPSG:3857',
        displayProjection: new OpenLayers.Projection("EPSG:4326"),
        units: "m",
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
        center: new OpenLayers.LonLat(19.0531965145, 47.5011151657).transform('EPSG:4326', 'EPSG:3857'),
        zoom: 5
    });

    map.addLayers([vectorLayer]);
    map.addControl(new OpenLayers.Control.LayerSwitcher());

    addDrawControls(map, vectorLayer);

}

function addDrawControls(map, vectorLayer){
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
        edit: new OpenLayers.Control.ModifyFeature(vectorLayer, {vertexRenderIntent: "virtual"}),
        nav:  new OpenLayers.Control.Navigation(),
        select: new OpenLayers.Control.SelectFeature(vectorLayer, {
            clickout: true,
            onSelect: selectFeature
        })
    };
    for(var key in drawControls) {
        map.addControl(drawControls[key]);
    }
    updateFormats();
}


function selectFeature(feature){
    selectedFeature = feature;
    var str = formats['out']['wkt'].write(selectedFeature, false);
    console.log(selectedFeature.label);
}

function removeFeature(){
    vectorLayer.removeFeatures(selectedFeature);
    selectedFeature = null;
}

function toggleControl(action) {
    for(key in drawControls) {
        var control = drawControls[key];
        if(action == key) {
            control.activate();
            $("#"+action).attr("class","active");
        } else {
            control.deactivate();
            $("#"+key).removeClass("active");
        }
    }
}

function clickableGrid( rows, cols, callback ){
    var img = $('#image');
    var i=0;
    var grid = document.createElement('table');
    grid.id = 'grid';
    grid.className = 'table';
    for (var r=0;r<rows;++r){
        var tr = grid.appendChild(document.createElement('tr'));
        for (var c=0;c<cols;++c){
            var cell = tr.appendChild(document.createElement('td'));
            cell.width = img.width()/cols;
            cell.height = img.height()/rows;
            cell.innerHTML = "A" + (++i);
            cell.addEventListener('click',(function(el,r,c,i){
                return function(){
                    callback(el,r,c,i);
                }
            })(cell,r,c,i),false);
        }
    }
    return grid;
}


function updateFormats() {
    var in_options = {
        'internalProjection': map.baseLayer.projection,
        'externalProjection': new OpenLayers.Projection("EPSG:4326")
    };
    var out_options = {
        'internalProjection': map.baseLayer.projection,
        'externalProjection': new OpenLayers.Projection("EPSG:4326")
    };

    formats = {
      'in': {
        wkt: new OpenLayers.Format.WKT(in_options),
      },
      'out': {
        wkt: new OpenLayers.Format.WKT(out_options),
      }
    };
}

function removeFirstFeature(){
    if(vectorLayer.features.length > 1 && viewMode === false){
        vectorLayer.removeFeatures(vectorLayer.features[0]);
        vectorLayer.features[0].attributes = {
            grid: "Selected Area"
        };
        vectorLayer.redraw();
    }else{
        vectorLayer.features[0].attributes = {
            grid: "Selected Area"
        };
        vectorLayer.redraw();
    }
}

function setMapData(){
    var feature = vectorLayer.features[0];
    var wkt = formats['out']['wkt'].write(feature, false);
    $("#geometry").val(wkt);
}


function setMapDataXXXX(){
    var features = vectorLayer.features;
    var objects = [];
    for(idx in features){
      var feature = features[idx];
      feature.geometry.transform(new OpenLayers.Projection("EPSG:3857"), new OpenLayers.Projection("EPSG:4326"));
      var polygon = [];
      var points = feature.geometry.getVertices();
      for(var i in points){
        polygon.push(points[i].x.toFixed(8) + " " + points[i].y.toFixed(8));
      }
      objects.push("(" + polygon.join() + ")");
    }

    var wkt = "POLYGON(" + objects.join() + ")";
    console.log(wkt.toString());
    $("#geometry").val(wkt.toString());
}