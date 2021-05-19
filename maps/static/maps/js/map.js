var mapApp = angular.module("mapApp", ["ngCookies", "nvd3", "ui.multiselect"]);

mapApp.controller("MapController", function MapController($scope, $window, $document, $cookies, $http, $timeout) {

    var map;
    var incidentLayer;
    var incidentSource;
    var filter_options = {};
    var popup;
    $scope.selectedDisaster = "-1";
    $scope.selectedDistrict = "";
    $scope.selectedProvince = "";
    $scope.is_validated = "all";
    $scope.layerName;
    $scope.districts;
    $scope.provinces;
    $scope.baseLayer = 'OSM';
    var markerLayer;
    var markerSource;
    var iconFeatures = [];
    var baseLayers = [];

    // Layer download formats
    $scope.LAYER_DOWNLOAD_FROMATS = [
        { name: "JSON", code: "json" },
        { name: "KML", code: "kml" },
        { name: "GIF", code: "gif" },
        { name: "PNG", code: "png" },
        { name: "CSV", code: "csv" }
    ]

    /*var viewparams = {
    disaster_type: null,
    district: null,
    is_validated:$scope.is_validated,
    toString: function()
    {
          var view_params;
          if(this.disaster_type && this.disaster_type != -1)
          view_params = "disaster_type="+this.disaster_type;
          if(this.district && this.district != -1)
          view_params = view_params ? view_params+" AND "+ "district=""+this.district+""":
                        "district=""+this.district+""";
          if(this.is_validated != "all")
          {
          var validate_conditn = this.is_validated == 0 ? " is NULL" : " is not NULL ";
          view_params = view_params ? view_params+" AND "+ "validation_id "+ validate_conditn:
                        "validation_id "+validate_conditn;
          }
          if($window.start_date && $window.end_date)
          {
          view_params = view_params ? view_params+" AND "+ "reported_date between ""+$window.start_date+"""
          +" AND "+ ""+$window.end_date+""
          : "reported_date between ""+$window.start_date+"""
          +"AND ""+$window.end_date+""";
          }

          //console.log("view param ", this.is_validated);
          return view_params;

    }
    };*/

    // organizing parameters for filter options
    var viewparams = {
        disaster_type: null,
        district: null,
        province: null,
        is_validated: $scope.is_validated,
        toString: function() {
            var map_load_params = {};
            var layer_params = {};
            var export_params;
            if (this.disaster_type && this.disaster_type != -1) {
                map_load_params["disaster_type"] = this.disaster_type;
                export_params = "disaster_type=" + this.disaster_type;
            }
            if (this.district && this.district != "") {

                map_load_params["district__in"] = this.district;
                export_params = export_params ? export_params + " AND " + "district__in=" + this.district + "" :
                    "district__in=" + this.district;
            }
            if (this.province && this.province != "") {

                map_load_params["province__in"] = this.province;
                export_params = export_params ? export_params + " AND " + "province__in=" + this.province + "" :
                    "province__in=" + this.province;
            }
            if (this.is_validated != "all") {
                var validate_conditn = this.is_validated == 0 ? "false" : "true";
                map_load_params["is_validated"] = validate_conditn;
                var validate_conditn = this.is_validated == 0 ? " is NULL" : " is not NULL ";
                export_params = export_params ? export_params + " AND " + "validation_id " + validate_conditn :
                    "validation_id " + validate_conditn;
            }
            if ($window.start_date && $window.end_date) {
                map_load_params["reported_date__gte"] = moment($window.start_date).format("YYYY-MM-DD");
                map_load_params["reported_date__lte"] = moment($window.end_date).add(1, "days").format("YYYY-MM-DD");

                export_params = export_params ? export_params + " AND " + "reported_date between " + $window.start_date +
                    " AND " + "" + $window.end_date + "" :
                    "reported_date between " + $window.start_date +
                    "AND " + $window.end_date;
            }

            layer_params["map_load_params"] = map_load_params;
            layer_params["export_params"] = export_params;
            return layer_params;

        }
    };

    function createWMSLayer(map) {
        incidentLayer = new ol.layer.Tile({
            source: createWMSSource()
        })

    }

    function createWMSSource() {

        view_params = viewparams.toString();
        var wms_params;

        if (view_params)
            wms_params = { "LAYERS": "cfr:cfr_v9", "TILED": true, "CQL_FILTER": view_params };
        else
            wms_params = { "LAYERS": "cfr:cfr_v9", "TILED": true };

        //console.log("disaster_type: ", view_params);
        //"disaster_type=2 AND district="Colombo""
        incidentSource = new ol.source.TileWMS(({
            url: "http://localhost:8080/geoserver/wms",
            params: wms_params,
            serverType: "cfr"
        }))

        return incidentSource;
    }


    function urlEncode() {
        return jQuery.param(viewparams);
    }

    // initial page load
    $scope.init = function initMap() {

        baseLayers['Terrain'] = new ol.layer.Tile({
            source: new ol.source.Stamen({
                layer: 'terrain'
            }),
            name: 'Terrain'
        });

        baseLayers['OSM'] = new ol.layer.Tile({
            source: new ol.source.OSM()
        });

        baseLayers['Bing'] = new ol.layer.Tile({
            //visible: false,
            preload: Infinity,
            source: new ol.source.BingMaps({
                key: 'Ak-dzM4wZjSqTlzveKz5u0d4IQ4bRzVI309GxmkgSVr1ewS6iPSrOvOKhA-CJlm3',
                imagerySet: 'Road'
            })
        })

        map = new ol.Map({
            layers: [

            ],
            target: "map",
            view: new ol.View({
                center: ol.proj.transform([80.704870, 7.999818], "EPSG:4326", "EPSG:3857"),
                zoom: 7
            })
        });


        var element = document.getElementById("popup");

        // feature popup
        popup = new ol.Overlay({
            element: element,
            positioning: "bottom-center",
            stopEvent: false
        });


        popup = new ol.Overlay({
            element: element,
            positioning: "bottom-center",
            stopEvent: false
        });
        map.addOverlay(popup);

        map.on("click", function(evt) {
            getIncidentInfo(evt);
        })

        markerSource = new ol.source.Vector({
            //features: iconFeatures
        });

        markerLayer = new ol.layer.Vector({
            source: markerSource
        });


        map.addLayer(baseLayers['OSM']);
        //map.addLayer(baseLayers['Bing']);
        map.addLayer(baseLayers['Terrain']);
        map.addLayer(markerLayer);

        $scope.changeBaseLayer();

        getProvinces();
        getDistricts("");
        populateIncidents();

    }

    // Change Base Layer
    $scope.changeBaseLayer = function changeBaseLayer() {

        for (var key in baseLayers) {
            //if(key != $scope.baseLayer)
            baseLayers[key].setVisible(false);
        }
        baseLayers[$scope.baseLayer].setVisible(true);
    }

    // Populate incidents
    // function populateIncidents() {
    //     view_params = viewparams.toString();
    //     console.log("view_params  ", view_params);
    //     clearMarkerLayer();
    //     $http({
    //         method: "POST",
    //         url: "/maps/populate_incidents/",
    //         dataType: "json",
    //         contentType: "application/json; charset=utf-8",
    //         crossDomain: true,
    //         data: { "view_params": JSON.stringify(view_params["map_load_params"]) }
    //     }).success(function(data) {
    //         clearMarkerLayer();
    //         var markers_data = data;
    //         angular.forEach(markers_data, function(marker) {
               
    //             marker_info = {
    //                 "id": marker.id,
    //                 "name": marker.name,
    //                 "latitude": marker.latitude,
    //                 "longitude": marker.longitude,
    //                 "reported_date": marker.date,
    //                 "disaster_type": marker.disaster_type__english,
    //                 "disaster_code": marker.disaster_type__code,
    //                 "district": marker.district,
    //                 "is_validated": marker.is_validated
    //             };
    //             createMarkers(marker_info);
    //         })

    //         addMarkersToLayer(iconFeatures);
    //     });
    // }


    function createMarkers(marker_info) {
        if (marker_info.longitude && marker_info.latitude) {
            var disaster_icon = fetch_disaster_icon(marker_info.disaster_code, marker_info.reported_date, marker_info.is_validated);
            var iconFeature = new ol.Feature({
                geometry: new ol.geom.Point(ol.proj.transform([parseFloat(marker_info.longitude), parseFloat(marker_info.latitude)], "EPSG:4326", "EPSG:3857")),
                name: marker_info.name,
                disaster: marker_info.disaster_type,
                is_validated: marker_info.is_validated,
                district: marker_info.district,
                date: marker_info.reported_date
            });

            var iconStyle = new ol.style.Style({
                image: new ol.style.Icon(({
                    anchor: [0.26, 30],
                    anchorXUnits: "fraction",
                    anchorYUnits: "pixels",
                    opacity: 0.75,
                    src: "/static/maps/images/CFR_icons/" + disaster_icon + ""
                }))
            });

            iconFeature.setStyle(iconStyle);
            iconFeatures.push(iconFeature);
        }
    }

    // Adding markers to map
    function addMarkersToLayer(iconFeatures) {
        markerSource.addFeatures(iconFeatures);
    }

    // Changing icon based on disaster type
    function fetch_disaster_icon(disaster_type, date, verification_status) {
        var icon;
        var todate = moment().startOf("day");
        var seven_days_ago = moment().subtract(7, "d").startOf("day");
        var reported_date = moment(date).startOf("day");
        date_diff_todate = todate.diff(reported_date, "days", true);


        /*if(date_diff_todate == 0){
    icon = disaster_type+"1.png";
  }
  else if(date_diff_todate == 1){
    icon = disaster_type+"2.png";
  }
  else if(date_diff_todate == 2){
    icon = disaster_type+"3.png";
  }
 
  else if(date_diff_todate >= 3 && date_diff_todate <= 6){
    icon = disaster_type+"4.png";
    }
  else{
    icon = disaster_type+"5.png";
    }*/

        if (date_diff_todate == 0) {
            if (verification_status)
                icon = disaster_type + "g1.png";
            else
                icon = disaster_type + "1.png";
        } else if (date_diff_todate == 1) {
            if (verification_status)
                icon = disaster_type + "g2.png";
            else
                icon = disaster_type + "2.png";
        } else if (date_diff_todate == 2) {
            if (verification_status)
                icon = disaster_type + "g3.png";
            else
                icon = disaster_type + "3.png";
        }
        /*else if(date_diff_todate == 3){
          icon = disaster_type+"4.png";
        }*/
        else if (date_diff_todate >= 3 && date_diff_todate <= 6) {
            if (verification_status) {

                icon = disaster_type + "g4.png";

            } else
                icon = disaster_type + "4.png";
        } else {
            if (verification_status) {
                icon = disaster_type + "g5.png";

            } else
                icon = disaster_type + "5.png";
        }

        return icon;
    }

    // Clear markers
    function clearMarkerLayer() {
        iconFeatures = [];
        if (markerSource) {
            markerSource.clear();
        }
    }

    // Marker filtering
    $scope.layerFilter = function layerFilter() {

        populateIncidents();

    }

    // Retrieve incident info
    // function getIncidentInfo(evt) {

    //     var feature = map.forEachFeatureAtPixel(evt.pixel,
    //         function(feature, markerLayer) {
    //             return feature;
    //         });

    //     if (feature) {

    //         var element = popup.getElement();
    //         validation_status = feature.get("is_validated") ? "Validated" : "Not validated"
    //         var incident_content = "<div>Name: " + feature.get("name") +
    //             "<br>Id: " + feature.get("id") +
    //             "<br>Disaster Type: " + feature.get("disaster") +
    //             "<br>Reported Date: " + feature.get("date") +
    //             "<br>Validation status: " + validation_status +
    //             "<br>District: " + feature.get("district") +
    //             "</div>";
    //         console.log(incident_content);

    //         popup.setPosition(evt.coordinate);
    //         $(element).attr("data-placement", "top");
    //         $(element).attr("data-html", true);
    //         $(element).attr("data-content", incident_content)

    //         $(element).popover("show");
    //     } else {
    //         $(element).popover("destroy");
    //         popup.setPosition(undefined);
    //     }
    // }

    $scope.getFilterData = function getFilterData(selectedValue, filter_type) {
        if (filter_type == "disaster")
            viewparams.disaster_type = selectedValue;
        if (filter_type == "province") {
            var selectedItems = [];
            angular.forEach(selectedValue, function(val) {
                selectedItems.push(val.name.toString());
            });
            viewparams.province = selectedItems;
            getDistricts(viewparams.province);
            viewparams.district = "";
            $scope.selectedDistrict = "";
        } else if (filter_type == "district") {

            var selectedItems = [];
            angular.forEach(selectedValue, function(val) {
                selectedItems.push(val.name.toString());
            });
            viewparams.district = selectedItems;
            console.log(viewparams.district);
        } else if (filter_type == "validation")
            viewparams.is_validated = selectedValue;

    }

    function getDistricts(province_list) {
        var province_name = { 'province': province_list };


        //province_name = $scope.selectedProvinc[0].name;
        $http({
            method: "POST",
            url: "/maps/fetch_districts/",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            crossDomain: true,
            data: { 'province_name': JSON.stringify(province_name) }
        }).success(function(data) {
            console.log('districts ', data);
            $scope.districts = data;

            //$scope.districts = [{'name': 'Colombo'}];
        });
    }

    function getProvinces() {
        $http({
            method: "POST",
            url: "/maps/fetch_provinces/",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            crossDomain: true,
            data: {}
        }).success(function(data) {
            console.log('provinces ', data);
            $scope.provinces = data;
        });
    }

    var GEOSERVER_URL = "http://166.63.122.161:8080/geoserver";
    var STORE = "cfr";
    var LAYER_NAME = "incident_layer";
    var WORKSPACE = "cfr";

    // Layer download url
    $scope.fetch_url = function fetch_url(format) {
        var url;
        var view_params = viewparams.toString();
        var export_params = view_params["export_params"];
        export_params = export_params ? "&CQL_FILTER=" + export_params : "";
        console.log(export_params);
        if (format == "gif")
            url = GEOSERVER_URL + "/" + WORKSPACE + "/wms?service=WMS&version=1.1.0&request=GetMap&layers=" + STORE + ":" + LAYER_NAME + "&styles=&bbox=79.83528,6.035,800.0,9.66667&width=768&height=330&srs=EPSG:4326&format=image%2Fgif";
        else if (format == "kml")
            url = GEOSERVER_URL + "/" + WORKSPACE + "/wms/kml?layers=" + STORE + ":" + LAYER_NAME + "";
        else if (format == "json")
            url = GEOSERVER_URL + "/" + WORKSPACE + "/wms?service=WFS&version=1.0.0&request=GetFeature&typeName=" + STORE + ":" + LAYER_NAME + "&maxFeatures=50&outputFormat=application%2Fjson";
        else if (format == "csv")
            url = GEOSERVER_URL + "/" + WORKSPACE + "/wms?typename=" + STORE + ":" + LAYER_NAME + "&outputFormat=csv&version=1.0.0&request=GetFeature&service=WFS";
        else if (format == "png")
            url = GEOSERVER_URL + "/" + WORKSPACE + "/wms?service=WMS&version=1.1.0&request=GetMap&layers=" + STORE + ":" + LAYER_NAME + "&styles=&bbox=79.83528,6.035,800.0,9.66667&width=768&height=330&srs=EPSG:4326&format=image%2Fpng";
        return url;
    }

    $scope.json_downld = function json_downld() {
        var url = "http://166.63.122.161:8080/geoserver/cfr/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=cfr:incident_layer&maxFeatures=50&outputFormat=application%2Fjson";

        $http({
            method: "POST",
            url: url,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            crossDomain: true,
            data: {}
        }).success(function(data) {

            console.log('data ', data);
            var a = window.document.createElement('a');
            a.id = "json_dwd";
            var data = "data:application/json;charset:UTF-8" + encodeURIComponent(JSON.stringify(data));
            a.download = 'data.json';
            //window.open( "dataType: text/json, charset: UTF-8, ",data);
            $('#json_dwd').attr('href', data);

            document.body.appendChild(a);
            a.click();
        });

        return false;

    };


    $scope.$on("someEvent", function(event, data) { console.log(data); });


});

mapApp.controller("DashboardController", function DashboardController($scope, $http, $window, $cookies, $rootScope) {

    $scope.total_incidents;
    $scope.non_confirmed;
    $scope.confirmed;
    $scope.new_incidents;
    $scope.province_inc;

    var map;
    var incidentLayer;
    var incidentSource;
    var filter_options = {};
    var markerSource;
    var markerSource;
    var iconFeatures = [];
    var popup;

    // Get summary of incidents reported
    $http({
        method: "POST",
        url: "/dashboard/get_summary/",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        data: {}
    }).success(function(data) {

        $scope.total_incidents = data["total_incidents"];
        $scope.non_confirmed = data["non_confirmed_count"];
        $scope.confirmed = data["confirmed_inc_count"];
        $scope.new_incidents = data['new_incidents'];
        $scope.province_inc = JSON.parse(data["province_data"]);
        $scope.chart_data = JSON.parse(data["chart_data"]);
        setChartData($scope.chart_data);
        console.log($scope.chart_data);
    });

    // Initial page load
    $scope.init = function init() {
        map = new ol.Map({
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                })
            ],
            target: "map",
            view: new ol.View({
                center: ol.proj.transform([80.704870, 7.999818], "EPSG:4326", "EPSG:3857"),
                zoom: 7
            })
        });

        markerSource = new ol.source.Vector({
            //features: iconFeatures
        });

        markerLayer = new ol.layer.Vector({
            source: markerSource
        });

        map.addLayer(markerLayer);
        populateIncidents();

        var element = document.getElementById("popup");

        popup = new ol.Overlay({
            element: element,
            positioning: "bottom-center",
            stopEvent: false
        });


        // Add popup to map
        popup = new ol.Overlay({
            element: element,
            positioning: "bottom-center",
            stopEvent: false
        });
        map.addOverlay(popup);

        map.on("click", function(evt) {
            getIncidentInfo(evt);

        })

        //createWMSLayer(map);
        //map.addLayer(incidentLayer);
    }

    // Get incident info on map click
    function getIncidentInfo(evt) {

        // console.log(evt.pixels);

        var feature = map.forEachFeatureAtPixel(evt.pixel,
            function(feature, markerLayer) {
                return feature;
            });

        if (feature) {

            var element = popup.getElement();
            validation_status = feature.get("is_validated") ? "Validated" : "Not validated"

            var photo_link = '/incidents/image_link/'+feature.get("id");

            var getImage = $.ajax({
                  url:photo_link,
                  dataType: "text",
                  success: console.log("data successfully loaded."),
                  error: function (xhr) {
                    alert(xhr.statusText)
                  }
                });

            $.when(getImage).done(function() {

                var incident_content = "<div>" +
                "<br>Id: " + feature.get("id") +
                "<br>Name: " + feature.get("name") +
                "<br>Disaster Type: " + feature.get("disaster") +
                "<br>Reported Date: " + feature.get("date") +
                "<br>Validation status: " + validation_status +
                "<br>District: " + feature.get("district") +
                "<br>Image: <br><img src='"+getImage.responseText+"' height='50%' width='60%'>"
                "</div>";
            // console.log(incident_content);

            popup.setPosition(evt.coordinate);
            $(element).attr("data-placement", "top");
            $(element).attr("data-html", true);
            $(element).attr("data-content", incident_content)

            $(element).popover("show");

            });

            


        } else {
            $(element).popover("destroy");
            popup.setPosition(undefined);
        }
    }

    // Populating incidents
    function populateIncidents() {
        $http({
            method: "POST",
            url: "/maps/populate_incidents/",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            crossDomain: true,
            data: { "view_params": JSON.stringify() }
        }).success(function(data) {
            var markers_data = data;
            
            angular.forEach(markers_data, function(marker) {
                marker_info = {
                    "id": marker.id,
                    "name": marker.name,
                    "latitude": marker.latitude,
                    "district": marker.district,
                    "longitude": marker.longitude,
                    "reported_date": marker.date,
                    "disaster_type": marker.disaster_type__english,
                    "disaster_code": marker.disaster_type__code,
                    "district": marker.district,
                    "is_validated": marker.is_validated,
                };

                createMarkers(marker_info);
            })

            addMarkersToLayer(iconFeatures);
        });
    }

    // Creating markers
    function createMarkers(marker_info) {
        if (marker_info.longitude && marker_info.latitude) {

            var disaster_icon = fetch_disaster_icon(marker_info.disaster_code, marker_info.reported_date, marker_info.is_validated);
            var iconFeature = new ol.Feature({
                geometry: new ol.geom.Point(ol.proj.transform([parseFloat(marker_info.longitude), parseFloat(marker_info.latitude)], "EPSG:4326", "EPSG:3857")),
                id: marker_info.id,
                name: marker_info.name,
                disaster: marker_info.disaster_type,
                is_validated: marker_info.is_validated,
                district: marker_info.district,
                date: marker_info.reported_date
            });

            var iconStyle = new ol.style.Style({
                image: new ol.style.Icon(({
                    anchor: [0.26, 30],
                    anchorXUnits: "fraction",
                    anchorYUnits: "pixels",
                    opacity: 0.75,
                    src: "/static/maps/images/CFR_icons/" + disaster_icon + ""
                }))
            });

            iconFeature.setStyle(iconStyle);
            iconFeatures.push(iconFeature);
        }
    }

    function addMarkersToLayer(iconFeatures) {
        markerSource.addFeatures(iconFeatures);
    }

    // Changing disaster icons based on disaster type
    function fetch_disaster_icon(disaster_type, date, verification_status) {
        var icon;
        var todate = moment().startOf("day");
        var seven_days_ago = moment().subtract(7, "d").startOf("day");
        var reported_date = moment(date).startOf("day");
        date_diff_todate = todate.diff(reported_date, "days", true);


        /*if(date_diff_todate == 0){
          icon = disaster_type+"1.png";
          }
        else if(date_diff_todate >= 1 && date_diff_todate <= 6){
          icon = disaster_type+"3.png";
          }
        else{
          icon = disaster_type+"5.png";
          }*/

        if (date_diff_todate == 0) {
            if (verification_status)
                icon = disaster_type + "g1.png";
            else
                icon = disaster_type + "1.png";
        } else if (date_diff_todate == 1) {
            if (verification_status)
                icon = disaster_type + "g2.png";
            else
                icon = disaster_type + "2.png";
        } else if (date_diff_todate == 2) {
            if (verification_status)
                icon = disaster_type + "g3.png";
            else
                icon = disaster_type + "3.png";
        }
        /*else if(date_diff_todate == 3){
          icon = disaster_type+"4.png";
        }*/
        else if (date_diff_todate >= 3 && date_diff_todate <= 6) {
            if (verification_status) {

                icon = disaster_type + "g4.png";

            } else
                icon = disaster_type + "4.png";
        } else {
            if (verification_status) {
                icon = disaster_type + "g5.png";

            } else
                icon = disaster_type + "5.png";
        }
        return icon;
    }


    function createWMSLayer(map) {
        incidentLayer = new ol.layer.Tile({
            source: createWMSSource()
        })

    }

    function createWMSSource() {

        incidentSource = new ol.source.TileWMS(({
            url: "http://localhost:8080/geoserver/wms",
            params: { "LAYERS": "cfr:cfr_v9", "TILED": true },
            serverType: "cfr"
        }))

        return incidentSource;
    }

    // Chart options for total incidents
    $scope.options = {
        chart: {
            type: "pieChart",
            width: 400,
            height: 400,
            margin: {
                top: 50,
                right: 20,
                bottom: 40,
                left: 0
            },
            x: function(d) { return d.disaster_type__english; },
            y: function(d) { return d.count; },
            showLabels: true,
            transitionDuration: 500,
            useInteractiveGuideline: true,
            refreshDataOnly: true,
            deepWatchData: true,
            labelThreshold: 0.01,
            title: {
                enable: true,
                text: "Chart Title"
            },
            legend: {
                margin: {
                    top: 10,
                    right: 35,
                    bottom: 5,
                    left: 0
                }
            },

        }
    };

    // Refresh data
    function setChartData(data) {
        $scope.data = data;

        $scope.api.updateWithData($scope.data);
        $scope.api.refresh();
    }

})


mapApp.controller("ChartController", function ChartController($scope, $http, $window, $cookies) {

    $scope.selectedDistrict = "Colombo";

    // draw chart
    $scope.draw_chart = function draw_chart() {

        $http({
            method: "POST",
            url: "/dashboard/get_summary/",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            headers: {
                "X-CSRFToken": $cookies["csrftoken"]
            },
            data: {}
        }).success(function(data) {
            console.log(data);
            setChartData(data);

        });
    }

    $scope.draw_chart();
    $scope.options = {
        chart: {
            type: "pieChart",
            width: 400,
            height: 400,
            margin: {
                top: 20,
                right: 20,
                bottom: 40,
                left: 0
            },
            x: function(d) { return d.disaster_type; },
            y: function(d) { return d.count; },
            showLabels: true,
            transitionDuration: 500,
            useInteractiveGuideline: true,
            refreshDataOnly: true,
            deepWatchData: true,
            labelThreshold: 0.01,
            title: {
                enable: true,
                text: "Chart Title"
            },
            legend: {
                margin: {
                    top: 10,
                    right: 35,
                    bottom: 5,
                    left: 0
                }
            },

        }
    };

    function setChartData(data) {

        $scope.data = data;

        $scope.api.updateWithData($scope.data_district_pie);
        $scope.api.refresh();


    }

})