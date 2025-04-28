extends ColorRect

var mod = 0.0

func _ready() -> void:
	modulate.a = 0.0

func _process(delta: float) -> void:
	modulate.a = lerp(modulate.a, mod, 0.02)
	#pass

func _on_aim_darken(target: float) -> void:
	mod = target
