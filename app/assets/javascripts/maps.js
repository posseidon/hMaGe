var map, vectorLayer;
var drawControls;
var polygon, box;
var edit, nav, remove;
var select;
var selectedFeature;

function init() {
    // allow testing of specific renderers via "?renderer=Canvas", etc
    var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
    renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;

    vectorLayer = new OpenLayers.Layer.Vector( "Editable Layer", {
                styleMap: new OpenLayers.StyleMap({'default':{
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
                    labelOutlineColor: "white",
                    labelOutlineWidth: 1
                }}),
                renderers: renderer
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
        center: new OpenLayers.LonLat(10.2, 48.9)
            // Google.v3 uses web mercator as projection, so we have to
            // transform our coordinates
            .transform('EPSG:4326', 'EPSG:3857'),
        zoom: 5
    });

    map.addLayers([vectorLayer]);
    map.addControl(new OpenLayers.Control.LayerSwitcher());

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
        select: new OpenLayers.Control.SelectFeature(vectorLayer, {
            clickout: true,
            onSelect: selectFeature
        })
    };
    for(var key in drawControls) {
        map.addControl(drawControls[key]);
    }
}

function selectFeature(feature){
    selectedFeature = feature
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


$(document).ready(function(){
    //$("#gallery").justifiedGallery({
    //  rowHeight: 240
    //});

    // delegate calls to data-toggle="lightbox"
    $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
      event.preventDefault();
      return $(this).ekkoLightbox({
        always_show_close: true
      });
    });

    var lastClicked;
    var grid = clickableGrid(2,2,function(el,row,col,i){
        console.log("You clicked on element:",el);
        console.log("You clicked on row:",row);
        console.log("You clicked on col:",col);
        console.log("You clicked on item #:",i);

        el.className='clicked';
        if (lastClicked) lastClicked.className='';
        lastClicked = el;
    });

    $('#grid-source').append(grid);
    $('form').submit(false);

    $("#gridNameForm").submit(function(event){
        console.log("alma");
        var gridName = $("#gridNameTxt").val();
        console.log(gridName);
        selectedFeature.attributes = {grid: gridName};
        vectorLayer.redraw();
    });
});