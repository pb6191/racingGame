extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var btn = $".".get_close_button()
	btn.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"ViewportContainer".rect_scale.x = $".".rect_size.x / 600
	$"ViewportContainer".rect_scale.y = $".".rect_size.y / 1000
