extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	global.maxSpeedIP = 10 * ($"../OptionButton".selected + 1)
	global.accelerationIP = $"../OptionButton2".selected + 1
	global.nBackIP = $"../OptionButton3".selected
	global.strtFuelIP = 30 * ($"../OptionButton4".selected + 1)
	global.bonusFuelIP = 10 * ($"../OptionButton5".selected + 1)
	global.nBackIntervalIP = $"../OptionButton6".selected + 1
	global.tLimit = 30 * ($"../OptionButton7".selected + 1)
	global.taskIP = $"../OptionButton8".selected
	global.setIntervalIP = $"../OptionButton9".selected + 2
	global.setNIP = 2 + 2*$"../OptionButton10".selected
	global.setNExtraIP = 4 + 4*$"../OptionButton11".selected
	global.penaltyIP = 5*$"../OptionButton12".selected
	global.nFlankIP = $"../OptionButton13".selected
	global.respLimitIP = 100 - (25*$"../OptionButton14".selected)
	global.centreShift = $"../OptionButton15".selected
	global.sizeIP = $"../OptionButton16".selected
	global.url = $"../OptionButton17".text
	global.endpt = $"../OptionButton18".text
	global.dict.thisSession.append(global.dict.duplicate(true).thisSession[0])
	global.dict.thisSession[global.dict.thisSession.size()-1].speed = global.maxSpeedIP
	global.dict.thisSession[global.dict.thisSession.size()-1].acc = global.accelerationIP
	global.dict.thisSession[global.dict.thisSession.size()-1].nback = global.nBackIP
	global.dict.thisSession[global.dict.thisSession.size()-1].respLimit = global.respLimitIP
	global.dict.thisSession[global.dict.thisSession.size()-1].startFuel = global.strtFuelIP
	global.dict.thisSession[global.dict.thisSession.size()-1].bonusFuel = global.bonusFuelIP
	global.dict.thisSession[global.dict.thisSession.size()-1].stimInterval = global.nBackIntervalIP
	global.dict.thisSession[global.dict.thisSession.size()-1].timeLimit = global.tLimit
	global.dict.thisSession[global.dict.thisSession.size()-1].task = global.taskIP
	global.dict.thisSession[global.dict.thisSession.size()-1].stimDuration = global.setIntervalIP
	global.dict.thisSession[global.dict.thisSession.size()-1].intraN = global.setNIP
	global.dict.thisSession[global.dict.thisSession.size()-1].extraN = global.setNExtraIP
	global.dict.thisSession[global.dict.thisSession.size()-1].penalty = global.penaltyIP
	global.dict.thisSession[global.dict.thisSession.size()-1].flankerN = global.nFlankIP
	global.dict.thisSession[global.dict.thisSession.size()-1].centreUp = global.centreShift
	global.dict.thisSession[global.dict.thisSession.size()-1].symComplexity = global.sizeIP
	get_tree().change_scene("res://Instr.tscn")
