@FeralHog ?= {}

class FeralHog.ObservationModel extends StackMob.Model
    schemaName: 
        "observation"

class FeralHog.ObservationsCollection extends StackMob.Collection
    model: 
        FeralHog.ObservationModel
        
class FeralHog.PhotoModel extends StackMob.Model
    schemaName: 
        "photo"

class FeralHog.PhotossCollection extends StackMob.Collection
    model: 
        FeralHog.PhotoModel
        
class FeralHog.ActionModel extends StackMob.Model
    schemaName: 
        "action"

class FeralHog.ActionsCollection extends StackMob.Collection
    model: 
        FeralHog.ActionModel