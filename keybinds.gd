extends PopupMenu

@onready var keybind = get_child(0)
@onready var bind = get_child(1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_about_to_popup() -> void:
	keybind.visible = true
	bind.visible = true
	pass # Replace with function body.

func _on_close_requested() -> void:
	keybind.visible = false
	bind.visible = false
	pass # Replace with function body.
