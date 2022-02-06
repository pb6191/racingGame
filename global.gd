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

var poplnID
var partcnID
var sessID
var measrID

var measrTypeID
var startScrn
var changStartScrn = 0



# 0 to deploy on any server, 1 for a game on taskflow, 2 for settings on taskflow
var taskflowDeploy
var autoDifficulty
var racingGUID
var task
var rounds
var json_result
var threshold
var travelled
var reset
var current_round = 0

var dict = {"thisSession": [{"speed": "", "acc": "", "nback": "", "respLimit": "", "startFuel": "", "bonusFuel": "", "stimInterval": "", "timeLimit": "", "task": "", "stimDuration": "", "intraN": "", "extraN": "", "penalty": "", "flankerN": "", "centreUp": "", "symComplexity": "", "trials": [{"timeStamp": "", "totalTimeElapsed": "", "trialTimeElapsed": "", "event":"", "eventDesc": {"target":"", "leftMost":{"color": "", "shapeDesc": "", "size": ""}, "left":{"color": "", "shapeDesc": "", "size": ""}, "right":{"color": "", "shapeDesc": "", "size": ""}, "rightMost":{"color": "", "shapeDesc": "", "size": ""}, "centre":{"color": "", "shapeDesc": "", "size": "", "upShift": ""}}, "distFrmCentre": "", "distanceCovered": "", "fuelStatus": "", "timeDriven": "", "currentTrial": ""}]}]}
var dictSet = {"speed": "", "acc": "", "nback": "", "respLimit": "", "startFuel": "", "bonusFuel": "", "stimInterval": "", "timeLimit": "", "task": "", "stimDuration": "", "intraN": "", "extraN": "", "penalty": "", "flankerN": "", "centreUp": "", "symComplexity": "", "startScreen": ""}
var levelSet = {"GUID": "", "nback": "", "flanker": "", "setshift": ""}



# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://settings_file.json", file.READ)
	var json = file.get_as_text()
	json_result = JSON.parse(json).result
	file.close()
	taskflowDeploy = json_result["taskflowDeploy"]
	autoDifficulty = json_result["autoDifficulty"]
	racingGUID = json_result["racingGUID"]
	task = json_result["task"]
	rounds = json_result["rounds"]
	threshold = json_result["threshold"]
	reset = json_result["reset"]
	levelSet["GUID"] = racingGUID


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
