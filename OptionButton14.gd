extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".add_item("100%")
	$".".add_item("75%")
	$".".add_item("50%")
	$".".add_item("25%")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
