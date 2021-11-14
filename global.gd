extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var maxSpeedIP
var accelerationIP
var nBackIP
var strtFuelIP
var bonusFuelIP
var nBackIntervalIP
var tLimit
var taskIP
var setIntervalIP
var setNIP
var setNExtraIP
var penaltyIP
var nFlankIP
var respLimitIP
var centreShift
var sizeIP
var url
var endpt

var dict = {"thisSession": [{"speed": "", "acc": "", "nback": "", "respLimit": "", "startFuel": "", "bonusFuel": "", "stimInterval": "", "timeLimit": "", "task": "", "stimDuration": "", "intraN": "", "extraN": "", "penalty": "", "flankerN": "", "centreUp": "", "symComplexity": "", "trials": [{"timeStamp": "", "totalTimeElapsed": "", "trialTimeElapsed": "", "event":"", "eventDesc": {"target":"", "leftMost":{"color": "", "shapeDesc": "", "size": ""}, "left":{"color": "", "shapeDesc": "", "size": ""}, "right":{"color": "", "shapeDesc": "", "size": ""}, "rightMost":{"color": "", "shapeDesc": "", "size": ""}, "centre":{"color": "", "shapeDesc": "", "size": "", "upShift": ""}}, "distFrmCentre": "", "distanceCovered": "", "fuelStatus": "", "timeDriven": "", "currentTrial": ""}]}]}




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
