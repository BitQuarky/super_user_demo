extends Camera3D

@onready var cam: Camera3D = self.get_parent().get_parent().get_parent().get_parent()

func _process(delta: float) -> void:
	global_position = cam.global_position
	global_rotation = cam.global_rotation
