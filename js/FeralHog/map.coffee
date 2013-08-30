@FeralHog ?= {}

class FeralHog.Map
    constructor: ->
        mapOptions =
            center: new google.maps.LatLng(38.5,-92.5)
            zoom: 7
            mapTypeId: google.maps.MapTypeId.TERRAIN
            zoomControlOptions:
                position: google.maps.ControlPosition.RIGHT_TOP
            panControlOptions:
                position: google.maps.ControlPosition.RIGHT_TOP
        @map = new google.maps.Map document.getElementById("map"), mapOptions
        bounds = new google.maps.LatLngBounds()
        FeralHog.mapMarkers = []
        markersArray = []
        if FeralHog.observations.models.length > 0
            for obs, i in FeralHog.observations.models
                latlng = new google.maps.LatLng obs.attributes.location.lat, obs.attributes.location.lon
                bounds.extend latlng
                id = obs.id
                FeralHog.mapMarkers[id] = new google.maps.Marker
                    position: latlng
                    map: @map
                google.maps.event.addListener FeralHog.mapMarkers[id], "click", @toggleObservation(id)
                markersArray.push(FeralHog.mapMarkers[id])
            @map.fitBounds bounds
            clustererOptions = {maxZoom: 15}
            clusterer = new MarkerClusterer @map, markersArray, clustererOptions
            google.maps.event.addListener @map, "click", ()=> FeralHog.router.navigate "", {trigger: true}
        
    toggleObservation: (id, marker) =>
        ()-> 
            if FeralHog.observations.selected is null or FeralHog.observations.selected isnt id
                FeralHog.router.navigate "observation/#{id}/#{FeralHog.observations.defaultView}", {trigger: true}
            else
                FeralHog.router.navigate "", {trigger: true}