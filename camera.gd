extends MeshInstance3D

func _ready() -> void:
	print("rotate")
	self.get_tree().create_tween().tween_property(self, "rotation", self.rotation + Vector3(0, 1.3, 0), 4.0).set_delay(5.0)
	self.get_tree().create_tween().tween_property(self, "rotation", self.rotation, 4.0).set_delay(10.0)
	self.get_tree().create_tween().tween_callback(_ready).set_delay(15.0)
