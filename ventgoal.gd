extends Area3D

signal advance_goal(goal: int)

@onready var player = self.get_node("../../../player2")

func _on_body_entered(body: Node3D) -> void:
	if body == player:
		advance_goal.emit(3)
		self.visible = false
