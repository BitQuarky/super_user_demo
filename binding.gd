extends PopupMenu

var cam
var player
var keybind
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam = get_parent().get_parent().get_parent().get_node("playercam")
	if (cam == null):
		push_error("ERROR: couldn't fetch playercam")
	player = get_parent().get_parent().get_parent()
	keybind = get_parent().get_node("keybind")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_id_pressed(id: int) -> void:
	player.set_meta("rebinding", true)
	var s = await cam.propagateBinding
	var b = keybind.get_item_text(get_item_index(id))
	print("erasing " + b)
	InputMap.erase_action(b)
	InputMap.add_action(b)
	InputMap.action_add_event(b, s)
	set_item_text(get_item_index(id), s.as_text())
	pass # Replace with function body.
