@FeralHog ?= {}

class FeralHog.FhStackMob
    constructor: ->
        appUrl = window.location.href
        devVersion = appUrl.search("dev")
        appKey = if devVersion isnt -1 then "08cc0daa-0da5-48a5-a526-74a5f4624eb7" else "f81efb10-659a-471c-9d80-09dccdac468a"
        appVersion = if devVersion isnt -1 then 0 else 1
        StackMob.init
            publicKey: appKey
            apiVersion: appVersion
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