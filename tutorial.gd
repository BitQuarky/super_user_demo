extends Node3D

signal advance_goal(goal: int)

func _ready() -> void:
	self.get_tree().create_tween().tween_callback(open_first).set_delay(5.0)

func open_first():
	tween(1)
	advance_goal.emit(1)

func tween(door: int) -> void:
	if door == 2:
		advance_goal.emit(2)
	var player: AnimationPlayer = get_node("start" + str(door) + "/door/AnimationPlayer")
	var player2: AnimationPlayer = get_node("start" + str(door) + "/door2/AnimationPlayer")
	player.play("open")
	player2.play("open_001")
	self.get_tree().create_tween().tween_callback(unlock.bind(door)).set_delay(1.5)

func unlock(door: int) -> void:
	var barrier = 	get_node("start" + str(door) + "/door/StaticBody3D")
	barrier.process_mode = Node.PROCESS_MODE_DISABLED
	get_node("start" + str(door) + "/door").visible = false
	get_node("start" + str(door) + "/door2").visible = false

var opened = false

func _on_aim_open_door() -> void:
	if !opened:
		self.get_tree().create_tween().tween_callback(tween.bind(2)).set_delay(0.5)


func _on_area_3d_unlockall() -> void:
	opened = true
	self.get_tree().create_tween().tween_callback(tween.bind(2)).set_delay(0.5)
