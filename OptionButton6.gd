extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".add_item("2")
	$".".add_item("3")
	$".".add_item("4")
	$".".add_item("5")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
