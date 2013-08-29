@FeralHog ?= {}

class FeralHog.FhStackMob
    constructor: ->
        StackMob.init
            publicKey: "f81efb10-659a-471c-9d80-09dccdac468a"
            apiVersion: 0
        user = new StackMob.User {username: "viewer@example.com", password: "pass"}
        user.login true,
            success: =>
                @fetchPhotos()
            error: =>
                alert "Accessing StackMob failed."
                
    fetchPhotos:() =>
        FeralHog.photos = new FeralHog.PhotossCollection()
        FeralHog.photos.fetch
            success: =>
                @fetchActions()
            error: =>
                console.log "fetching photos failed"
                
    fetchActions:() =>
        FeralHog.actions = new FeralHog.ActionsCollection()
        FeralHog.actions.fetch
            success: =>
                @fetchObservations()
            error: =>
                console.log "fetching actions failed"
                
    fetchObservations:() =>
        FeralHog.observations = new FeralHog.ObservationsCollection()
        FeralHog.observations.fetch
            success: =>
                FeralHog.observations.selected = null
                FeralHog.map = new FeralHog.Map()
                FeralHog.router = new FeralHog.Router()
            error: =>
                console.log "fetching observations failed"

@feralHogStackMob = new @FeralHog.FhStackMob()