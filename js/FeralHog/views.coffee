@FeralHog ?= {}

class FeralHog.ObservationInfoView extends Backbone.View
    initialize: ->
        ich.grabTemplates()
        @render()
 
    el: '#observationContainer'
      
    render:(model)->
        @$el.html(ich.observationInfo(@))
        @$el.show()
        
    destroy: () =>
        @unbind()
        @$el.hide()
        @$el.html("")
        
    id: ()-> @model.get('observation_id') or "N/A"
    county: ()-> @model.get('county') or "N/A"
    date: ()-> @formatDate(new Date(@model.get('date')))
    documented: ()-> @model.get('documented') or "N/A"
    observed_adult_count: ()-> @model.get('observed_adult_count') or "N/A"
    observed_piglet_count: ()-> @model.get('observed_piglet_count') or "N/A"
    ownership: ()-> @model.get('ownership') or "N/A"
    reporter_name: ()-> @model.get('reporter_name') or "N/A"
    reporter_phone: ()-> @model.get('reporter_phone') or "N/A"
    createddate: ()-> @formatDate(new Date(@model.get('createddate')))
    lastmoddate: ()-> @formatDate(new Date(@model.get('lastmoddate')))
    photos: ()-> @getPhotos()
    actions: ()-> @getActions()
    hasPhotos: ()-> if @model.get('photos')? then true else null
    hasActions: ()-> if @model.get('actions')? then true else null
    
    formatDate: (JSdate) =>
        if JSdate
            return "#{JSdate.getMonth()}/#{JSdate.getDate()}/#{JSdate.getFullYear()}"
        else
            return "N/A"

class FeralHog.ObservationActionsView extends Backbone.View
    initialize: ->
        ich.grabTemplates()
        @render()
 
    el: '#observationContainer'
      
    render:(model)->
        @$el.html(ich.observationActions(@))
        @$el.show()
        
    destroy: () =>
        @unbind()
        @$el.hide()
        @$el.html("")
    
    getActions: () =>
        return null if !@model.get('actions')
        actions = []
        for act, i in @model.get('actions')
            action = @setActionValues(FeralHog.actions.get(act))
            action.index = i
            action.displayIndex = i + 1
            action.isFirst = if i is 0 then true else null
            actions.push(action)
        return actions
        
    id: ()-> @model.get('observation_id') or "N/A"
    actions: ()-> @getActions()
    hasActions: ()-> if @model.get('actions')? then true else null
    
    formatDate: (JSdate) =>
        if JSdate
            return "#{JSdate.getMonth()}/#{JSdate.getDate()}/#{JSdate.getFullYear()}"
        else
            return "N/A"

    setActionValues: (action) =>
        action.actionDate = @formatDate(new Date(action.attributes.date))
        action.blood = ()-> action.attributes.blood_sample_count or "N/A"
        action.collarNo = ()-> action.attributes.collar_serial_number or "N/A"
        action.collarSex = ()-> action.attributes.collar_sex or "N/A"
        action.lastModDate = @formatDate(new Date(action.attributes.lastmoddate))
        action.adult = ()-> action.attributes.killed_adult_count or "N/A"
        action.female = ()-> action.attributes.killed_female_count or "N/A"
        action.male = ()-> action.attributes.killed_male_count or "N/A"
        action.piglet = ()-> action.attributes.killed_piglet_count or "N/A"
        action.comment = ()-> action.attributes.comment or "N/A"
        action.type = ()-> action.attributes.type or "N/A"
        action.createdDate = @formatDate(new Date(action.attributes.createddate))
        return action
        

class FeralHog.ObservationPhotosView extends Backbone.View
    initialize: ->
        ich.grabTemplates()
        @render()
 
    el: '#observationContainer'
    
    events:
        "click .imgA": "setActiveImg"
      
    render:(model)->
        $("#modalsContainer").html(ich.photoModals(@))
        @$el.html(ich.observationPhotos(@))
        @$el.show()
        
    destroy: () =>
        @unbind()
        @$el.hide()
        @$el.html("")
        
    setActiveImg:(e)->
        $("#modalPhotoCarousel div.item").removeClass "active"
        $("#modalPhotoCarousel div.item[data-photo-index='#{$(e.target).attr('data-photo-index')}']").addClass "active"
        
    getPhotoGroups: () =>
        return null if !@model.get('photos')
        photoGroups = []
        counter = 0
        for pht, i in @model.get('photos')
            isFirst = if i is 0 then true else null
            if i%2 is 0
                hasTwoItems = if (counter*2) + 2 < (@model.get('photos').length + 1) then true else false
                displayIndex = if hasTwoItems then "#{(counter*2) + 1} - #{(counter*2) + 2}" else "#{(counter*2) + 1}"
                photoGroups.push
                    index: counter
                    hasTwoItems: hasTwoItems
                    displayIndex: displayIndex
                    photos: []
                    isFirst: isFirst
                counter++
            photo = FeralHog.photos.get(pht)
            photo.photoIndex = i
            photo.isFirst = isFirst
            photoGroups[Math.floor(i/2)].photos.push(photo)
        return photoGroups
        
    id: ()-> @model.get('observation_id') or "N/A"
    photoGroups: ()-> @getPhotoGroups()
    hasPhotos: ()-> if @model.get('photos')? then true else null