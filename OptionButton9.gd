extends OptionButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".add_item("0.5")
	$".".add_item("1.0")
	$".".add_item("1.5")
	$".".add_item("2.0")
	$".".add_item("2.5")
	$".".add_item("3.0")
	$".".add_item("3.5")
	$".".add_item("4.0")
	$".".add_item("4.5")
	$".".add_item("5.0")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
