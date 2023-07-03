extends Node

# Screen shake time
signal screen_shake(strength, decay)

# Emitted when Player dies
signal player_died


func shake(strength: float = 20.0, decay: float = 3.0):
	screen_shake.emit(strength, decay)

func hitfreeze(timescale: float, freeze: float) -> void:
	Engine.time_scale = timescale
	await get_tree().create_timer(freeze).timeout
	Engine.time_scale = 1.0