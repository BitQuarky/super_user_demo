extends AnimationPlayer

var runmode: bool = false
var model: Node3D
var playercam: Node3D

signal shoot(down: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	model = get_parent()
	playercam = get_parent().get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if runmode and not is_playing():
		play("multitool1_anim/rootAction")
	
func _input(event: InputEvent) -> void:
	model.rotation.z = playercam.rotation.x / 10
	if event is InputEventMouseButton and not runmode:
		play("multitool1_anim/shootAction_001")
		shoot.emit(event.pressed)
		


func _on_player_2_toggle_run() -> void:
	runmode = not runmode
