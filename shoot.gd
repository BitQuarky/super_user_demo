extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_2_shoot() -> void:
	var c : CollisionObject3D = get_collider()
	if (c == null): 
		print("null!")
	if (c != null and c.is_in_group("teleport")):
		print("teleport!")
		var m : Node3D = c.get_parent_node_3d()
		self.get_tree().create_tween().tween_property(self.get_parent_node_3d().get_parent_node_3d(), "global_position", m.global_position, .5).set_ease(Tween.EASE_IN)
	pass # Replace with function body.
