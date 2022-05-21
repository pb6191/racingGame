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

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.keepTouchButtons == 1:
		driving_0a = """To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

"""
	else:
		driving_0a = """To drive the car:
Car left: 'D' key
Car right: 'K' key
Car back: DOWN ARROW key

"""
	noDrivingComponent = """Please note that the upcoming level does not have any driving/car component.

"""
	if global.keepTouchButtons == 1:
		chargeIconPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen on seeing this charge icon: 
"""
	else:
		chargeIconPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key on seeing this charge icon: 
"""
	nback_2plus_extra = """ trials after seeing this charge icon: 
"""
	if global.keepTouchButtons == 1:
		chargeIconDelayedPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen """
	else:
		chargeIconDelayedPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key """
	realnback_2plus_extra = """ icons back
"""
	if global.keepTouchButtons == 1:
		anyIconDelayedPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen if the icon matches the icon """
	else:
		anyIconDelayedPress="""
To get the fuel, look at the heads-up display and:
Press F-key / J-key if the icon matches the icon """
	if global.keepTouchButtons == 1:
		setShiftingInstr = """
To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at the bottom of the screen if symbol of the left has more dimensions in common with the symbol in the centre.
Press J-key / right 'N-button' at the bottom of the screen if symbol of the right has more dimensions in common with the symbol in the centre.

Correct answers for some such scenarios are underlined below:
"""
	else:
		setShiftingInstr = """
To get the fuel, look at the heads-up display and:
Press F-key if symbol of the left has more dimensions in common with the symbol in the centre.
Press J-key if symbol of the right has more dimensions in common with the symbol in the centre.

Correct answers for some such scenarios are underlined below:
"""
	if global.keepTouchButtons == 1:
		flankerInstr = """
To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at bottom if central arrow points left
Press J-key / right 'N-button' at bottom if central arrow points right
"""
	else:
		flankerInstr = """
To get the fuel, look at the heads-up display and:
Press F-key if central arrow points left
Press J-key if central arrow points right
"""
	if global.task == "nback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent+chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = driving_0a+chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = driving_0a + chargeIconDelayedPress + str(global.nBackIP) + nback_2plus_extra
			$"Sprite".visible = true
			$"Sprite2".visible = false
	if global.task == "realnback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent+chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = driving_0a+chargeIconPress
			$"Sprite".visible = true
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = driving_0a+anyIconDelayedPress + str(global.nBackIP) + realnback_2plus_extra
			$"Sprite".visible = false
			$"Sprite2".visible = false
	if global.task == "setshift":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent+setShiftingInstr
			$"Sprite".visible = false
			$"Sprite2".visible = true
		else:
			$"RichTextLabel".text = driving_0a+setShiftingInstr
			$"Sprite".visible = false
			$"Sprite2".visible = true
	if global.task == "flanker":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = driving_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = noDrivingComponent+flankerInstr
			$"Sprite".visible = false
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = driving_0a+flankerInstr
			$"Sprite".visible = false
			$"Sprite2".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#print("TASK5 "+str(global.taskIP))
	#print(global.taskIP)
	get_tree().change_scene("res://Main.tscn")
