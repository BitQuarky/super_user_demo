extends Label

var lookingAt: bool = false

func _ready() -> void:
	modulate.a = 0.0

func _process(delta: float) -> void:
	if (lookingAt and modulate.a < 1.0):
		modulate.a += delta * 1.5
	elif modulate.a > 0.0:
		modulate.a -= delta * 1.5

func _on_aim_popup(msg: String) -> void:
	lookingAt = true
	text = msg

func _on_aim_popdown() -> void:
	lookingAt = false
