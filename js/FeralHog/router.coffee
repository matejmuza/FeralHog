@FeralHog ?= {}

class FeralHog.Router extends Backbone.Router
    initialize:()->
        FeralHog.observations.defaultView = "info"
        @setObservationContainerClass()
        Backbone.history.start()
            

    routes:
        "": "clear"
        "observation/:id": "showObservation"
        "observation/:id/info": "showObservationInfo"
        "observation/:id/actions": "showObservationActions"
        "observation/:id/photos": "showObservationPhotos"
        
    clear: (id) ->
        @destroyModals()
        if FeralHog.obsView? and FeralHog.observations.selected?
            FeralHog.obsView.destroy()
            FeralHog.mapMarkers[FeralHog.observations.selected].setIcon 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'
            FeralHog.observations.selected = null
      
    showObservationInfo: (id) ->
        @showObservation(id, "ObservationInfoView", "info")
        
    showObservationActions: (id) ->
        @showObservation(id, "ObservationActionsView", "actions")
        
    showObservationPhotos: (id) ->
        @showObservation(id, "ObservationPhotosView", "photos")
        
    showObservation: (id, viewName, defaultView) ->
        @clear()
        FeralHog.observations.defaultView = defaultView
        FeralHog.obsView = new FeralHog[viewName] {model: FeralHog.observations.get(id)}
        FeralHog.mapMarkers[id].setIcon 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png'
        FeralHog.observations.selected = id
        
    destroyModals: ->
        $("#modalsContainer").html("")
        $(".modal-backdrop").remove()
        
    setObservationContainerClass: ->
        $("#observationContainer").addClass("smallWindow") if $(window).width() <= 1360
        window.onresize = (e)->
            if $(window).width() <= 1360
                $("#observationContainer").addClass("smallWindow")
            else
                $("#observationContainer").removeClass("smallWindow")
