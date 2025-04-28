extends Camera3D

var player : CharacterBody3D
var tool : Node3D
var xTurn : bool = false
var look : bool = true

var last = Vector2.ZERO
var curr = Vector2.ZERO
signal propagateBinding(key: InputEvent)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent_node_3d()
	tool = get_node("multitool")

#func fixtool() -> void:
#	tool.rotation.y += lerp_angle(tool.rotation.y, deg_to_rad)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if player.get_meta("speed", 1.0) != 0.0:
		if event is InputEventKey and player.get_meta("rebinding"):
			print(event.as_text())
			propagateBinding.emit(event)
			player.set_meta("rebinding", false)
		if event is InputEventMouseMotion:
			curr = event.relative
			if (look and last != curr):
				last = curr
				
				if (tool.rotation.y + (curr.x / -900) < deg_to_rad(100) and tool.rotation.y + (curr.x / -900) > deg_to_rad(80)): 
					tool.rotate_y(curr.x / -900.0)
					xTurn = true
				else:
					if xTurn:
						get_tree().create_tween().tween_property(tool, "rotation", Vector3(0, lerp_angle(tool.rotation.y, deg_to_rad(90), 1), 0), 0.5).set_delay(0.25)
						xTurn = false
			# rotation.y += curr.x / -6000.0
			#rotation.x += curr.y / -6000.0
			#player.rotation.y += curr.x / -6000.0
			#print("%f, %f" % [rotation.y, player.rotation.y])
				get_tree().create_tween().tween_property(player, "rotation", Vector3(0, player.rotation.y + (curr.x / -300), 0), .06)
				if abs(rotation.x + (curr.y / -300.0)) < 1.39626 or sign(curr.y / -300.0) != sign(rotation.x):
					get_tree().create_tween().tween_property(get_node("."), "rotation", Vector3(rotation.x + (curr.y / -200.0), 0, 0), .06)


func _on_aim_toggle_mouse() -> void:
	look = !look
