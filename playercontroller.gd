extends CharacterBody3D

var lockmouse = true
var flashlight
var flashon = false
var speed = 10.0
const JUMP_VELOCITY = 4.5
var shape
var crouchtween

signal toggleRun

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	flashlight = get_node("playercam/aim/flashlight")
	shape = get_node("playershape")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		lockmouse = not lockmouse
		if lockmouse:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.is_action_just_pressed("flashlight"):
		flashon = not flashon
		flashlight.visible = flashon
	#Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CONFINED
	#else:
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
func _physics_process(delta: float) -> void:
	# Add the gravity.

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("walk"):
		speed /= 2
		toggleRun.emit()
	elif Input.is_action_just_released("walk"):
		speed *= 2
		toggleRun.emit()
	
	if Input.is_action_just_pressed("crouch"):
		get_tree().create_tween().tween_property(shape.shape, "height", 1.05, .5).set_trans(Tween.TRANS_CUBIC)
		speed /= 1.5
	elif Input.is_action_just_released("crouch"):
		get_tree().create_tween().tween_property(shape.shape, "height", 2.65, .5).set_trans(Tween.TRANS_CUBIC)
		speed *= 1.5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	#print("entered");
	if body == self:
		print($playercam.environment.ambient_light_color)
		get_tree().create_tween().tween_property($playercam.environment, "ambient_light_color", Color(1.0, 0.0, 0.0, 1.0), 1.0)
		#get_tree().create_tween().tween_property($playercam.environment, "fov", 140.0, 1.0).set_ease(Tween.EASE_IN)
		print("self");
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == self:
		get_tree().create_tween().tween_property($playercam.environment, "ambient_light_color", Color(0.0, 0.0, 0.0, 1.0), 1.0)
	pass # Replace with function body.
