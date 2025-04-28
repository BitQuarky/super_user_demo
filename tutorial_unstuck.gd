extends Area3D

@onready var player: CharacterBody3D = $"../../../player2"
@onready var dooranim: StaticBody3D = $"../../start2/door/StaticBody3D"
signal unlockall

func _on_body_entered(body: Node3D) -> void:
	if body == player:
		if dooranim.visible == true:
			unlockall.emit()
		visible = false
	
