extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".add_item("30")
	$".".add_item("60")
	$".".add_item("90")
	$".".add_item("120")
	$".".add_item("150")
	$".".add_item("180")
	$".".add_item("210")
	$".".add_item("240")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
