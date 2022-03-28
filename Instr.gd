extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prev_instr = """
Car left: 'D' key or '<-button' at bottom of GUI
Car right: 'K' key or '->button' at bottom of GUI
Car back: DOWN ARROW key

GET FUEL:

-nBack: -press F-key / J-key / any 'N-button' at bottom of GUI on charge icon stim

-setShift: -press F-key / left 'N-button' at bottom on color/shape match between left & centre stims AND -press J-key / right 'N-button' at bottom on color/shape match between right & centre stims

-flanker: -press F-key / left 'N-button' at bottom if central arrow points left AND -press J-key / right 'N-button' at bottom if central arrow points right
"""

var nback_0a = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key
"""

var nback_0b = """
To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen on seeing this charge icon: 
"""

var nback_1 = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen on seeing this charge icon:
"""

var nback_2plus = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen """

var nback_2plus_extra = """ trials after seeing this charge icon: 
"""

var realnback_0a = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key
"""

var realnback_0b = """
To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen on seeing this charge icon: 
"""

var realnback_1 = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen on seeing this charge icon: 
"""

var realnback_2plus = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / J-key / any 'N-button' at the bottom of the screen if the icon on the screen is same as the icon """

var realnback_2plus_extra = """ icons back
"""

var setshifting_0a = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key
"""

var setshifting_0b = """
To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at the bottom of the screen if symbol of the left has more dimensions in common with the symbol in the centre.

Press J-key / right 'N-button' at the bottom of the screen if symbol of the right has more dimensions in common with the symbol in the centre.

Correct answers for some such scenarios are underlined below:
"""

var setshifting_1plus = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at the bottom of the screen if symbol of the left has more dimensions in common with the symbol in the centre.

Press J-key / right 'N-button' at the bottom of the screen if symbol of the right has more dimensions in common with the symbol in the centre.

Correct answers for some such scenarios are underlined below:
"""

var flanker_0a = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key
"""

var flanker_0b = """
To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at bottom if central arrow points left

Press J-key / right 'N-button' at bottom if central arrow points right
"""

var flanker_1plus = """
To drive the car:
Car left: 'D' key or '<-button' at the bottom of the screen
Car right: 'K' key or '->button' at the bottom of the screen
Car back: DOWN ARROW key

To get the fuel, look at the heads-up display and:
Press F-key / left 'N-button' at bottom if central arrow points left

Press J-key / right 'N-button' at bottom if central arrow points right
"""

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.task == "nback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = nback_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = nback_0b
			$"Sprite".visible = true
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = nback_1
			$"Sprite".visible = true
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = nback_2plus + str(global.nBackIP) + nback_2plus_extra
			$"Sprite".visible = true
			$"Sprite2".visible = false
	if global.task == "realnback":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = realnback_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = realnback_0b
			$"Sprite".visible = true
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "1":
			$"RichTextLabel".text = realnback_1
			$"Sprite".visible = true
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = realnback_2plus + str(global.nBackIP) + realnback_2plus_extra
			$"Sprite".visible = false
			$"Sprite2".visible = false
	if global.task == "setshift":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = setshifting_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = setshifting_0b
			$"Sprite".visible = false
			$"Sprite2".visible = true
		else:
			$"RichTextLabel".text = setshifting_1plus
			$"Sprite".visible = false
			$"Sprite2".visible = true
	if global.task == "flanker":
		if global.levelSet[global.task] == "0a":
			$"RichTextLabel".text = flanker_0a
			$"Sprite".visible = false
			$"Sprite2".visible = false
		elif global.levelSet[global.task] == "0b":
			$"RichTextLabel".text = flanker_0b
			$"Sprite".visible = false
			$"Sprite2".visible = false
		else:
			$"RichTextLabel".text = flanker_1plus
			$"Sprite".visible = false
			$"Sprite2".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#print("TASK5 "+str(global.taskIP))
	#print(global.taskIP)
	get_tree().change_scene("res://Main.tscn")
