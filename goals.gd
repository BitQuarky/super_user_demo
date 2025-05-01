extends Node3D

var n = 0
@onready var children: Array[Node] = self.get_children()
@onready var player: CharacterBody3D = self.get_parent_node_3d().get_node("player2")

func _process(delta: float) -> void:
	if n < children.size():
		if (children[n].position.distance_to(player.position) < 2.0):
			children[n].visible = false
			n+=1
			children[n].visible = true
		else:
			children[n].modulate.a = max((children[n].position.distance_to(player.position) - 2.0) / 5.0, 0.0)

func _next() -> void:
	n += 1
