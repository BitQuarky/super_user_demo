extends Node3D

var n = 0
@onready var children: Array[Node] = self.get_children()
@onready var player: CharacterBody3D = self.get_parent_node_3d().get_node("player2")

func _process(delta: float) -> void:
	if n < children.size():
		#if (children[n].position.distance_to(player.position) < 2.0):
		#	children[n].visible = false
		#	n+=1
		#	children[n].visible = true
		#else:
		var dist = children[n].position.distance_to(player.position)
		children[n].modulate.a = max((dist - 2.0) / 5.0, 0.0)
		children[n].scale = Vector3(dist / 4.0, dist / 4.0, dist / 4.0)

func _next(goal: int) -> void:
	children[n].visible = false
	if goal > n:
		n = goal
	elif goal == -1:
		n += 1
	children[n].visible = true
