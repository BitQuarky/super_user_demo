extends RayCast3D

signal popup(msg: String)
signal popdown()
signal darken(target: float)
signal toggleMouse()
signal openDoor() #temporary

var shouldEscape = false 
var escaped = false

@onready var player: CharacterBody3D = self.get_parent_node_3d().get_parent_node_3d()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@onready var c : CollisionObject3D = get_collider()
var l : CollisionObject3D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func toggleMove():
	var disableMove = self.get_parent_node_3d().get_parent_node_3d()
	if disableMove.get_meta("jumpScalar") == 1.0:
		disableMove.set_meta("speed", 0.0)
		disableMove.set_meta("jumpScalar", 0.0)
	else:
		disableMove.set_meta("speed", 10.0)
		disableMove.set_meta("jumpScalar", 1.0)		

func _process(delta: float) -> void:
	c = get_collider()
	if (c != null):
		if ((c != l and c.is_in_group("escape")) or (c.is_in_group("escape") and global_position.distance_to(c.global_position) <= 5.0)):
			if (!shouldEscape):
				popup.emit("floor lockdown must be disabled first")
			elif (!escaped):
				print("thanks for playing, please complete the form linked!")
				popup.emit("thanks for playing, please complete the form linked!")
				toggleMove()
				darken.emit(0.785)
				OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLSf4NNF5AhNj8ioEaIZqFIBPcLm66iCMcp48FMv7HqoL5mgu-Q/viewform?usp=sharing")
				toggleMouse.emit()
				escaped = true
		elif ((l != null and l.is_in_group("escape") and not c.is_in_group("escape")) or (c.is_in_group("escape") and global_position.distance_to(c.global_position) > 5.0)):
			popdown.emit()
		l = c

@onready var file: Label = self.get_parent_node_3d().get_parent_node_3d().get_node("file")
@onready var text: Label = self.get_parent_node_3d().get_parent_node_3d().get_node("text")
@onready var prompt: Label = self.get_parent_node_3d().get_parent_node_3d().get_node("prompt")
@onready var shell: Sprite2D = self.get_parent_node_3d().get_parent_node_3d().get_node("Shell")
@onready var viewer: Sprite2D = self.get_parent_node_3d().get_parent_node_3d().get_node("Viewer")

func make_visible(ammount: float, name: String) -> void:
	for node: Sprite2D in self.get_parent_node_3d().get_parent_node_3d().get_node("nodeMaps").get_node(name).get_children():
		node.modulate.a = ammount
		print(node.name)
	file.modulate.a = ammount
	text.modulate.a = ammount
	prompt.modulate.a = ammount
	shell.modulate.a = ammount
	viewer.modulate.a = ammount

var physicsMode = false
var phyobj

func _on_animation_player_2_shoot() -> void:
	if (c == null): 
		print("null!")
	elif (c.is_in_group("teleport")):
		print("teleport!")
		var m : Node3D = c.get_parent_node_3d()
		self.get_tree().create_tween().tween_property(self.get_parent_node_3d().get_parent_node_3d(), "global_position", m.global_position, .5).set_ease(Tween.EASE_IN)
	elif (c.is_in_group("escape")):
		print("escape!")
	elif (c.is_in_group("computer")):
		if c.get_parent_node_3d().name == "escapepc":
			shouldEscape = true
		else:
			get_tree().create_tween().tween_method(make_visible.bind(c.name), 0.0, 1.0, 0.2)
			darken.emit(.85)
			toggleMove()
			toggleMouse.emit()
	elif (c.is_in_group("physicsObject")):
		if !physicsMode:
			phyobj = c.get_parent_node_3d()
			phyobj.reparent(player)
			var tween = get_tree().create_tween()
			tween.tween_property(phyobj, "position", Vector3(0.0, 0.0, -4.0), 0.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
			tween.parallel().tween_property(phyobj, "rotation", Vector3(0.0, -deg_to_rad(90.0), 0.0), 0.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
			physicsMode = !physicsMode
		elif c.get_parent_node_3d() == phyobj:
			phyobj.reparent(player.get_parent_node_3d())
			physicsMode = !physicsMode

	else:
		print(c.name)
	pass # Replace with function body.


func _on_player_2_close_menu() -> void:
	get_tree().create_tween().tween_method(make_visible.bind(c.name), 1.0, 0.0, 0.2)
	darken.emit(.0)
	toggleMove()
	toggleMouse.emit()
	#for now, just unlock the tutorial door after this
	openDoor.emit()	


func _on_timer_timeout() -> void:
	darken.emit(1.0)
	toggleMove()
	toggleMouse.emit()
	popup.emit("detected!")
	get_tree().create_tween().tween_callback(reset).set_delay(1.0)

func reset() -> void:
	player.position = Vector3(0.468, 0.819, -0.333)
	darken.emit(.0)
	toggleMove()
	toggleMouse.emit()
	popdown.emit()
