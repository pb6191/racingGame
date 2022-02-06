extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if global.taskflowDeploy == 0:
		$"RichTextLabel17".visible = true
		$"RichTextLabel18".visible = true
		$"OptionButton17".visible = true
		$"OptionButton18".visible = true
		$"Button".visible = true
		$"Button2".visible = true
	if global.taskflowDeploy == 2:
		$"RichTextLabel19".visible = true
		$"RichTextLabel20".visible = true
		$"OptionButton19".visible = true
		$"LineEdit".visible = true
		$"Button3".visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
