extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var driving_0a
var noDrivingComponent
var chargeIconPress
var chargeIconDelayedPress
var nback_2plus_extra
var anyIconDelayedPress
var realnback_2plus_extra
var setShiftingInstr
var flankerInstr
var pressStartGame
var respondQuickAcc
var noDrivingComponentSetShift
var drivingComponentSetShift
var flankerInstr2
var flankerInstr3
var driving_0a_practice
var nBackDrivingComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	driving_0a_practice = """In this task, you will practice driving a racecar.
Press the D key to steer the car left.
Press the K key to steer the car right.
Press the DOWN ARROW key (↓) to reverse the car.
"""
	driving_0a = """In this task, you will be driving a racecar.
Press the D key to steer the car left.
Press the K key to steer the car right.
Press the Down Arrow key (↓) to reverse the car.
"""
	pressStartGame = """Press 'START GAME' when you are ready.
"""
	respondQuickAcc = """Try to respond as quickly and accurately as you can.
"""
	noDrivingComponent = """In this task, you will not drive. You will practice adding fuel to the racecar. 
At the top of your screen, you will have a series of symbols presented on the screen one at a time.
Here are a few symbols you may see:
"""
	nBackDrivingComponent = """You will also need to add fuel to the racecar.
At the top of your screen, you will have a series of symbols presented on the screen one at a time.
Here are a few symbols you may see:
"""
	chargeIconPress="""Press the F key or the J key when you see the 'Charge' symbol.
"""
	nback_2plus_extra = """ trials after seeing this 'Charge' symbol. 
"""
	chargeIconDelayedPress="""You will also need to add fuel to the car.
At the top of your screen, you will have a series of symbols presented on the screen one at a time.
Press the F key or the J key """
	realnback_2plus_extra = """ SYMBOLS BACK.
"""
	anyIconDelayedPress="""You will also need to add fuel to the car.
At the top of your screen, you will have a series of symbols presented on the screen one at a time.
Press the F key or the J key if the symbol on screen matches the symbol that was presented """
	noDrivingComponentSetShift = """In this task, you will not drive. You will practice adding fuel to the racecar. 
At the top of your screen, you will have a row of three symbols. The symbols have different characteristics. They may have different shapes, lines, color, or texture. Here are a few symbols you may see.
"""
	drivingComponentSetShift = """You will also need to add fuel to the racecar.
At the top of your screen, you will have a row of three symbols. The symbols have different characteristics. They may have different shapes, lines, color, or texture. Here are a few symbols you may see.
"""
	setShiftingInstr = """To add fuel to your car, you must choose the symbol that has more characteristics in common with the middle symbol.
Press the F key if the symbol on the LEFT has more characteristics in common with the middle symbol.
Press the J key if the symbol on the RIGHT has more characteristics in common with the middle symbol.
Here are some examples of correct answers.
"""
	flankerInstr = """In this task, you will not drive. You will practice adding fuel to the racecar. 
At the top of your screen, you will see an arrow.
Press the F key if the arrow points LEFT.
Press the J key if the arrow points RIGHT.
"""
	flankerInstr2 = """You will also need to add fuel to the racecar.
At the top of your screen, you will see a row of arrows.
"""
	flankerInstr3 = """Press the F key if the arrow in the middle points LEFT.
Press the J key if the arrow in the middle points RIGHT.
"""
	if global.task == "nback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a_practice + pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent
			$"RichTextLabel2".text = chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
			$"Sprite3".visible = true
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
		else:
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
	if global.task == "realnback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a_practice + pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent
			$"RichTextLabel2".text = chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
			$"Sprite3".visible = true
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
		else:
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
	if global.task == "setshift":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a_practice + pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponentSetShift
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = true
			$"Button".text = "NEXT."
		else:
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."
	if global.task == "flanker":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a_practice + pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = flankerInstr+respondQuickAcc+pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
		else:
			$"RichTextLabel".text = driving_0a
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "NEXT."


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#print("TASK5 "+str(global.taskIP))
	#print(global.taskIP)
	if $"Button".text == "START GAME":
		get_tree().change_scene("res://Main.tscn")
	elif $"Button".text == "NEXT.":
		if global.task == "nback":
			if global.levelSet[global.task] == "0b":
				$"RichTextLabel".text = respondQuickAcc+pressStartGame
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
			elif global.levelSet[global.task] == "1":
				$"RichTextLabel".text = nBackDrivingComponent
				$"RichTextLabel2".text = chargeIconPress+respondQuickAcc+pressStartGame
				$"Sprite".visible = true
				$"Sprite2".visible = false
				$"Sprite3".visible = true
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
			else:
				$"RichTextLabel".text = chargeIconDelayedPress + str(global.nBackIP) + nback_2plus_extra+respondQuickAcc+pressStartGame
				$"RichTextLabel2".text = ""
				$"Sprite".visible = true
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
		if global.task == "realnback":
			if global.levelSet[global.task] == "0b":
				$"RichTextLabel".text = respondQuickAcc+pressStartGame
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
			elif global.levelSet[global.task] == "1":
				$"RichTextLabel".text = nBackDrivingComponent
				$"RichTextLabel2".text = chargeIconPress+respondQuickAcc+pressStartGame
				$"Sprite".visible = true
				$"Sprite2".visible = false
				$"Sprite3".visible = true
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
			else:
				$"RichTextLabel".text = anyIconDelayedPress + str(global.nBackIP) + realnback_2plus_extra+respondQuickAcc+pressStartGame
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
		if global.task == "setshift":
			if global.levelSet[global.task] == "0b":
				$"RichTextLabel".text = setShiftingInstr
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = true
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "NEXT.."
			else:
				$"RichTextLabel".text = drivingComponentSetShift
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = true
				$"Button".text = "NEXT.."
		if global.task == "flanker":
			$"RichTextLabel".text = flankerInstr2
			$"RichTextLabel2".text = flankerInstr3+respondQuickAcc+pressStartGame
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Sprite5".visible = true
			$"Button".text = "START GAME"
	elif $"Button".text == "NEXT..":
		if global.task == "setshift":
			if global.levelSet[global.task] == "0b":
				$"RichTextLabel".text = respondQuickAcc+pressStartGame
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = false
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "START GAME"
			else:
				$"RichTextLabel".text = setShiftingInstr
				$"RichTextLabel2".text = ""
				$"Sprite".visible = false
				$"Sprite2".visible = true
				$"Sprite3".visible = false
				$"Sprite4".visible = false
				$"Button".text = "NEXT..."
	elif $"Button".text == "NEXT...":
		if global.task == "setshift":
			$"RichTextLabel".text = respondQuickAcc+pressStartGame
			$"RichTextLabel2".text = ""
			$"Sprite".visible = false
			$"Sprite2".visible = false
			$"Sprite3".visible = false
			$"Sprite4".visible = false
			$"Button".text = "START GAME"
