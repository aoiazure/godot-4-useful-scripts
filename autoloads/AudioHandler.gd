## A class that handles playing sounds.
extends Node



## Play a specified AudioStream.
func play_sound(path: String) -> void:
	if not ResourceLoader.exists(path):
		return
	var sound: AudioStream = ResourceLoader.load(path) as AudioStream
	var ap: AudioStreamPlayer = AudioStreamPlayer.new()
	get_tree().root.add_child(ap)
	ap.stream = sound
	ap.play()
	await ap.finished

## Play a specified AudioStream positionally in a 2D space.
func play_sound_2d(path: String, position: Vector2) -> void:
	if not ResourceLoader.exists(path):
		return
	var sound: AudioStream = ResourceLoader.load(path) as AudioStream
	var ap: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	get_tree().root.add_child(ap)
	ap.global_position = position
	
	ap.stream = sound
	ap.play()
	await ap.finished

## Play a specified AudioStream positionally in a 3D space.
func play_sound_3d(path: String, position: Vector3) -> void:
	if not ResourceLoader.exists(path):
		return
	var sound: AudioStream = ResourceLoader.load(path) as AudioStream
	var ap: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	get_tree().root.add_child(ap)
	ap.global_position = position
	
	ap.stream = sound
	ap.play()
	await ap.finished




