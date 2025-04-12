extends Node3D

func _ready() -> void:
	self.get_tree().create_tween().tween_callback(tween).set_delay(5.0)
	
func tween() -> void:
	var player: AnimationPlayer = $door/AnimationPlayer
	var player2: AnimationPlayer = $door2/AnimationPlayer
	player.play("open")
	player2.play("open_001")
	self.get_tree().create_tween().tween_callback(unlock).set_delay(1.5)

func unlock() -> void:
	var barrier = $door/StaticBody3D
	barrier.process_mode = Node.PROCESS_MODE_DISABLED
	$door.visible = false
	$door2.visible = false
